//
//  Location.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import Foundation

struct Location: Decodable {
    var id: Int16
    var adId: UUID
    var coordinate: Coordinate

    struct Coordinate: Decodable {
        var longitude: Double
        var latitude: Double

        enum CodingKeys: String, CodingKey {
            case longitude = "x"
            case latitude = "y"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case adId = "ad_id"
        case coordinate = "location"
    }
}
