//
//  DirectionsRouteView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 09/01/2024.
//

import SwiftUI

struct DirectionsRouteView: View {
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = DirectionsRouteViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            MapView()
                .environmentObject(locationManager)
                .ignoresSafeArea()
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
