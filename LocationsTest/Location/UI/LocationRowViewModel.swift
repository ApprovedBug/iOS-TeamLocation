//
//  LocationRowViewModel.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import Foundation
import SwiftUI

struct LocationRowViewModel: Identifiable {
    private let item: Location

    var id: Int16 {
        return item.id
    }

    var latitude: String {
        return String(item.coordinate.latitude)
    }

    var longitude: String {
        return String(item.coordinate.longitude)
    }

    init(item: Location) {
        self.item = item
    }
}
