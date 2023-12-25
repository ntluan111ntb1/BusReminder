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
        let directionsGroup = DispatchGroup()
        directionsGroup.enter()

        parent.viewModel.getDirections(
            parameters: DirectionsPrameter(
                origin: "\(coordinate.latitude),\(coordinate.longitude)",
                destination: "\(marker.position.latitude),\(marker.position.longitude)"
            ),
            directionsGroup: directionsGroup)
        directionsGroup.notify(queue: .main) { [weak self] in
            // Chỉ thực hiện các dòng code dưới khi nhận được giá trị từ getDirections
            guard let self = self else { return }
            self.parent.viewModel.directions.routes.forEach { route in
                let part = GMSPath.init(fromEncodedPath: route.overviewPolyline.points)
                let polyline = GMSPolyline.init(path: part)
                polyline.strokeColor = .green
                polyline.strokeWidth = 4
                polyline.map = mapView
            }

            self.parent.busStopInfo = ResultDomain(
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
        }

        return true
    }
}

class Coordinator: NSObject {
    let busStopLocations: BusStopLocations
    let coordinate: CLLocationCoordinate2D
    @Binding var isShowListBusStop: Bool // Use @Binding here
    var parent: MapView
    
    init(
        busStopLocations: BusStopLocations,
        isShowListBusStop: Binding<Bool>,
        coordinate: CLLocationCoordinate2D,
        _ mapView: MapView
    ) {
        self.busStopLocations = busStopLocations
        self._isShowListBusStop = isShowListBusStop
        self.coordinate = coordinate
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
