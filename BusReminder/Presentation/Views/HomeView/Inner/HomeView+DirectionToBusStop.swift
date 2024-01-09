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
            HStack(alignment: .top) {
                VStack(spacing: 0) {
                    Image("map")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .background(Color.deepOrange)
                        .clipShape(Circle(), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
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
                        .padding(.vertical,5)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("To: Bus Station")
                            .fontStyle(.small)
                        Text("123 Nguyễn Phước Nguyên")
                            .fontStyle(.mediumBold)
                    }
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("Start: 10:00 Am")
                    }
                    .font(.system(.caption))
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Distance: 1 Km")
                    }
                    .font(.system(.caption))
                    Spacer()
                }
                .foregroundColor(.deepBlue)
                Button {
                    isShowMapView = true
                } label: {
                    Image("bus-stop-button")
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
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.lightBlue.opacity(0.5))
            }
            .frame(width: .infinity, height: 160, alignment: .top)
        }
    }
}
