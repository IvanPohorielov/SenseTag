//
//  NFCNDEFManager.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 06.01.2025.
//

import Dependencies
import SwiftUI
import NFCNDEFManager

extension DependencyValues {
    var openSettings: NFCNDEFManager {
        get { self[NFCNDEFManagerKey.self] }
        set { self[NFCNDEFManagerKey.self] = newValue }
    }
    
    private enum NFCNDEFManagerKey: DependencyKey {
        static let liveValue: NFCNDEFManager = NFCNDEFManager()
    }
}
