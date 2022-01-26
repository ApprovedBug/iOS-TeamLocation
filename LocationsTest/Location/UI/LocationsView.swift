//
//  LocationsView.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import SwiftUI
import CoreData

struct LocationsView: View {
    @ObservedObject private(set) var viewModel: LocationsViewModel

    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loaded(let locations):
                VStack(alignment: .leading) {
                    List(locations) { location in
                        LocationRow(viewModel: location)
                    }
                }
                .navigationBarTitle(Text("Locations"), displayMode: .inline)
            case .failed(let error):
                Text("Error loading content - \(error.localizedDescription)")
            case .idle, .loading:
                ProgressView().onAppear(perform: self.viewModel.fetchLocations)
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LocationsViewModel(
            locationFetcher: LocationsFetcherMock(),
            viewContext: PersistenceController.preview.container.viewContext
        )
        LocationsView(viewModel: viewModel)
    }
}
