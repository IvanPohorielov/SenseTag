//
//  ReadTagSheet.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.01.2025.
//

import ComposableArchitecture
import CoreUI
import FoundationUI
import NFCNDEFManager
import SwiftUI

struct ReadTagSheet: View {

    var store: StoreOf<ReadTagFeature>

    // MARK: - Body

    var body: some View {
        ScrollView {
            LazyVStack(spacing: .spacer8) {
                ForEach(
                    Array(zip(store.payloads.indices, store.payloads)), id: \.1
                ) { index, payload in
                    recordItem(payload, number: index + 1)
                }
            }
            .safeAreaPadding(.horizontal, .spacer16)
            .safeAreaPadding(.bottom, .spacer16)
        }
        .navigationTitle("Read Tag")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    store.send(.dismiss)
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.secondary)
                        .font(.system(size: 20))
                        .opacity(0.8)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }

    // MARK: - Views

    @ViewBuilder
    private func recordItem(
        _ payload: NFCNDEFManagerPayload,
        number: Int
    ) -> some View {
        HStack(spacing: .spacer8) {
            VStack(spacing: .spacer8) {
                Text("Record #\(number)")
                    .font(.senseCaption)
                    .foregroundStyle(Color.black.shade700)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(getText(from: payload))
                    .font(.senseBodyL)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            recordActions(payload)
        }
        .padding(.spacer16)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(
            .rect(cornerRadius: .radius8)
        )
    }

    @ViewBuilder
    private func recordActions(
        _ payload: NFCNDEFManagerPayload
    ) -> some View {
        switch payload {
        case let .wellKnown(wellKnownPayload):
            switch wellKnownPayload {
            case let .text(text, _):
                IconButton(icon: .systemImage("waveform")) {
                    store.send(.speakUp(wellKnownPayload))
                }
                IconButton(icon: .systemImage("document.on.document.fill")) {
                    store.send(.copyToClipboard(text))
                }
            case let .url(url):
                IconButton(icon: .systemImage("link")) {
                    store.send(.openURL(url))
                }
                IconButton(icon: .systemImage("document.on.document.fill")) {
                    store.send(.copyToClipboard(url.absoluteString))
                }
            }
        default:
            EmptyView()
        }
    }
}

extension ReadTagSheet {
    fileprivate func getText(from payload: NFCNDEFManagerPayload)
        -> LocalizedStringKey
    {
        switch payload {
        case let .wellKnown(wellKnownPayload):
            switch wellKnownPayload {
            case let .text(text, _):
                LocalizedStringKey(text)
            case let .url(url):
                LocalizedStringKey(url.absoluteString)
            }
        case .empty:
            "Empty payload"
        case .other:
            "Unknown payload"
        }
    }
}

#Preview {
    NavigationStack {
        ReadTagSheet(
            store: Store(
                initialState: ReadTagFeature.State(
                    payloads: [
                        .wellKnown(.text("Hello, Preview", .current)),
                        .wellKnown(.url(URL(string: "https://www.apple.com")!)),
                    ]
                )
            ) {
                ReadTagFeature()
            }
        )
    }
}
