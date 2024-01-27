//
//  ButtonFullWidthView.swift
//  Locations
//
//  Created by Nguyễn Luân on 20/12/2023.
//

import SwiftUI

struct ButtonFullWidthView: View {
    let lable: String
    let color: Color
    let foregroundColor: Color

    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(lable)
                    .fontStyle(.mediumBold)
                Spacer()
            }
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 24)
        .foregroundColor(foregroundColor)
        .background(color)
        .overlay {
            RoundedRectangle(cornerRadius: 64)
                .stroke(.gray.opacity(0.5), lineWidth: 1)
        }
        .cornerRadius(62)
    }
}
