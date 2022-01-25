//
//  LocationsFetcherMock.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import Foundation
import Combine

struct LocationsFetcherMock: LocationFetchable {
    func locations() -> AnyPublisher<[Location], LocationError> {

        var locations: [Location] = []

        for index in 0..<10 {
            let location = Location(
                id: Int16(index),
                adId: UUID(),
                coordinate: Location.Coordinate(
                    longitude: 0.01232424,
                    latitude: 51.2098362
                )
            )

            locations.append(location)
        }

        return Just(locations)
            .mapError { error in
                .network(description: "Network error")
            }.eraseToAnyPublisher()
    }
}
