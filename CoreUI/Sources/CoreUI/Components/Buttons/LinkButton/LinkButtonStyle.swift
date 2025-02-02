//
//  LinkButtonStyle.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import FoundationUI
import SwiftUI

public struct LinkButtonStyle: CoreButtonStyle {
    let backgroundColorNormal: Color? = nil

    let backgroundColorPressed: Color? = nil

    let backgroundColorDisabled: Color? = nil

    let foregroundColorNormal: Color

    let foregroundColorPressed: Color

    let foregroundColorDisabled: Color

    let borderColorNormal: Color? = nil

    let borderColorPressed: Color? = nil

    let borderColorDisabled: Color? = nil

    public init(
        foregroundColorNormal: Color,
        foregroundColorPressed: Color,
        foregroundColorDisabled: Color
    ) {
        self.foregroundColorNormal = foregroundColorNormal
        self.foregroundColorPressed = foregroundColorPressed
        self.foregroundColorDisabled = foregroundColorDisabled
    }
}

public extension LinkButtonStyle {
    static let regular: LinkButtonStyle = .init(
        foregroundColorNormal: .blue.primary,
        foregroundColorPressed: .blue.shade700,
        foregroundColorDisabled: .blue.shade100
    )
}

public extension LinkButtonStyle {
    static var allCases: [Self] {
        [
            regular,
        ]
    }
}
