//
//  LinkButtonEnvProtocol.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

@MainActor
protocol LinkButtonEnvProtocol {

    var size: LinkButtonSize { get }
    
    var style: LinkButtonStyle { get }
    
}
