//
//  Loadable.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

@MainActor
public protocol Loadable: View {
    
    var isLoading: Bool { get }
    
    var isLoadingEnabled: Bool { get }
}
