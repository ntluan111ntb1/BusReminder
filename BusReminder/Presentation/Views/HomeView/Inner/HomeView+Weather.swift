//
//  WeatherView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import SwiftUI

extension HomeView {
    func makeWeatherView() -> some View {
        VStack {
            if let weather = weatherViewModel.weather {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(weather.name)
                            .bold()
                            .font(.title)
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .fontWeight(.light)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "cloud")
                                .font(.system(size: 40))
                            
                            Text("\(weather.weather[0].main)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.temp.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                }
            }
        }
    }
}
