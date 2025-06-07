//
//  AppDelegateFeature.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 07.06.2025.
//

import ComposableArchitecture
import CoreDependencies
import Foundation

@Reducer
public struct AppDelegateFeature {
    
  public struct State: Equatable {
    public init() {}
  }

  public enum Action {
    case didFinishLaunching
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didFinishLaunching:
          return .none
      }
    }
  }
}
