//
//  BusStopLocationsView.swift
//  Locations
//
//  Created by Nguyễn Luân on 20/12/2023.
//

import SwiftUI
import GoogleMaps

struct BusStopLocationsView: View {
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = BusStopLocationsViewModel()
    @Environment(\.dismiss) var dismiss

    @State var isShowListBusStop = false

    var body: some View {
        VStack {
            if viewModel.isLoadMore {
                ProgressView()
            } else {
                ZStack(alignment: .bottom) {
                    MapView(busStopLocations: .constant(busStopLocations), isShowListBusStop: $isShowListBusStop)
                        .environmentObject(locationManager)
                        .ignoresSafeArea()
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.title3.bold())
                            Text("Back")
                        }
                    }
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }
        .onAppear {
            if let coordinate = locationManager.userLocation?.coordinate {
                //                viewModel.getBusStopLocations(
                //                    parameters: BusStopPrameters(
                //                        location: "\(coordinate.latitude),\(coordinate.longitude)",
                //                        keyword: Constants.GoogleMapUrlPrams.keyword,
                //                        radius: 1500,
                //                        key: Constants.GoogleMapUrlPrams.key)
                //                )
            }
        }
        .navigationBarHidden(true)
    }
    
    private var busStopLocations: BusStopLocations {
        if let coordinate = locationManager.userLocation?.coordinate {
            return BusStopLocations(results: [
                ResultDomain(
                    geometry: GeometryDomain(
                        location: CLLocationCoordinate2D(latitude: coordinate.latitude+0.001, longitude: coordinate.longitude+0.001)
                    ),
                    address: "address 1",
                    ward: "ward 1"
                ),
                ResultDomain(
                    geometry: GeometryDomain(
                        location: CLLocationCoordinate2D(latitude: coordinate.latitude+0.002, longitude: coordinate.longitude+0.002)
                    ),
                    address: "address 1",
                    ward: "ward 1"
                ),
                ResultDomain(
                    geometry: GeometryDomain(
                        location: CLLocationCoordinate2D(latitude: coordinate.latitude+0.0003, longitude: coordinate.longitude+0.0003)
                    ),
                    address: "address 1",
                    ward: "ward 1"
                )
            ])
        }
        return BusStopLocations(results: [])
    }
}
