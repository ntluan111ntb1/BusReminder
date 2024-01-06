//
//  WeatherView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import SwiftUI

extension HomeView {
    @ViewBuilder
    func makeWeatherView() -> some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading) {
                Text("Đà Nẵng")
                    .bold()
                    .font(.title)
                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                    .fontWeight(.light)
            }
            Spacer()
            HStack(alignment: .top)  {
                VStack(spacing: 5) {
                    Image(systemName: "cloud")
                        .font(.system(size: 40))
                    Text("Trời Đẹp")
                }
                Text("20" + "°")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
            }
        }
        .padding(8)
        .foregroundColor(.deepBlue)
    }
}
