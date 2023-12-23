//
// Copyright (C) 2023 Suntory Wellness Limited. All Rights Reserved.
//

import SwiftUI

// swiftlint:disable missing_docs
public extension Text {
    enum FontStyle {
        case large
        case largeBold
        case largeLight
        case medium
        case mediumBold
        case mediumLight
        case small
        case smallBold
        case smallLight
    }
    // MARK: - Custom Font Style Common
    func fontStyle(_ value: FontStyle) -> some View {
        var text = self
        switch value {
        case .large:
            text = text
                .font(.title3)
        case .largeBold:
            text = text
                .font(.title3)
                .bold()
        case .largeLight:
            text = text
                .font(.title3)
                .fontWeight(.light)
        case .medium:
            text = text
                .font(.body)
        case .mediumBold:
            text = text
                .font(.body)
                .bold()
        case .mediumLight:
            text = text
                .font(.body)
                .fontWeight(.light)
        case .small:
            text = text
                .font(.footnote)
        case .smallBold:
            text = text
                .font(.footnote)
                .bold()
        case .smallLight:
            text = text
                .font(.footnote)
                .fontWeight(.light)
        }
        return text
    }
}
