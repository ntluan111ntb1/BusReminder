//
//  LocationManager.swift
//  Locations
//
//  Created by LuanNT29 on 06/11/2023.
//

import SwiftUI
import CoreFoundation
import MapKit
//MARK: Combine framework to watch Textfield change
import Combine

class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()

    //MARK: Search bar text
    @Published var searchText = ""
    var cancellable: AnyCancellable?
    @Published var fetchedPlaces: [CLPlacemark]?

    // MARK: User Location
    @Published var userLocation: CLLocation?

    // MARK: final Location
    @Published var pickedLocation: CLLocation?
    @Published var pickedPlaceMark: CLPlacemark?
    override init() {
        super.init()
        manager.delegate = self
        mapView.delegate = self

        //MARK: Requesting location Access
        manager.requestWhenInUseAuthorization()

        //MARK: Search Textfield Watching
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != "" {
                    self.fetchPlaces(value: value)
                } else {
                    self.fetchedPlaces = nil
                }
            })
    }

    //MARK: Phương thức chính tìm kiếm Place dựa trên giá trị truyền vào ở đây là searchText
    func fetchPlaces(value: String) {
        // Task: thực hiện cv không đồng bộ mà không làm đóng băng app -> tìm kiếm place mà không làm ảnh hưởng đến giao diện người dùng
        Task {
            do {
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()

                let response = try await MKLocalSearch(request: request).start()

                // We can alse use Mainactor to publish changes in main thread
                await MainActor.run(body: {
                    self.fetchedPlaces = response.mapItems.compactMap({ item -> CLPlacemark? in
                        return item.placemark
                    })
                })
            } catch {
                print("error fetchPlace")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Error
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currenLocation = locations.last else { return }
        self.userLocation = currenLocation
    }

    //MARK: Location Authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            manager.requestLocation()
        case .authorizedWhenInUse:
            manager.requestLocation()
        case .denied:
            handleLocationError()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            ()
        }
    }

    func handleLocationError() {}

    // MARK: Add Draggable Pin to MapView

    func addDraggablePin(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate

        mapView.addAnnotation(annotation)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DELIVERYPIN")
        marker.isDraggable = true
        marker.canShowCallout = true

        return marker
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        guard let newLocation = view.annotation?.coordinate else { return }

        self.pickedLocation = .init(CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude))
        updatePlacemark(location: .init(latitude: newLocation.latitude, longitude: newLocation.longitude))
    }

    func updatePlacemark(location: CLLocation) {
        Task {
            do {
                guard let place = try await reverseLocationCoordinates(location: location) else { return }
                await MainActor.run(body: {
                    self.pickedPlaceMark = place
                })
            }
            catch { }
        }
    }

    // MARK: Displaying New Location Data
    func reverseLocationCoordinates(location: CLLocation) async throws -> CLPlacemark? {
        let place = try await CLGeocoder().reverseGeocodeLocation(location).first
        return place
    }

    // MARK: remove Place Mark
    func removePicker() {
        pickedLocation = nil
        pickedPlaceMark = nil
        mapView.removeAnnotations(mapView.annotations)
    }
}
