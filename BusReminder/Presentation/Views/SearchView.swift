//
//  SearchView.swift
//  Locations
//
//  Created by LuanNT29 on 06/11/2023.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @EnvironmentObject var locationManager: LocationManager
    // MARK: Navigation Tag to push view to Map
    @State var navigationTag: String?
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Nhập vị trí", text: $locationManager.searchText)
                    .padding(8)
                Button {
                    locationManager.searchText = ""
                } label: {
                    Image(systemName: "x.circle")
                }
            }
            .padding(.horizontal)
            .background(.gray, in: RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
            Button {
                // MARK: Setting Map Region
                if let coordinate = locationManager.userLocation?.coordinate {
                    locationManager.mapView.region = .init(
                        center: coordinate,
                        latitudinalMeters: 1000,
                        longitudinalMeters: 1000
                    )
                    locationManager.addDraggablePin(coordinate: coordinate)
                    locationManager.updatePlacemark(location: .init(
                        latitude: coordinate.latitude,
                        longitude: coordinate.longitude)
                    )
                }
                // MARK: Navigation to MapView
                navigationTag = "MAPVIEW"
            } label: {
                Label {
                    Text("Use Current Location")
                } icon: {
                    Image(systemName: "location.circle.fill")
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .top)
        .background {
            NavigationLink(tag: "MAPVIEW", selection: $navigationTag) {
                BusStopLocationsView()
                    .environmentObject(locationManager)
            } label: {
            }
            .labelsHidden()
        }
        .navigationBarHidden(true)
    }
}



//MARK: UIKit MapView
struct MapViewHelper: UIViewRepresentable {
    @EnvironmentObject var locationManager: LocationManager
    func makeUIView(context: Context) -> MKMapView {
        return locationManager.mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
