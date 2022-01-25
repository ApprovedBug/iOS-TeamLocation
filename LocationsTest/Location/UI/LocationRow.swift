//
//  LocationRow.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import Foundation
import SwiftUI

struct LocationRow: View {
    private(set) var viewModel: LocationRowViewModel

    init(viewModel: LocationRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.latitude)")
            Text("\(viewModel.longitude)")
        }.padding()
    }
}

struct LocationRow_Previews: PreviewProvider {

    static var previews: some View {
        let locationCoordinate = Location.Coordinate(
            longitude: 0.122321,
            latitude: 51.237129
        )

        let location = Location(
            id: 1,
            adId: UUID(),
            coordinate: locationCoordinate
        )

        let viewModel = LocationRowViewModel(item: location)

        LocationRow(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
