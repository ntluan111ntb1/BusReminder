//
//  SearchView.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 24/01/2024.
//


import SwiftUI

struct SearchView: View {
    @StateObject var searchPlacesViewModel = SearchPlaceViewModel()
    @State var searchText = "Hyatt Regency San Francisco"
    @FocusState var focusedField: Bool
    
    let action: (_ destination: SearchPlace.Place.Location) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    if searchText != "" {
                        searchPlacesViewModel.searchPlace(
                            parameter: SearchPlaceParameters(textQuery: searchText)
                        )
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                TextField(
                    "Nhập vị trí cần đến",
                    text: $searchText,
                    onCommit: {
                        if searchText != "" {
                            searchPlacesViewModel.searchPlace(
                                parameter: SearchPlaceParameters(textQuery: searchText)
                            )
                        }
                    }
                )
                .focused($focusedField)
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "x.circle")
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
            List(searchPlacesViewModel.searchPlace.places) { place in
                Button {
                    action(place.location)
                } label: {
                    HStack {
                        Image(systemName: "location.north.circle")
                            .font(.title3)
                        Text(place.displayName.text)
                            .fontStyle(.medium)
                    }
                }
            }
            .listStyle(.inset)
            .onAppear{
                focusedField = true
            }
        }
    }
}

