//
//  HomeView+SearchButton.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 20/01/2024.
//

import Foundation
import SwiftUI

extension HomeView {
    func makeSearchButton() -> some View {
        Button {
            isShowSearchView.toggle()
        } label: {
            HStack {
                Image(systemName: "x.circle")
                Text("Nhập vị trí cần đến").foregroundColor(.white)
                Spacer()
                Image(systemName: "magnifyingglass")
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
        .padding(.vertical)
    }
}
