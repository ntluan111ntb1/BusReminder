//
//  DirectionsRouteView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 09/01/2024.
//

import SwiftUI
import GoogleMaps

struct DirectionsRouteView: View {
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    @StateObject var directionsRouteViewModel: DirectionsRouteViewModel
    @Binding var coordinate: CLLocationCoordinate2D
    
    let destination: SearchPlace.Place.Location
    @State var camera = GMSCameraPosition()
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if !directionsRouteViewModel.isLoading {
                MapView(
                    camera: $camera, 
                    directionsRoute: directionsRouteViewModel.directionsRoute
                )
                .environmentObject(locationManager)
                .ignoresSafeArea()
                VStack {
                    Button {
                        camera = GMSCameraPosition(
                            latitude: coordinate.latitude,
                            longitude: coordinate.longitude,
                            zoom: 25
                        )
                    } label: {
                        Image(systemName: "location.circle.fill")
                            .font(.largeTitle)
                    }
                }
                .padding(.trailing, 16)
                .padding(.bottom, 40)

            } else {
                ProgressView()
            }
        }
        .onAppear {
            directionsRouteViewModel.getDirectionsRoute(parameters: DirectionsRouteParameters(
                origin: DirectionsRouteParameters.Location(
                    location: DirectionsRouteParameters.Location.LatLng(
                        latLng: DirectionsRouteParameters.Location.LatLng.Coordinate(
                            latitude: coordinate.latitude,
                            longitude: coordinate.longitude
                        )
                    )
                ),
                destination: DirectionsRouteParameters.Location(
                    location: DirectionsRouteParameters.Location.LatLng(
                        latLng: DirectionsRouteParameters.Location.LatLng.Coordinate(
                            latitude: destination.latitude,
                            longitude: destination.longitude)
                    )
                )
            ))
            camera = GMSCameraPosition.camera(
                withLatitude: coordinate.latitude,
                longitude: coordinate.longitude,
                zoom: 15
            )
        }
    }
}

