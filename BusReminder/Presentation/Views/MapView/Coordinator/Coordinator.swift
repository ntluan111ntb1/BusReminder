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
            route.legs.first?.steps.forEach({ step in
                let part = GMSPath.init(fromEncodedPath: step.polyline.encodedPolyline)
                print("Polyline: \(route.legs.first?.steps.first?.polyline.encodedPolyline ?? "")")
                let polyline = GMSPolyline.init(path: part)
                polyline.strokeColor = step.travelMode == "WALK" ? .red : .green
                polyline.strokeWidth = 6
                polyline.map = mapView
            })
        }
    }
}
