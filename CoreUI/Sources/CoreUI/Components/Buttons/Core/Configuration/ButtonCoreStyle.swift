//
//  ButtonCoreStyle.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 18.12.2024.
//

import struct SwiftUI.Color
import struct FoundationUI.DefaultPaletteSwiftUIProxy

protocol ButtonCoreStyle: Hashable, Sendable, CaseIterable {
    
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

extension ButtonCoreStyle {
    
    func backgroundColor(for state: ButtonCoreState) -> Color? {
        switch state {
        case .idle:
            return backgroundColorNormal
        case .pressed:
            return backgroundColorPressed
        case .disabled:
            return backgroundColorDisabled
        }
    }
    
    func foregroundColor(for state: ButtonCoreState) -> Color {
        switch state {
        case .idle:
            return foregroundColorNormal
        case .pressed:
            return foregroundColorPressed
        case .disabled:
            return foregroundColorDisabled
        }
    }
    
    func borderColor(for state: ButtonCoreState) -> Color? {
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
