//
//  AppDelegate.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 17.03.2025.
//

import ComposableArchitecture
import CoreDependencies
import Foundation
import UIKit.UIApplication

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    let store = Store(
        initialState: AppFeature.State(),
        reducer: {
            AppFeature()
        }
    )
    
    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
      self.store.send(.appDelegate(.didFinishLaunching))
      return true
    }
    
}
