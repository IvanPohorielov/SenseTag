//
//  View+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension View {
    
    func linkButtonSize(_ size: LinkButtonSize) -> some View {
        environment(\.linkButtonSize, size)
    }
    
    func linkButtonStyle(_ style: LinkButtonStyle) -> some View {
        environment(\.linkButtonStyle, style)
    }
    
}
