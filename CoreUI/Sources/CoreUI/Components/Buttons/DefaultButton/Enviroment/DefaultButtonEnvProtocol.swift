//
//  DefaultButtonEnvProtocol.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

@MainActor
protocol DefaultButtonEnvProtocol {
    
    var isFullWidth: Bool { get }

    var size: DefaultButtonSize { get }
    
    var style: DefaultButtonStyle { get }
    
    var borderShape: CoreButtonBorderShape { get }
    
}
