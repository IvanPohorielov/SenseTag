//
//  CoreInputStyle.swift
//
//
//  Created by Ivan Pohorielov on 02.05.2024.
//

import FoundationUI
import SwiftUI

public struct CoreInputStyle: Hashable, Sendable, CoreInputContainerStyleProtocol {
    // MARK: - Properties

    private let foregroundColorNormal: Color
    private let foregroundColorActive: Color
    private let foregroundColorError: Color
    private let foregroundColorDisabled: Color

    let backgroundColorNormal: Color
    let backgroundColorActive: Color
    let backgroundColorError: Color
    let backgroundColorDisabled: Color

    let labelForegroundColor: Color

    let captionForegroundColorNormal: Color
    let captionForegroundColorActive: Color
    let captionForegroundColorError: Color
    let captionForegroundColorDisabled: Color

    let counterForegroundColorNormal: Color
    let counterForegroundColorActive: Color
    let counterForegroundColorError: Color
    let counterForegroundColorDisabled: Color

    let outlineColorNormal: Color
    let outlineColorActive: Color
    let outlineColorError: Color
    let outlineColorDisabled: Color

    // MARK: - LifeCycle

    init(
        foregroundColorNormal: Color,
        foregroundColorActive: Color,
        foregroundColorError: Color,
        foregroundColorDisabled: Color,
        backgroundColorNormal: Color,
        backgroundColorActive: Color,
        backgroundColorError: Color,
        backgroundColorDisabled: Color,
        labelForegroundColor: Color,
        captionForegroundColorNormal: Color,
        captionForegroundColorActive: Color,
        captionForegroundColorError: Color,
        captionForegroundColorDisabled: Color,
        counterForegroundColorNormal: Color,
        counterForegroundColorActive: Color,
        counterForegroundColorError: Color,
        counterForegroundColorDisabled: Color,
        outlineColorNormal: Color,
        outlineColorActive: Color,
        outlineColorError: Color,
        outlineColorDisabled: Color
    ) {
        self.foregroundColorNormal = foregroundColorNormal
        self.foregroundColorActive = foregroundColorActive
        self.foregroundColorError = foregroundColorError
        self.foregroundColorDisabled = foregroundColorDisabled
        self.backgroundColorNormal = backgroundColorNormal
        self.backgroundColorActive = backgroundColorActive
        self.backgroundColorError = backgroundColorError
        self.backgroundColorDisabled = backgroundColorDisabled
        self.labelForegroundColor = labelForegroundColor
        self.captionForegroundColorNormal = captionForegroundColorNormal
        self.captionForegroundColorActive = captionForegroundColorActive
        self.captionForegroundColorError = captionForegroundColorError
        self.captionForegroundColorDisabled = captionForegroundColorDisabled
        self.counterForegroundColorNormal = counterForegroundColorNormal
        self.counterForegroundColorActive = counterForegroundColorActive
        self.counterForegroundColorError = counterForegroundColorError
        self.counterForegroundColorDisabled = counterForegroundColorDisabled
        self.outlineColorNormal = outlineColorNormal
        self.outlineColorActive = outlineColorActive
        self.outlineColorError = outlineColorError
        self.outlineColorDisabled = outlineColorDisabled
    }
}

extension CoreInputStyle {
    func foregroundColor(for state: CoreInputState) -> Color {
        switch state {
        case .idle:
            return foregroundColorNormal
        case .active:
            return foregroundColorActive
        case .error:
            return foregroundColorError
        case .disabled:
            return foregroundColorDisabled
        }
    }
}

// MARK: - Catalog values

public extension CoreInputStyle {
    static let regular: CoreInputStyle = .init(
        foregroundColorNormal: .black.primary,
        foregroundColorActive: .black.primary,
        foregroundColorError: .black.primary,
        foregroundColorDisabled: .black.shade700,
        backgroundColorNormal: .absoluteWhite.opacity(0.3),
        backgroundColorActive: .absoluteWhite.opacity(0.3),
        backgroundColorError: .absoluteWhite.opacity(0.3),
        backgroundColorDisabled: .black.shade100.opacity(0.3),
        labelForegroundColor: .black.primary,
        captionForegroundColorNormal: .black.shade700,
        captionForegroundColorActive: .black.shade700,
        captionForegroundColorError: .red.primary,
        captionForegroundColorDisabled: .black.shade700,
        counterForegroundColorNormal: .black.shade700,
        counterForegroundColorActive: .black.shade700,
        counterForegroundColorError: .red.primary,
        counterForegroundColorDisabled: .black.shade700,
        outlineColorNormal: .black.shade400,
        outlineColorActive: .violet.primary,
        outlineColorError: .red.primary,
        outlineColorDisabled: .black.shade400
    )
}
