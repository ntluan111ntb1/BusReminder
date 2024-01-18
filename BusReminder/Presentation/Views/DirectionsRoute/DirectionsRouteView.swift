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
    @State private var isSheetPresented = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if !directionsRouteViewModel.isLoading {
                MapView(
                    directionsRoute: directionsRouteViewModel.directionsRoute
                    ?? DirectionsRoute(routes: [])
                )
                .environmentObject(locationManager)
                .ignoresSafeArea()
                .sheet(isPresented: $isSheetPresented, content: {
                    VStack {
                        makeSearchField()
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.visible)
                            .padding(.top)
                        //.interactiveDismissDisabled(true)
                        List(searchPlacesViewModel.searchPlace.places) { place in
                            Button {
                                isSheetPresented.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "location.north.circle")
                                        .font(.title3)
                                    Text(place.displayName.text)
                                        .fontStyle(.medium)
                                }
                            }
                        }
                        .listStyle(.inset)
                    }
                })
                Button {
                    isSheetPresented.toggle()
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.system(size: 45))
                        .foregroundColor(Color.deepBlue)
                }
                .padding(20)
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
