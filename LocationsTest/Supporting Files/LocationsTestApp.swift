//
//  LocationsTestApp.swift
//  LocationsTest
//
//  Created by ApprovedBug on 24/01/2022
//

import SwiftUI

@main
struct LocationsTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let fetcher = LocationFetcher()
            let viewModel = LocationsViewModel(
                locationFetcher: fetcher,
                viewContext: persistenceController.container.viewContext
            )
            LocationsView(viewModel: viewModel)
        }
    }
}
