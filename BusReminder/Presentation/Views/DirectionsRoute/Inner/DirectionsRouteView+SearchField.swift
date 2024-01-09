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
            Image(systemName: "magnifyingglass")
            TextField(
                "",
                text: $search,
                prompt: Text("Nhập vị trí cần đến").foregroundColor(.white)
            )
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

