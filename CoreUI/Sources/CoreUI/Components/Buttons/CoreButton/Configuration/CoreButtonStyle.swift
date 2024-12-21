//
//  CoreButtonStyle.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 18.12.2024.
//

import struct SwiftUI.Color
import struct FoundationUI.DefaultPaletteSwiftUIProxy

protocol CoreButtonStyle: Hashable, Sendable, CaseIterable {
    
    var backgroundColorNormal: Color? { get }
    var backgroundColorPressed: Color? { get }
    var backgroundColorDisabled: Color? { get }
    
    var foregroundColorNormal: Color { get }
    var foregroundColorPressed: Color { get }
    var foregroundColorDisabled: Color { get }
    
    var borderColorNormal: Color? { get }
    var borderColorPressed: Color? { get }
    var borderColorDisabled: Color? { get }
    
}

extension CoreButtonStyle {
    
    func backgroundColor(for state: CoreButtonState) -> Color? {
        switch state {
        case .idle:
            return backgroundColorNormal
        case .pressed:
            return backgroundColorPressed
        case .disabled:
            return backgroundColorDisabled
        }
    }
    
    func foregroundColor(for state: CoreButtonState) -> Color {
        switch state {
        case .idle:
            return foregroundColorNormal
        case .pressed:
            return foregroundColorPressed
        case .disabled:
            return foregroundColorDisabled
        }
    }
    
    func borderColor(for state: CoreButtonState) -> Color? {
        switch state {
        case .idle:
            return borderColorNormal
        case .pressed:
            return borderColorPressed
        case .disabled:
            return borderColorDisabled
        }
    }
}
