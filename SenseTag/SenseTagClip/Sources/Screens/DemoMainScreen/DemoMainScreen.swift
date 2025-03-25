//
//  MainScreen.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 06.01.2025.
//

import ComposableArchitecture
import CoreUI
import FoundationUI
import SwiftUI

struct DemoMainScreen: View {

    @Bindable var store: StoreOf<DemoMainFeature>

    var body: some View {
        MainScreenContainerView {
            ReadTileView(
                span: 4
            ) {
                store.send(.readTapped)
            }
            .accessibilitySortPriority(2)
            .accessibilityHint("mainScreen.tile.read.hint")
        }
        .alert(
            $store.scope(
                state: \.destination?.alert,
                action: \.destination.alert
            )
        )
        .sheet(
            item: $store.scope(
                state: \.destination?.readTag,
                action: \.destination.readTag
            )
        ) { readTagStore in
            NavigationStack {
                ReadTagSheet(store: readTagStore)
            }
            .senseSheet()
        }
    }
}

#Preview {
    DemoMainScreen(
        store: Store(initialState: DemoMainFeature.State()) {
            DemoMainFeature()
        }
    )
}
