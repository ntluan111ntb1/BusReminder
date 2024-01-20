//
//  SearchView.swift
//  Locations
//
//  Created by LuanNT29 on 06/11/2023.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @State var searchText = ""
    @StateObject var searchPlacesViewModel = SearchPlaceViewModel()
    var body: some View {
        HStack {
            Button {
                searchText = ""
            } label: {
                Image(systemName: "x.circle")
            }
            TextField(
                "",
                text: $searchText,
                prompt: Text("Nhập vị trí cần đến").foregroundColor(.white)
            )
            Button {
                if searchText != "" {
                    searchPlacesViewModel.searchPlace(
                        parameter: SearchPlaceParameters(textQuery: searchText)
                    )
                }
            } label: {
                Image(systemName: "magnifyingglass")
            }
        }
        .font(.title3)
        .padding(12)
        .foregroundColor(.white)
        .background {
            RoundedCornersShape(corners: .allCorners, radius: 12)
                .fill(Color.deepBlue)
        }
        .padding(.horizontal)
    }
}
