//
//  PlaceholderScreenLayout.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 03.03.2025.
//

import Foundation

public struct PlaceholderScreenLayout: Hashable, Sendable, CaseIterable {
    
    // MARK: - Properties
    
    let contentHorizontalPadding: CGFloat
    
    let illustrationSize: CGFloat
    
    let textStackSpacing: CGFloat
    let buttonStackSpacing: CGFloat
    let mainStackSpacing: CGFloat
    
    // MARK: - LifeCycle
    
    public init(
        contentHorizontalPadding: CGFloat,
        illustrationSize: CGFloat,
        textStackSpacing: CGFloat,
        buttonStackSpacing: CGFloat,
        mainStackSpacing: CGFloat
    ) {
        self.contentHorizontalPadding = contentHorizontalPadding
        self.illustrationSize = illustrationSize
        self.textStackSpacing = textStackSpacing
        self.buttonStackSpacing = buttonStackSpacing
        self.mainStackSpacing = mainStackSpacing
    }
}

// MARK: - Catalog values

public extension PlaceholderScreenLayout {
    
    static let regular: PlaceholderScreenLayout = PlaceholderScreenLayout(
        contentHorizontalPadding: .spacer48,
        illustrationSize: .image160,
        textStackSpacing: .spacer16,
        buttonStackSpacing: .spacer8,
        mainStackSpacing: .spacer24
    )
    
}

extension PlaceholderScreenLayout {
    public static var allCases: [PlaceholderScreenLayout] {
        [
            .regular
        ]
    }
}
