//
//  SenseTagClipApp.swift
//  SenseTagClip
//
//  Created by Ivan Pohorielov on 14.03.2025.
//

import SwiftUI
import ComposableArchitecture
import FoundationUI

@main
struct SenseTagClipApp: App {
    var body: some Scene {
        WindowGroup {
            DemoMainScreen(
                store: Store(initialState: DemoMainFeature.State()) {
                    DemoMainFeature()
                }
            )
            .tint(.blue.primary)
        }
    }
}
