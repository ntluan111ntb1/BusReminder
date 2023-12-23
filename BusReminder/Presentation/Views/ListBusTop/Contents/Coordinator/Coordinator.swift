//
//  Coordinator.swift
//  Locations
//
//  Created by Nguyễn Luân on 20/12/2023.
//

import Foundation
import GoogleMaps
import SwiftUI

extension Coordinator: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        // Đã nhấn vào marker, bạn có thể xử lý logic ở đây
        isShowListBusStop = true
        let camera = GMSCameraPosition.camera(
            withLatitude: marker.position.latitude,
            longitude: marker.position.longitude,
            zoom: 15
        )
        mapView.animate(to: camera)
        return true
    }
}

class Coordinator: NSObject {
    let busStopLocations: BusStopLocations
    @Binding var isShowListBusStop: Bool // Use @Binding here

    init(busStopLocations: BusStopLocations, isShowListBusStop: Binding<Bool>) {
        self.busStopLocations = busStopLocations
        self._isShowListBusStop = isShowListBusStop // Use the underscore to access the binding
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
            market.map = mapView
        }
    }
}
