//
//  LocationsViewModel.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import SwiftUI
import Combine
import CoreData

class LocationsViewModel: ObservableObject, Identifiable {

    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([LocationRowViewModel])
    }

    @Published private(set) var state = State.idle

    private let locationFetcher: LocationFetchable
    private let viewContext: NSManagedObjectContext
    private let fetchedResultsController: NSFetchedResultsController<LocationMO>
    private var disposables = Set<AnyCancellable>()

    init(
        locationFetcher: LocationFetchable,
        viewContext: NSManagedObjectContext
    ) {
        self.locationFetcher = locationFetcher
        self.viewContext = viewContext
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: LocationMO.all,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
    }
}

extension LocationsViewModel {

    func fetchLocations() {

        state = .loading

        if NetworkMonitor.shared.isReachable {
            fetchLocationFromAPI()
        } else {
            fetchLocationsFromCache()
        }
    }

    private func fetchLocationFromAPI() {

        locationFetcher.locations()
            .map { response in
                response.map(LocationRowViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure(let error):
                        self.state = .failed(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: {[weak self] locations in
                    guard let self = self else { return }

                    self.state = .loaded(locations)
                }
            )
            .store(in: &disposables)
    }

    private func fetchLocationsFromCache() {
        do {
            try fetchedResultsController.performFetch()

            guard let locations = fetchedResultsController.fetchedObjects else {
                return
            }

            self.state = .loaded(locations.map { LocationRowViewModel.init(item: $0.convertToLocation()) })
        } catch {
            self.state = .failed(error)
        }
    }
}
