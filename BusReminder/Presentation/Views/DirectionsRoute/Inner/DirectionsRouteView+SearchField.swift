//
//  DirectionsRouteView+SearchField.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 09/01/2024.
//

import SwiftUI

extension DirectionsRouteView {
    func makeSearchField() -> some View {
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

