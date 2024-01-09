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
            guard let coordinate = locationManager.userLocation?.coordinate {
                viewModel.getDirectionsRoute(parameters: DirectionsRouteParameters())
            }
        }
    }
}

#Preview {
    DirectionsRouteView()
}
