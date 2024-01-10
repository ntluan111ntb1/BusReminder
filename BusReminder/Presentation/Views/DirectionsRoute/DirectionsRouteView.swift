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
    @StateObject var viewModel = DirectionsRouteViewModel()
    
    @State var search = ""
    var body: some View {
        ZStack(alignment: .top) {
            if !viewModel.isLoading {
                MapView(directionsRoute: viewModel.directionsRoute ?? DirectionsRoute(routes: []))
                    .environmentObject(locationManager)
                    .ignoresSafeArea()
                makeSearchField()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            if let coordinate = locationManager.userLocation?.coordinate {
                viewModel.getDirectionsRoute(parameters: DirectionsRouteParameters(
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
