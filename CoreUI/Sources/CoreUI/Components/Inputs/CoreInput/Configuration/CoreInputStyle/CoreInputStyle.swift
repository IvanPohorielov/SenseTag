//
//  CoreInputStyle.swift
//
//
//  Created by Ivan Pohorielov on 02.05.2024.
//

import SwiftUI
import FoundationUI

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
    
    static let regular: CoreInputStyle = CoreInputStyle(
        foregroundColorNormal: .black.shade900,
        foregroundColorActive: .black.shade900,
        foregroundColorError: .black.shade900,
        foregroundColorDisabled: .black.shade700,
        backgroundColorNormal: .absoluteWhite,
        backgroundColorActive: .absoluteWhite,
        backgroundColorError: .absoluteWhite,
        backgroundColorDisabled: .black.shade100,
        labelForegroundColor: .black.shade900,
        captionForegroundColorNormal: .black.shade700,
        captionForegroundColorActive: .black.shade700,
        captionForegroundColorError: .red.shade900,
        captionForegroundColorDisabled: .black.shade700,
        counterForegroundColorNormal: .black.shade700,
        counterForegroundColorActive: .black.shade700,
        counterForegroundColorError: .red.shade900,
        counterForegroundColorDisabled: .black.shade700,
        outlineColorNormal: .black.shade400,
        outlineColorActive: .yellow.shade500,
        outlineColorError: .red.shade900,
        outlineColorDisabled: .black.shade400
    )
}