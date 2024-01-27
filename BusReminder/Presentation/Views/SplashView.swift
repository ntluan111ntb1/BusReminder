//
//  SplashView.swift
//  Locations
//
//  Created by LuanNT29 on 19/12/2023.
//

import SwiftUI
import Lottie
import GoogleMaps

struct SplashView: View {
    @StateObject var locationManager: LocationManager = .init()
    var body: some View {
        NavigationStack {
            if let coordinate = locationManager.userLocation?.coordinate {
                HomeView(coordinate: coordinate)
                    .environmentObject(locationManager)
            } else {
                LottieView(url: URL(string: "https://lottie.host/936c8711-79fa-4ed1-9658-4e4e5a4ff29d/OQeVXjwnuQ.json")!)
                    .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(.automatic)
    }
}
