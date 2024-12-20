//
//  Enviroment+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension EnvironmentValues {
    
    @Entry
    var defaultButtonFullWidth: Bool = false
    
    @Entry
    var defaultButtonSize: DefaultButtonSize = .regular
    
    @Entry
    var defaultButtonStyle: DefaultButtonStyle = .primary
    
    @Entry
    var defaultButtonBorderShape: ButtonCoreBorderShape = .roundedRectangle
    
}
