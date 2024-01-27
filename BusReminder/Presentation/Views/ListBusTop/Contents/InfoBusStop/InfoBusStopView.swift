//
//  InfoBusStopView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 23/12/2023.
//

import SwiftUI
import GoogleMaps

struct InfoBusStopView: View {
    let busStopInfo: ResultDomain
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Chuyến Xe Miền Trung")
                    .fontStyle(.largeBold)
                Text("\(busStopInfo.address), \(busStopInfo.ward)")
                    .fontStyle(.mediumLight)
                Text("Quảng đường: 1km")
                    .fontStyle(.medium)
                ButtonFullWidthView(lable: "Chọn Chuyến Này", color: .green, foregroundColor: .black) {
                    /// ToDo
                }
            }
        }
        .padding()
        .frame(width: UIScreen.screenWidth, alignment: .topLeading)
        .background {
            RoundedCornersShape(corners: .allCorners, radius: 12)
                .fill(.white)
        }
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    InfoBusStopView(busStopInfo: ResultDomain(geometry: GeometryDomain(location: CLLocationCoordinate2D(latitude: 100, longitude: 200)), address: "Bình Dương", ward: "Thăng Bình"))
}
