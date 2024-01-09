//
//  Coordinator.swift
//  Locations
//
//  Created by Nguyễn Luân on 20/12/2023.
//

import Foundation
import GoogleMaps
import SwiftUI

class Coordinator: NSObject {
    let coordinate: CLLocationCoordinate2D
    var parent: MapView
    
    init(
        coordinate: CLLocationCoordinate2D,
        _ mapView: MapView
    ) {
        self.coordinate = coordinate
        self.parent = mapView
    }

}
