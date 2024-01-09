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
    let directionsRoute: DirectionsRoute
    
    init(
        coordinate: CLLocationCoordinate2D,
        _ mapView: MapView,
        directionsRoute: DirectionsRoute
    ) {
        self.coordinate = coordinate
        self.parent = mapView
        self.directionsRoute = directionsRoute
    }
    
    func addDirectionsRoutes(mapView: GMSMapView) {
        directionsRoute.routes.forEach { route in
            let part = GMSPath.init(fromEncodedPath: route.legs.first?.polyline.encodedPolyline ?? "")
            let polyline = GMSPolyline.init(path: part)
            polyline.strokeColor = .green
            polyline.strokeWidth = 4
            polyline.map = mapView
        }
    }

}
