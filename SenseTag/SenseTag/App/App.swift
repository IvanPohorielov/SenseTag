//
//  SenseTagApp.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 09.12.2024.
//

import ComposableArchitecture
import FoundationUI
import SwiftUI
import NFCNDEFManager

@main
struct SenseTagApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    @Environment(\.scenePhase)
    private var scenePhase
    
    private var store: Store<AppFeature.State, AppFeature.Action> { appDelegate.store }
    
    var body: some Scene {
        WindowGroup {
            AppView(store:  self.appDelegate.store)
                .onChange(of: self.scenePhase) { _, newPhase in
                    self.appDelegate.store.send(.didChangeScenePhase(newPhase))
                }
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                    
                    // Try to get background NDEF
                    let ndefMessage = userActivity.ndefMessagePayload
                    
                    // Verify NDEF
                    if ndefMessage.records.count > 0,
                       ndefMessage.records[0].typeNameFormat != .empty {
                        store.send(.onContinueUserActivityNDEF(ndefMessage))
                    }
                }
        }
    }
}
