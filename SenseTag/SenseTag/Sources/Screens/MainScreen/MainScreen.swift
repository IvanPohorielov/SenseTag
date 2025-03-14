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

    @ScaledMetric(relativeTo: DefaultFont.hZero.textStyle)
    private var largeImageSize: CGFloat = .image56

    var body: some View {
        DefaultBackground {
            backgroundAnimation

            VStack(spacing: .spacer16) {
                tile(
                    "mainScreen.tile.other",
                    image: "ellipsis.circle.fill",
                    span: 2
                ) {
                    store.send(.otherTapped)
                }
                tile(
                    "mainScreen.tile.read",
                    image: "magnifyingglass.circle.fill",
                    span: 4
                ) {
                    store.send(.readTapped)
                }
                tile(
                    "mainScreen.tile.write",
                    image: "plus.circle.fill",
                    span: 4
                ) {
                    store.send(.writeTapped)
                }
            }
            .safeAreaPadding(.spacer16)
        }
        .onAppear {
            store.send(.startAnimation)
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
            self.sheetBuilder {
                NavigationStack {
                    ReadTagSheet(store: readTagStore)
                }
            }
        }
        .sheet(
            item: $store.scope(
                state: \.destination?.writeTag,
                action: \.destination.writeTag
            )
        ) { writeTagStore in
            self.sheetBuilder {
                NavigationStack {
                    WriteTagSheet(store: writeTagStore)
                }
            }
        }
    }

    private func tile(
        _ title: LocalizedStringKey,
        image: String,
        span: Int,
        action: @MainActor @escaping () -> Void
    ) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: largeImageSize, height: largeImageSize)
                .foregroundStyle(Color.blue.primary)

            Text(title)
                .font(.senseHZero)
                .frame(maxWidth: .infinity)
        }
        .padding(.spacer16)
        .containerRelativeFrame(
            .vertical,
            count: 10,
            span: span,
            spacing: .spacer16,
            alignment: .center
        )
        .background(.ultraThinMaterial)
        .clipShape(
            .rect(cornerRadius: .radius24)
        )
        .onTapGesture {
            DefaultHaptics.sendHapticFeedback(.selection)
            action()
        }
    }

    @ViewBuilder
    private func sheetBuilder(
        @ViewBuilder sheet: () -> some View
    ) -> some View {
        sheet()
            .presentationCornerRadius(40.0)
            .presentationDetents([.medium, .large])
            .presentationBackground(.regularMaterial)
    }

    private var backgroundAnimation: some View {
        ForEach(0..<5) { index in
            Circle()
                .stroke(lineWidth: 12.0)
                .foregroundStyle(Color.blue.primary)
                .opacity(store.animate ? 0 : 0.5)
                .scaleEffect(store.animate ? 2 : 0.1)
                .animation(
                    Animation.easeOut(duration: 12)
                        .repeatForever()
                        .delay(Double(index) * 2),
                    value: store.animate
                )
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
