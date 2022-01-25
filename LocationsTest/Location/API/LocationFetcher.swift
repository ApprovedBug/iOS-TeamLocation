//
//  LocationFetcher.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import Foundation
import Combine

protocol LocationFetchable {
    func locations() -> AnyPublisher<[Location], LocationError>
}

class LocationFetcher {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension LocationFetcher: LocationFetchable {
    func locations() -> AnyPublisher<[Location], LocationError> {
        guard let url = makeLocationsComponents().url else {
            let error = LocationError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}

private extension LocationFetcher {
    struct LocationAPI {
        static let scheme = "https"
        static let host = "cryptic-tor-99753.herokuapp.com"
        static let path = "/api/locations"
    }

    func makeLocationsComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = LocationAPI.scheme
        components.host = LocationAPI.host
        components.path = LocationAPI.path
        return components
    }
}
