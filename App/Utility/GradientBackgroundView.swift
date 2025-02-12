//
//  GradientBackgroundModifier.swift
//  Life Taker
//
//  Created by ymy on 2/13/25.
//

import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color.pink.opacity(0.3), location: 0.0),
                .init(color: Color.cyan.opacity(0.4), location: 0.2),
                .init(color: Color.purple.opacity(0.35), location: 0.3),
                .init(color: Color.pink.opacity(0.2), location: 0.35),
                .init(color: Color(UIColor.systemGroupedBackground), location: 0.5)
            ]),
            startPoint: .topLeading,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
