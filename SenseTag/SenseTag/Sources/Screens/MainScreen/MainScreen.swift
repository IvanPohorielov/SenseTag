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

struct MainScreen: View {

    @Bindable var store: StoreOf<MainFeature>
    
    var body: some View {
        MainScreenContainerView {
            MainScreenTileView(
                "mainScreen.tile.other",
                systemImage: "ellipsis.circle.fill",
                span: 2
            ) {
                store.send(.otherTapped)
            }
            .accessibilitySortPriority(0)
            .accessibilityHint("mainScreen.tile.other.hint")
            ReadTileView(span: 4) {
                store.send(.readTapped)
            }
            .accessibilitySortPriority(2)
            .accessibilityHint("mainScreen.tile.read.hint")
            MainScreenTileView(
                "mainScreen.tile.write",
                systemImage: "plus.circle.fill",
                span: 4
            ) {
                store.send(.writeTapped)
            }
            .accessibilitySortPriority(1)
            .accessibilityHint("mainScreen.tile.write.hint")
        }
        .alert(
            $store.scope(
                state: \.destination?.alert,
                action: \.destination.alert
            )
        )
        .confirmationDialog(
            $store.scope(
                state: \.destination?.confirmationDialog,
                action: \.destination.confirmationDialog
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
        .sheet(
            item: $store.scope(
                state: \.destination?.writeTag,
                action: \.destination.writeTag
            )
        ) { writeTagStore in
            NavigationStack {
                WriteTagSheet(store: writeTagStore)
            }
            .senseSheet()
        }
    }
}

#Preview {
    MainScreen(
        store: Store(initialState: MainFeature.State()) {
            MainFeature()
        }
    )
}
