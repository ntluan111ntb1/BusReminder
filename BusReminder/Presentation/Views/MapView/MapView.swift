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
    @Binding var camera: GMSCameraPosition
    var directionsRoute: DirectionsRoute
    
    /// Mark: Create Map View
    /// Add user location view
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView.init()
        makeUserLocation(mapView: mapView)
        makeMapStyle(mapView: mapView)
        context.coordinator.addDirectionsRoutes(mapView: mapView)
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
        uiView.camera = camera
    }
    
    func makeMapStyle(mapView: GMSMapView) {
        do {
            if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find MapStyle.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    func makeUserLocation(mapView: GMSMapView) {
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
    }
}
