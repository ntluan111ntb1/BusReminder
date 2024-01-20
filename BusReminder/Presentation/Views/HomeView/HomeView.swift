//
//  HomeView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    // Init ViewModel
    @StateObject var weatherViewModel = WeatherViewModel()
    @StateObject var searchPlacesViewModel = SearchPlaceViewModel()
    @StateObject var directionsRouteViewModel = DirectionsRouteViewModel()
    
    @State var searchText = "Hyatt Regency San Francisco"
    @State var destination = SearchPlace.Place.Location(latitude: 0, longitude: 0)
    @State var isShowMapView = false
    @State var isShowSearchView = false
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
            VStack {
                makeSearchField()
                    .padding(.top)
                List(searchPlacesViewModel.searchPlace.places) { place in
                    Button {
                        destination = place.location
                        isShowSearchView.toggle()
                        isShowMapView.toggle()
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
    }
}

#Preview {
    HomeView()
}
