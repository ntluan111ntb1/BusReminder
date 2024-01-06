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
            VStack {
                HStack {
                    VStack(spacing: 0) {
                        Image("map")
                            .resizable()
                            .frame(width: 36, height: 36)
                            .background(Color.deepOrange)
                            .clipShape(Circle(), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                            .padding(.top, 20)
                        HStack {
                            Divider()
                        }
                        Image("bus-stop")
                            .resizable()
                            .frame(width: 36, height: 36)
                            .background(Color.deepOrange)
                            .clipShape(Circle(), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 20)
                    }
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("From: Your Location")
                                .fontStyle(.small)
                            Text("123 Nguyễn Phước Nguyên")
                                .fontStyle(.mediumBold)
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 0) {
                            Text("To: Bus Station")
                                .fontStyle(.small)
                            Text("123 Nguyễn Phước Nguyên")
                                .fontStyle(.mediumBold)
                        }
                    }
                    .foregroundColor(.deepBlue)
                    Button {
                        isShowMapView = true
                    } label: {
                        Image("bus-stop (1)")
                            .resizable()
                            .frame(width: 36, height: 36)
                            .frame(height: 120)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.deepBlue,
                                            Color.deepBlue.opacity(0.5)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)
                                    )
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.deepBlue, lineWidth: 1)
                            }
                    }
                }
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.lightBlue.opacity(0.5))
                }
                .frame(width: .infinity, height: 160)
                Spacer()
            }
            .padding()
            .frame(width: UIScreen.screenWidth)
        }
//        .navigationDestination(isPresented: $isShowMapView) {
//            BusStopLocationsView()
//                .environmentObject(locationManager)
//        }
    }
}

#Preview {
    HomeView()
}
