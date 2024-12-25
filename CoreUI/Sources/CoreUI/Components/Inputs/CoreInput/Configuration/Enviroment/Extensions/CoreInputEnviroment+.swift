//
//  Enviroment+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension EnvironmentValues {
    
    @Entry
    var inputSize: CoreInputSize = .regular
    
    internal var inputContainerSize: any CoreInputContainerSizeProtocol  {
        self.inputSize
    }
    
    @Entry
    var inputStyle: CoreInputStyle = .regular
    
    internal var inputContainerStyle: any CoreInputContainerStyleProtocol  {
        self.inputStyle
    }
    
    @Entry
    var inputCharacterLimitConfiguration: CoreInputCharacterLimitConfiguration? = nil
    
    @Entry
    var inputClearButtonEnabled: Bool = false
    
    @Entry
    var inputRequired: Bool = false
    
}
