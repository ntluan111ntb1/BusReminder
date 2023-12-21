//
//  LottieView.swift
//  Locations
//
//  Created by LuanNT29 on 20/12/2023.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {

    var url: URL

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        LottieAnimation.loadedFrom(
            url: url,
            closure: { animation in
                animationView.animation = animation
                animationView.play()

            },
            animationCache: DefaultAnimationCache.sharedCache
        )
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
