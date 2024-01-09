//
//  HomeView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var weatherViewModel = WeatherViewModel()
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
