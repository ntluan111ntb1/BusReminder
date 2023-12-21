//
//  ListBusStopsView.swift
//  Locations
//
//  Created by LuanNT29 on 21/12/2023.
//

import SwiftUI
import GoogleMaps

struct ListBusStopsView: View {
    let busStopLocations: BusStopLocations

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(busStopLocations.results) { busStopLocation in
                    HStack(spacing: 16) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.title)
                            .foregroundColor(.red)
                        VStack(alignment: .leading) {
                            Text(busStopLocation.address)
                                .font(.title3.bold())
                            Text(busStopLocation.ward)
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 300, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.white)
                .shadow(radius: 12)
        }
    }
}
