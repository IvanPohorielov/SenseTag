//
//  IconButtonEnvProtocol.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

@MainActor
protocol IconButtonEnvProtocol {
    var size: IconButtonSize { get }

    var style: IconButtonStyle { get }

    var borderShape: CoreButtonBorderShape { get }
}
