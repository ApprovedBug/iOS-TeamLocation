//
//  LocationRow.swift
//  LocationsTest
//
//  Created by ApprovedBug on 25/01/2022
//

import Foundation
import SwiftUI

struct LocationRow: View {
    var viewModel: LocationRowViewModel

    init(viewModel: LocationRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("\(viewModel.latitude)")
            Text("\(viewModel.longitude)")
        }
    }
}
