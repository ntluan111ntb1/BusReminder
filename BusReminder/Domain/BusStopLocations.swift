//
//  BusStopLocations.swift
//  Locations
//
//  Created by LuanNT29 on 20/12/2023.
//

import Foundation
import GoogleMaps

struct GeometryDomain {
    let location: CLLocationCoordinate2D
}

struct ResultDomain: Identifiable {
    let id = UUID()
    let geometry: GeometryDomain
    let address: String
    let ward: String
}

struct BusStopLocations {
    var results: [ResultDomain]
}
