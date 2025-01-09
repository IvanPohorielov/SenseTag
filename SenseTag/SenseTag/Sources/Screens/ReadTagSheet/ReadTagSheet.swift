//
//  ReadTagSheet.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.01.2025.
//

import SwiftUI
import FoundationUI
import CoreUI
import ComposableArchitecture
import NFCNDEFManager

struct ReadTagSheet: View {
    
    var store: StoreOf<ReadTagFeature>
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: .spacer8) {
                ForEach(Array(zip(store.payloads.indices, store.payloads)), id: \.1) { index, payload in
                    recordItem(payload, number: index + 1)
                }
            }
            .safeAreaPadding(.spacer16)
        }
        .navigationTitle("Read Tag")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    store.send(.dismiss)
                } label: {
                    Image(systemName: "xmark")
                }
                .foregroundStyle(Color.black.primary)
                
            }
        }
    }
    
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
        case .wellKnown(let wellKnownPayload):
            switch wellKnownPayload {
            case .text(let text, let locale):
                IconButton {
                    Image(systemName: "waveform")
                } action: {
                    store.send(.speakUp(text, locale))
                }
                IconButton {
                    Image(systemName: "document.on.document.fill")
                } action: {
                    store.send(.copyToClipboard(text))
                }
            case .url(let url):
                IconButton {
                    Image(systemName: "link")
                } action: {
                    store.send(.openURL(url))
                }
                IconButton {
                    Image(systemName: "document.on.document.fill")
                } action: {
                    store.send(.copyToClipboard(url.absoluteString))
                }
            }
        default:
            EmptyView()
        }
    }
}

private extension ReadTagSheet {
    func getText(from payload: NFCNDEFManagerPayload) -> LocalizedStringKey {
        switch payload {
        case .wellKnown(let wellKnownPayload):
            switch wellKnownPayload {
            case .text(let text, _):
                LocalizedStringKey(text)
            case .url(let url):
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
                        .wellKnown(.url(URL(string: "https://www.apple.com")!))
                    ]
                )
            ) {
                ReadTagFeature()
            }
        )
    }
}
