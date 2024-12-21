//
//  View+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension View {
    
    func defaultButtonFullWidth(_ fullWidth: Bool) -> some View {
        environment(\.buttonFullWidth, fullWidth)
    }
    
    func defaultButtonSize(_ size: DefaultButtonSize) -> some View {
        environment(\.buttonSize, size)
    }
    
    func defaultButtonStyle(_ style: DefaultButtonStyle) -> some View {
        environment(\.buttonStyle, style)
    }
    
    func defaultButtonBorderShape(_ style: ButtonCoreBorderShape) -> some View {
        environment(\.buttonBorderShape, style)
    }
    
}
