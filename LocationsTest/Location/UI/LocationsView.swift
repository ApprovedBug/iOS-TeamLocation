//
//  LocationsView.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import SwiftUI

struct LocationsView: View {
    @ObservedObject private(set) var viewModel: LocationsViewModel

    init(viewModel: LocationsViewModel){
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List(viewModel.locations) { location in
                LocationRow(viewModel: location)
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LocationsViewModel(locationFetcher: LocationsFetcherMock())
        LocationsView(viewModel: viewModel).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
