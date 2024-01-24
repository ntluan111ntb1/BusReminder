//
//  HomeView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import SwiftUI
import GoogleMaps

struct HomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    // Init ViewModel
    @StateObject var weatherViewModel = WeatherViewModel()
    @StateObject var directionsRouteViewModel = DirectionsRouteViewModel()
    @StateObject var userLocationViewModel = UserLocationViewModel()
    
    @State var destination = SearchPlace.Place.Location(latitude: 0, longitude: 0)
    @State var isShowMapView = false
    @State var isShowSearchView = false
    @State var userAddrss = ""
    
    var coordinate: CLLocationCoordinate2D {
        if let coordinate = locationManager.userLocation?.coordinate {
            return coordinate
        }
        return CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417)
    }
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                Image("top-banner")
                    .resizable()
                    .frame(height: 150)
                VStack {
                    makeWeatherView()
                        .padding(.horizontal)
                }
            }
            makeSearchButton()
            VStack(alignment: .leading) {
                makeDirectionToBusStop()
                Spacer()
            }
            .padding()
            .frame(width: UIScreen.screenWidth)
        }
        .navigationDestination(isPresented: $isShowMapView) {
            DirectionsRouteView(destination: destination)
                .environmentObject(locationManager)
        }
        .sheet(isPresented: $isShowSearchView, content: {
            SearchView() { destination in
                self.destination = destination
                isShowSearchView.toggle()
                isShowMapView.toggle()
            }
            .padding(.top)
        })
        .onAppear {
            userLocationViewModel.getAddess(coordinate: coordinate)
        }
    }
}
