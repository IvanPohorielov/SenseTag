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

    @State
    private var animate = false
    @ScaledMetric(relativeTo: DefaultFont.hZero.textStyle)
    private var largeImageSize: CGFloat = .image56

    var body: some View {
        DefaultBackground {
            backgroundAnimation

            VStack(spacing: .spacer16) {
                tile(
                    "Other",
                    image: "ellipsis.circle.fill",
                    span: 2
                )
                .onTapGesture {
                    store.send(.otherTapped)
                }
                tile(
                    "Read Tag",
                    image: "magnifyingglass.circle.fill",
                    span: 4
                )
                .onTapGesture {
                    store.send(.readTapped)
                }
                tile(
                    "Create Tag",
                    image: "plus.circle.fill",
                    span: 4
                )
                .onTapGesture {
                    store.send(.writeTapped)
                }
            }
            .safeAreaPadding(.spacer16)
        }
        .alert(
            $store.scope(state: \.alert, action: \.alert)
        )
        .confirmationDialog(
            $store.scope(state: \.confirmationDialog, action: \.confirmationDialog)
        )
        .sheet(
            item: $store.scope(state: \.readTag, action: \.readTag)
        ) { readTagStore in
            NavigationStack {
                ReadTagSheet(store: readTagStore)
            }
            .presentationCornerRadius(40.0)
            .presentationDetents([.medium, .large])
            .presentationBackground(Material.regular)
        }
    }

    private func tile(
        _ title: LocalizedStringKey,
        image: String,
        span: Int
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
    }

    private var backgroundAnimation: some View {
        ForEach(0 ..< 5) { index in
            Circle()
                .stroke(lineWidth: 12.0)
                .foregroundStyle(Color.blue.primary)
                .opacity(animate ? 0 : 0.5)
                .scaleEffect(animate ? 2 : 0.1)
                .animation(
                    Animation.easeOut(duration: 12)
                        .repeatForever()
                        .delay(Double(index) * 2),
                    value: animate
                )
        }
        .onAppear {
            animate = true
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
