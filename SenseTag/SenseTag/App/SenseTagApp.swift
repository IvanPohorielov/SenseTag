//
//  SenseTagApp.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 09.12.2024.
//

import ComposableArchitecture
import FoundationUI
import SwiftUI

@main
struct SenseTagApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainScreen(
                store: Store(initialState: MainFeature.State()) {
                    MainFeature()
                }
            )
            .tint(.blue.primary)
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                
            }
        }
    }
}
