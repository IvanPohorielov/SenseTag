//
//  DefaultBackground.swift
//
//
//  Created by Ivan Pohorielov on 02.05.2024.
//

import SwiftUI
import FoundationUI

public struct DefaultBackground<ContentView: View>: View {
    
    private let backgroundColor: Color
    private let alignment: Alignment
    private let content: ContentView
    
    public init(
        alignment: Alignment = .center,
        backgroundColor: Color = .black.shade100,
        @ViewBuilder content: () -> ContentView
    ) {
        self.alignment = alignment
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    public var body : some View {
        ZStack(alignment: alignment) {
            backgroundColor
                .ignoresSafeArea()
                .zIndex(0)
                .accessibilityIdentifier(Accessibility.DefaultBackground.rawValue)
            
            content
                .zIndex(1)
        }
    }
}
