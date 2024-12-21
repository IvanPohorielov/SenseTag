//
//  DefaultButtonStyle.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI
import FoundationUI

public struct DefaultButtonStyle: CoreButtonStyle {
    
    let backgroundColorNormal: Color?
    
    let backgroundColorPressed: Color?
    
    let backgroundColorDisabled: Color?
    
    let foregroundColorNormal: Color
    
    let foregroundColorPressed: Color
    
    let foregroundColorDisabled: Color
    
    let borderColorNormal: Color?
    
    let borderColorPressed: Color?
    
    let borderColorDisabled: Color?
    
    public init(
        backgroundColorNormal: Color,
        backgroundColorPressed: Color,
        backgroundColorDisabled: Color,
        foregroundColorNormal: Color,
        foregroundColorPressed: Color,
        foregroundColorDisabled: Color,
        borderColorNormal: Color? = nil,
        borderColorPressed: Color? = nil,
        borderColorDisabled: Color? = nil
    ) {
        self.backgroundColorNormal = backgroundColorNormal
        self.backgroundColorPressed = backgroundColorPressed
        self.backgroundColorDisabled = backgroundColorDisabled
        self.foregroundColorNormal = foregroundColorNormal
        self.foregroundColorPressed = foregroundColorPressed
        self.foregroundColorDisabled = foregroundColorDisabled
        self.borderColorNormal = borderColorNormal
        self.borderColorPressed = borderColorPressed
        self.borderColorDisabled = borderColorDisabled
    }
}

public extension DefaultButtonStyle {
    
    static let primary: DefaultButtonStyle = DefaultButtonStyle(
        backgroundColorNormal: .blue.shade500,
        backgroundColorPressed: .blue.shade400,
        backgroundColorDisabled: .blue.shade100,
        foregroundColorNormal: .absoluteWhite,
        foregroundColorPressed: .absoluteWhite,
        foregroundColorDisabled: .absoluteWhite
    )
    
    static let secondary: DefaultButtonStyle = DefaultButtonStyle(
        backgroundColorNormal: .absoluteWhite,
        backgroundColorPressed: .blue.shade50,
        backgroundColorDisabled: .absoluteWhite,
        foregroundColorNormal: .blue.shade500,
        foregroundColorPressed: .blue.shade500,
        foregroundColorDisabled: .blue.shade100,
        borderColorNormal: .blue.shade500,
        borderColorPressed: .blue.shade500,
        borderColorDisabled: .blue.shade100
    )
    
    static let tertiary: DefaultButtonStyle = DefaultButtonStyle(
        backgroundColorNormal: .clear,
        backgroundColorPressed: .blue.shade50,
        backgroundColorDisabled: .clear,
        foregroundColorNormal: .blue.shade500,
        foregroundColorPressed: .blue.shade700,
        foregroundColorDisabled: .blue.shade100
    )
    
}

extension DefaultButtonStyle {
    public static var allCases: [Self] {
        [
            Self.primary,
            Self.secondary,
            Self.tertiary
        ]
    }
}
