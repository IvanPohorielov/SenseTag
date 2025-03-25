//
//  MainScreenContainerView.swift
//  Core
//
//  Created by Ivan Pohorielov on 24.03.2025.
//

import SwiftUI
import CoreUI
import FoundationUI

public struct MainScreenContainerView<Content: View>: View {

    private var content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    @State
    private var animate: Bool = false

    public var body: some View {
        DefaultBackground {
            backgroundAnimation

            VStack(spacing: .spacer16) {
                self.content
            }
            .safeAreaPadding(.spacer16)
        }
        .onAppear {
            self.animate.toggle()
        }
    }

    private var backgroundAnimation: some View {
        ForEach(0..<5) { index in
            Circle()
                .stroke(lineWidth: 12.0)
                .foregroundStyle(Color.blue.primary)
                .opacity(animate ? 0 : 0.5)
                .scaleEffect(animate ? 2 : 0.1)
                .animation(
                    Animation.easeOut(duration: 12)
                        .repeatForever()
                        .delay(Double(index) * 2),
                    value: animate
                )
                .accessibilityHidden(true)
        }
    }
}
