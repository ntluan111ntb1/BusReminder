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
    @StateObject var searchPlacesViewModel = SearchPlaceViewModel()

    @State var destination = SearchPlace.Place.Location(latitude: 0, longitude: 0)
    @State var isShowMapView = false
    @State var isShowSearchView = false
    @State var userAddrss = ""
    
    @State var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        ScrollView {
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
            ButtonFullWidthView(lable: "Open Map", color: .deepBlue, foregroundColor: .white) {
                isShowMapView.toggle()
            }
            .padding(.horizontal)
        }
        .navigationDestination(isPresented: $isShowMapView) {
            DirectionsRouteView(
                directionsRouteViewModel: directionsRouteViewModel,
                coordinate: $coordinate, 
                destination: destination
            )
                .environmentObject(locationManager)
        }
        .sheet(isPresented: $isShowSearchView, content: {
            SearchView(searchPlacesViewModel: searchPlacesViewModel) { destination in
                self.destination = destination
                isShowSearchView.toggle()
                isShowMapView.toggle()
            }
            .padding(.top)
        })
        .onAppear {
            userLocationViewModel.getAddess(coordinate: coordinate)
        }
        .onAppear {
            print("===> \(directionsRouteViewModel.directionsRoute.routes)")
        }
    }
}
