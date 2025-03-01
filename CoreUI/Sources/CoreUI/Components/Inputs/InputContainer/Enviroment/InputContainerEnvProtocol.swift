//
//  InputContainerEnvProtocol.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

@MainActor
protocol InputContainerEnvProtocol {
    var size: any CoreInputContainerSizeProtocol { get }

    var style: any CoreInputContainerStyleProtocol { get }

    var characterLimitConfiguration: CoreInputCharacterLimitConfiguration? { get }
}
