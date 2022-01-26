//
//  LocationMO.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import CoreData

extension LocationMO: BaseModel {

    static var all: NSFetchRequest<LocationMO> {
        let request = LocationMO.fetchRequest()
        request.sortDescriptors = []
        return request
    }

    static func contains(withId id: Int16) -> Bool {
        let request = LocationMO.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.sortDescriptors = []

        do {
            let fetchResults = try viewContext.count(for: request)
            return fetchResults > 0
        } catch {
            fatalError("Counting LocationMO failed - \(error.localizedDescription)")
        }
    }
    
    func convertToLocation() -> Location {
        Location(
            id: id,
            adId: adId ?? UUID(),
            coordinate: Location.Coordinate(longitude: longitude, latitude: latitude)
        )
    }
}
