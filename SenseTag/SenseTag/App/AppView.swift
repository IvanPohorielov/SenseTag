//
//  AppView.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 07.06.2025.
//

import ComposableArchitecture
import CoreDependencies
import Foundation
import SwiftUI
import FoundationUI

struct AppView: View {
    let store: StoreOf<AppFeature>
    
    init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    var body: some View {
        Group {
            MainScreen(store: store.scope(state: \.main, action: \.main))
        }
        .tint(.blue.primary)
    }
}
