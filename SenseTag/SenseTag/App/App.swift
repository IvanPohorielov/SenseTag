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
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            AppView(store:  self.appDelegate.store)
            .onChange(of: self.scenePhase) { _, newPhase in
              self.appDelegate.store.send(.didChangeScenePhase(newPhase))
            }
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                
            }
        }
    }
}
