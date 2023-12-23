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
    @Binding var busStopLocations: BusStopLocations
    @Binding var isShowListBusStop: Bool
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
        mapView.delegate = context.coordinator
        return mapView
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(busStopLocations: busStopLocations, isShowListBusStop: $isShowListBusStop)
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        /// MARK: add icons Bus Stop to Map
        context.coordinator.addMarkets(mapView: uiView)
    }
}
