//
//  Enviroment+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension EnvironmentValues {
    
    @Entry
    var buttonFullWidth: Bool = false
    
    @Entry
    var buttonSize: DefaultButtonSize = .regular
    
    @Entry
    var buttonStyle: DefaultButtonStyle = .primary
    
}
