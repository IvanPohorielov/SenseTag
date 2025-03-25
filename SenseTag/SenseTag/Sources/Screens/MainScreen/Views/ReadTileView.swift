//
//  ReadTileView.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 25.03.2025.
//

import SwiftUI

public struct ReadTileView: View {
    
    private let span: Int
    private let action: @MainActor () -> Void
    
    public init(
        span: Int,
        action: @MainActor @escaping () -> Void
    ) {
        self.span = span
        self.action = action
    }
    
    public var body: some View {
        MainScreenTileView(
            "mainScreen.tile.read",
            systemImage: "magnifyingglass.circle.fill",
            span: span
        ) {
            action()
        }
    }
}
