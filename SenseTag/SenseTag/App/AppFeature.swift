//
//  AppFeature.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 07.06.2025.
//

import ComposableArchitecture
import CoreDependencies
import Foundation
import SwiftUI

@Reducer
struct AppFeature {

    @ObservableState
    struct State {
        var appDelegate: AppDelegateFeature.State
        var main: MainFeature.State

        public init(
            appDelegate: AppDelegateFeature.State = AppDelegateFeature.State(),
            main: MainFeature.State = MainFeature.State()
        ) {
            self.appDelegate = appDelegate
            self.main = main
        }
    }

    public enum Action {
        case appDelegate(AppDelegateFeature.Action)
        case didChangeScenePhase(ScenePhase)
        case main(MainFeature.Action)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        self.core
    }

    @ReducerBuilder<State, Action>
    var core: some ReducerOf<Self> {
        Scope(state: \.appDelegate, action: \.appDelegate) {
            AppDelegateFeature()
        }
        Scope(state: \.main, action: \.main) {
            MainFeature()
        }
        Reduce { state, action in
            switch action {
            case .appDelegate(.didFinishLaunching):
                return .none
            case .appDelegate:
                return .none
            case .didChangeScenePhase:
                return .none
            case .main:
                return .none
            }
        }
    }
}
