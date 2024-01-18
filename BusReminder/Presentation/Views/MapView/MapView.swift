//
//  MapView.swift
//  Locations
//
//  Created by LuanNT29 on 21/12/2023.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    typealias UIViewType = GMSMapView

    @EnvironmentObject var locationManager: LocationManager
    var directionsRoute: DirectionsRoute
    @State var place: SearchPlace.Place.Location?

    /// Mark: Create Map View
    /// Add user location view
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView.init()
        if let coordinate = locationManager.userLocation?.coordinate {
            let camera = GMSCameraPosition.camera(
                withLatitude: coordinate.latitude,
                longitude: coordinate.longitude,
                zoom: 15
            )
            mapView.camera = camera
            mapView.isMyLocationEnabled = true
        }
        do {
            if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find MapStyle.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        if let place = place {
            context.coordinator.addDirectionsRoutes(mapView: mapView)
        }
        return mapView
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(
            coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 10),
            self,
            directionsRoute: directionsRoute 
        )
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
    }
}
