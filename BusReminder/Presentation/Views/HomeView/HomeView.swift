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
    @StateObject var directionsRouteViewModel = DirectionsRouteViewModel()
    
    @State var searchText = ""
    @State var isShowMapView = false
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
            VStack(alignment: .leading) {
                makeDirectionToBusStop()
                //To Do
                Button {
                    directionsRouteViewModel.getDirectionsRoute(parameters: DirectionsRouteParameters())
                } label: {
                    Text("GET directions Route")
                        .fontStyle(.largeBold)
                        .padding(8)
                        .background {
                            RoundedCornersShape(corners: .allCorners, radius: 12)
                                .fill(Color.deepBlue)
                        }
                }
                Spacer()
            }
            .padding()
            .frame(width: UIScreen.screenWidth)
        }
        .navigationDestination(isPresented: $isShowMapView) {
            BusStopLocationsView()
                .environmentObject(locationManager)
        }
    }
}

#Preview {
    HomeView()
}
