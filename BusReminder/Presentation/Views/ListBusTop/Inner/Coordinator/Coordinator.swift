//
//  Coordinator.swift
//  Locations
//
//  Created by Nguyễn Luân on 20/12/2023.
//

import Foundation
import GoogleMaps

class Coordinator: NSObject {
    let busStopLocations: BusStopLocations
    
    init(busStopLocations: BusStopLocations) {
        self.busStopLocations = busStopLocations
    }
    
    func addMarkets(mapView: GMSMapView) {
        let marketView = UIImageView(
            image: UIImage(systemName: "bus")!
                .withRenderingMode(.alwaysTemplate)
        )
        mapView.tintColor = .red
        busStopLocations.results.forEach { busStopLocation in
            let market = GMSMarker()
            market.position = busStopLocation.geometry.location
            market.title = busStopLocation.address
            market.snippet = busStopLocation.ward
            market.iconView = marketView
            market.appearAnimation = .pop
            market.isTappable

            market.map = mapView
        }
    }

    func moveCamera(mapView: GMSMapView) {
        let camera = GMSCameraPosition.camera(withLatitude: 16.048885997815244, longitude: 108.18646274789408, zoom: 15)
        mapView.camera = camera
    }
}
