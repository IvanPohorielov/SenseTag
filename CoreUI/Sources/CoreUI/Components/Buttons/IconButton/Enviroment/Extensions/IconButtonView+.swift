//
//  View+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension View {
    
    func iconButtonSize(_ size: IconButtonSize) -> some View {
        environment(\.iconButtonSize, size)
    }
    
    func iconButtonStyle(_ style: IconButtonStyle) -> some View {
        environment(\.iconButtonStyle, style)
    }
    
    func iconButtonBorderShape(_ style: ButtonCoreBorderShape) -> some View {
        environment(\.buttonBorderShape, style)
    }
    
}
