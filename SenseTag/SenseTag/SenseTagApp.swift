//
//  SenseTagApp.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 09.12.2024.
//

import ComposableArchitecture
import SwiftUI

@main
struct SenseTagApp: App {
    static let store = Store(initialState: MainFeature.State()) {
        MainFeature()
    }

    var body: some Scene {
        WindowGroup {
            MainScreen(store: SenseTagApp.store)
        }
    }
}
