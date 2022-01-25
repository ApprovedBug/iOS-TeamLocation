//
//  LocationMO.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import CoreData

extension LocationMO {

    static var all: NSFetchRequest<LocationMO> {
        let request = LocationMO.fetchRequest()
        request.sortDescriptors = []
        return request
    }
    
    func convertToLocation() -> Location {
        Location(
            id: id,
            adId: adId ?? UUID(),
            coordinate: Location.Coordinate(longitude: longitude, latitude: latitude)
        )
    }
}
