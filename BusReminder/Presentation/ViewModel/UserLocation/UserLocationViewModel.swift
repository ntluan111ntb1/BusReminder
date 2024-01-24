//
//  UserLocationViewModel.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 24/01/2024.
//

import Foundation
import GoogleMaps

final class UserLocationViewModel: ObservableObject {
    @Published var street = "_"
    @Published var city = "_"
    let gmsGeocoder = GMSGeocoder()
    func getAddess(coordinate: CLLocationCoordinate2D) {
        gmsGeocoder.reverseGeocodeCoordinate(
            CLLocationCoordinate2D(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )
        ) { response, error in
            self.street = response?.firstResult()?.thoroughfare ?? "_"
            self.city = response?.firstResult()?.administrativeArea ?? "_"
        }
    }
}
