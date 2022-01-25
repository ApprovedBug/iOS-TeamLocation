//
//  LocationMO.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import CoreData

final class LocationMO: NSManagedObject {

    @NSManaged var id: Int16
    @NSManaged var adId: UUID
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}

extension LocationMO {
    func convertToLocation() -> Location {
        Location(
            id: id,
            adId: adId,
            coordinate: Location.Coordinate(longitude: longitude, latitude: latitude)
        )
    }
}
