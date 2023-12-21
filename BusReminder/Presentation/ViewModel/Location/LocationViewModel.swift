//
//  LocationViewModel.swift
//  Locations
//
//  Created by Nguyễn Luân on 20/12/2023.
//

import Foundation
import MapKit

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    var locationsString = ""

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40, longitude: 120),
        span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
    )

    let locationManager = CLLocationManager()

    func requestAllowOnceLocationPermission(){
        locationManager.requestLocation()
    }

    override init() {
        super.init()
        locationManager.delegate = self
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geocoder = CLGeocoder()

        guard let latestLocation = locations.first else {
            return
        }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: latestLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }

        geocoder.reverseGeocodeLocation(latestLocation) { placemarks, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                if let city = placemark.locality,
                   let subLocality = placemark.subLocality,
                   let thoroughfare = placemark.thoroughfare {
                    self.locationsString = "\(city), \(subLocality), \(thoroughfare)"
                } else {
                    print("Location not found")
                }
            } else {
                print("Location not found")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
