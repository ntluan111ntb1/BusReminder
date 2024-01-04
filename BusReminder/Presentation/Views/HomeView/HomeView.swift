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
    
    var body: some View {
        makeWeatherView()
            .padding(.horizontal)
        .onAppear{
            if let coordinate = locationManager.userLocation?.coordinate {
                weatherViewModel.getWeather(parameters: WeatherParamters(
                    lat: "\(coordinate.latitude)",
                    lon: "\(coordinate.latitude)")
                )
            }
        }
    }
}

#Preview {
    HomeView()
}
