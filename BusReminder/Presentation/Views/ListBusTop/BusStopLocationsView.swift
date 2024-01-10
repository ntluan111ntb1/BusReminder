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
    @State var busStopInfo = ResultDomain(
        geometry: GeometryDomain(location: CLLocationCoordinate2D()),
        address: "",
        ward: ""
    )

    var body: some View {
        VStack {
            if viewModel.isLoadMore {
                ProgressView()
            } else {
                ZStack(alignment: .bottom) {
//                    MapView()
//                        .environmentObject(locationManager)
//                        .ignoresSafeArea()
                    if isShowListBusStop {
                        InfoBusStopView(busStopInfo: busStopInfo)
                    }
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
                    address: "address 2",
                    ward: "ward 2"
                ),
                ResultDomain(
                    geometry: GeometryDomain(
                        location: CLLocationCoordinate2D(latitude: coordinate.latitude+0.0003, longitude: coordinate.longitude+0.0003)
                    ),
                    address: "address 3",
                    ward: "ward 3"
                )
            ])
        }
        return BusStopLocations(results: [])
    }
}
