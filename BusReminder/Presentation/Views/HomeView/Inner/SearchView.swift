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
            Button {
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
