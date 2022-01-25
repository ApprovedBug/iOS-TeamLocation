//
//  AppDelegate.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NetworkMonitor.shared.startMonitoring()
        return true
    }
}
