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
        parent.isShowListBusStop = true
        parent.viewModel.getDirections(parameters: DirectionsPrameter())
        parent.busStopInfo = ResultDomain(
            geometry: GeometryDomain(
                location: CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude)
            ),
            address: marker.title ?? "",
            ward: marker.snippet ?? ""
        )
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
    var parent: MapView
    
    init(
        busStopLocations: BusStopLocations,
        isShowListBusStop: Binding<Bool>,
        _ mapView: MapView
    ) {
        self.busStopLocations = busStopLocations
        self._isShowListBusStop = isShowListBusStop
        self.parent = mapView
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
