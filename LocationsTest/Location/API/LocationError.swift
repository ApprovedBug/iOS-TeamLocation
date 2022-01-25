//
//  LocationError.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import Foundation

enum LocationError: Error {
    case parsing(description: String)
    case network(description: String)
}
