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
    
}

//@Reducer
//struct AppDelegateFeature {
//    @ObservableState
//    struct State {
//        @Presents var destination: Destination.State?
//    }
//
//    enum Action {
//    }
//
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//        }
//        .ifLet(\.$destination, action: \.destination)
//    }
//}
//
//extension AppDelegateFeature {
//    @Reducer
//    enum Destination {
//        case confirmationDialog(ConfirmationDialogState<MainFeature.Action.ConfirmationDialog>)
//        case alert(AlertState<MainFeature.Action.Alert>)
//        case readTag(ReadTagFeature)
//        case writeTag(WriteTagFeature)
//    }
//}
