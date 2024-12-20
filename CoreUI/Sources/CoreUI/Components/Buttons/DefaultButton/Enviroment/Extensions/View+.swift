//
//  View+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension View {
    
    func defaultButtonFullWidth(_ fullWidth: Bool) -> some View {
        environment(\.defaultButtonFullWidth, fullWidth)
    }
    
    func defaultButtonSize(_ size: DefaultButtonSize) -> some View {
        environment(\.defaultButtonSize, size)
    }
    
    func defaultButtonStyle(_ style: DefaultButtonStyle) -> some View {
        environment(\.defaultButtonStyle, style)
    }
    
    func defaultButtonBorderShape(_ style: ButtonCoreBorderShape) -> some View {
        environment(\.defaultButtonBorderShape, style)
    }
    
}
