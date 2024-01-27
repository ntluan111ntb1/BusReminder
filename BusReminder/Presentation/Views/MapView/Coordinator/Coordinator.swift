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
            if let leg = route.legs.first {
                leg.steps.forEach({ step in
                    let part = GMSPath.init(fromEncodedPath: step.polyline.encodedPolyline)
                    let polyline = GMSPolyline.init(path: part)
                    if step.travelMode == "WALK" {
                        showWalkPath(polyStr: step.polyline.encodedPolyline, mapView: mapView)
                    } else {
                        polyline.strokeColor = UIColor.deepBlue
                        polyline.strokeWidth = 6
                        polyline.map = mapView
                    }
                })
                mapView.cameraTargetBounds = GMSCoordinateBounds(
                    coordinate: CLLocationCoordinate2D(latitude: leg.startLocation.latLng.latitude, longitude: leg.startLocation.latLng.longitude),
                    coordinate: CLLocationCoordinate2D(latitude: leg.endLocation.latLng.latitude, longitude: leg.endLocation.latLng.longitude)
                )
                print("max zoom: \(mapView.maxZoom)")
                print("max zoom: \(mapView.minZoom)")
            }
        }

    }

    func showWalkPath(polyStr: String, mapView: GMSMapView) {
        guard let path = GMSPath(fromEncodedPath: polyStr) else { return }

        let circleRadius: CLLocationDistance = 3
        let intervalDistance: CLLocationDistance = 10

        var previousCircle: GMSCircle?

        for coordinateIndex in 0 ..< path.count() - 1 {
            let startCoordinate = path.coordinate(at: coordinateIndex)
            let endCoordinate = path.coordinate(at: coordinateIndex + 1)
            let startLocation = CLLocation(latitude: startCoordinate.latitude, longitude: startCoordinate.longitude)
            let endLocation = CLLocation(latitude: endCoordinate.latitude, longitude: endCoordinate.longitude)
            let pathDistance = endLocation.distance(from: startLocation)

            let intervalLatIncrement = (endLocation.coordinate.latitude - startLocation.coordinate.latitude) / pathDistance
            let intervalLngIncrement = (endLocation.coordinate.longitude - startLocation.coordinate.longitude) / pathDistance

            for intervalDistance in stride(from: 0, through: pathDistance, by: intervalDistance) {
                let intervalLat = startLocation.coordinate.latitude + (intervalLatIncrement * Double(intervalDistance))
                let intervalLng = startLocation.coordinate.longitude + (intervalLngIncrement * Double(intervalDistance))
                let circleCoordinate = CLLocationCoordinate2D(latitude: intervalLat, longitude: intervalLng)

                let circle = GMSCircle(position: circleCoordinate, radius: circleRadius)
                circle.strokeWidth = 1.0
                circle.strokeColor = UIColor.black
                circle.fillColor = UIColor.skyBlue
                circle.map = mapView

                if let previousCircle = previousCircle {
                    let circleLocation = CLLocation(latitude: circleCoordinate.latitude, longitude: circleCoordinate.longitude)
                    let previousCircleLocation = CLLocation(latitude: previousCircle.position.latitude, longitude: previousCircle.position.longitude)

                    if mapView.projection.points(forMeters: circleLocation.distance(from: previousCircleLocation), at: mapView.camera.target) < intervalDistance {
                        continue
                    }
                }

                previousCircle = circle
            }
        }
    }
}
