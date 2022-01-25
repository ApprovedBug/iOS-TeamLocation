//
//  LocationsViewModel.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import SwiftUI
import Combine

class LocationsViewModel: ObservableObject, Identifiable {

    @Published var locations: [LocationRowViewModel] = []

    private let locationFetcher: LocationFetchable
    private var disposables = Set<AnyCancellable>()

    init(locationFetcher: LocationFetchable) {
        self.locationFetcher = locationFetcher

        fetchLocations()
    }
}

extension LocationsViewModel {

    func fetchLocations() {

        locationFetcher.locations()
            .map { response in
                response.map(LocationRowViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.locations = []
                    case .finished:
                        break
                    }
                },
                receiveValue: {[weak self] locations in
                    guard let self = self else { return }

                    self.locations = locations
                }
            )
            .store(in: &disposables)
    }
}
