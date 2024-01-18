//
//  DirectionsRouteView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 09/01/2024.
//

import SwiftUI

struct DirectionsRouteView: View {
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    @StateObject var directionsRouteViewModel = DirectionsRouteViewModel()
    @StateObject var searchPlacesViewModel = SearchPlaceViewModel()
    
    @State var searchText = ""
    var body: some View {
        ZStack(alignment: .top) {
            if !directionsRouteViewModel.isLoading {
                MapView(directionsRoute: directionsRouteViewModel.directionsRoute ?? DirectionsRoute(routes: []))
                    .environmentObject(locationManager)
                    .ignoresSafeArea()
                makeSearchField()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            if let coordinate = locationManager.userLocation?.coordinate {
                directionsRouteViewModel.getDirectionsRoute(parameters: DirectionsRouteParameters(
                    origin: DirectionsRouteParameters.Location(
                        location: DirectionsRouteParameters.Location.LatLng(
                            latLng: DirectionsRouteParameters.Location.LatLng.Coordinate(
                                latitude: coordinate.latitude,
                                longitude: coordinate.longitude
                            )
                        )
                    )
                ))
            }
        }
    }
}

#Preview {
    DirectionsRouteView()
}
