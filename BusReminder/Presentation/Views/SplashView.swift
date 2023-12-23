//
//  SplashView.swift
//  Locations
//
//  Created by LuanNT29 on 19/12/2023.
//

import SwiftUI
import Lottie

struct SplashView: View {
    @StateObject var locationManager: LocationManager = .init()
    var body: some View {
        NavigationView {
            if ((locationManager.userLocation?.coordinate) != nil) {
                SearchView()
                    .environmentObject(locationManager)
            } else {
                LottieView(url: URL(string: "https://lottie.host/936c8711-79fa-4ed1-9658-4e4e5a4ff29d/OQeVXjwnuQ.json")!)
                    .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(.stack)
    }
}
