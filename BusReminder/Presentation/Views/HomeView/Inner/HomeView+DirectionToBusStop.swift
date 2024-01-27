//
//  HomeView+DirectionToBusStop.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 06/01/2024.
//

import SwiftUI

extension HomeView{
    func makeDirectionToBusStop() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "bookmark.circle")
                Text("Go to nearest Bus Stop.")
                    .bold()
                    .font(.title3)
            }
            .foregroundColor(.deepBlue)
            HStack(alignment: .top, spacing: 20) {
                VStack(spacing: 0) {
                    Image(systemName: "circle.circle.fill")
                        .font(.system(.title3))
                    HStack {
                        Divider()
                    }
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(.title3))
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("From: Your Location")
                                .fontStyle(.small)
                            Text(userLocationViewModel.street)
                                .fontStyle(.mediumBold)
                            Text(userLocationViewModel.city)
                                .font(.system(.caption))
                        }
                        Spacer()
                        Button {
                            userLocationViewModel.getAddess(coordinate: coordinate)
                        } label: {
                            Image(systemName: "location.square.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.deepBlue)
                        }
                    }
                    Divider()
                        .padding(.vertical, 4)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("To:")
                            .fontStyle(.small)
                        Text(searchPlacesViewModel.searchPlace.places.first?.displayName.text ?? "-")
                            .fontStyle(.mediumBold)
                    }
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("Duration: \(directionsRouteViewModel.directionsRoute.routes.first?.localizedValues.duration.text ?? "-")")
                    }
                    .font(.system(.caption))
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Distance: \(directionsRouteViewModel.directionsRoute.routes.first?.localizedValues.distance.text ?? "-")")
                    }
                    .font(.system(.caption))
                    Spacer()
                }
                .foregroundColor(.deepBlue)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.lightBlue.opacity(0.5))
            }
            .frame(height: 160, alignment: .top)
        }
    }
}
