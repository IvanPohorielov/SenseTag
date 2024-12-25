//
//  CoreInputEnvProtocol.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

@MainActor
protocol CoreInputEnvProtocol {
    
    var size: CoreInputSize { get }
    
    var style: CoreInputStyle { get }
    
    var characterLimitConfiguration: CoreInputCharacterLimitConfiguration? { get }
        
    var isRequired: Bool { get }
    
}
