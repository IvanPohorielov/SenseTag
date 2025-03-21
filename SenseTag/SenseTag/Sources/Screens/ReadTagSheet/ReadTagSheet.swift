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
        self.screenView
            .navigationTitle("readTagSheet.navigationTitle")
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
    }

    // MARK: - Views

    @ViewBuilder
    private var screenView: some View {
        if store.payloads.allSatisfy({ $0 == .empty }) {
            empty
        } else {
            content
        }
    }
    
    @ViewBuilder
    private var empty: some View {
        PlaceholderScreen {
            Text("readTagSheet.empty.title")
                .font(.senseHOne)
        } label: {
            Text("readTagSheet.empty.label")
                .font(.senseLabelM)
        }
    }
    
    @ViewBuilder
    private var content: some View {
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
    }
    

    @ViewBuilder
    private func recordItem(
        _ payload: NFCNDEFManagerPayload,
        number: Int
    ) -> some View {
        HStack(spacing: .spacer8) {
            VStack(spacing: .spacer8) {
                let localizedStringKey: LocalizedStringKey =
                    "readTagSheet.recordItem.record \(number)"
                Text(localizedStringKey)
                    .font(.senseCaption)
                    .foregroundStyle(Color.black.shade700)
                    .frame(maxWidth: .infinity, alignment: .leading)
                self.getContentView(from: payload)
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
            case .url:
                EmptyView()
            }
        default:
            EmptyView()
        }
    }
}

extension ReadTagSheet {
    @ViewBuilder
    fileprivate func getContentView(from payload: NFCNDEFManagerPayload)
        -> some View
    {
        switch payload {
        case let .wellKnown(wellKnownPayload):
            switch wellKnownPayload {
            case let .text(text, _):
                Text(text)
                    .font(.senseBodyL)
                    .frame(maxWidth: .infinity, alignment: .leading)
            case let .url(url):
                LinkPresentationView(url: url)
            }
        case .empty:
            Text("readTagSheet.recordItem.empty")
                .font(.senseBodyL)
                .frame(maxWidth: .infinity, alignment: .leading)
        case .other:
            Text("readTagSheet.recordItem.unknown")
                .font(.senseBodyL)
                .frame(maxWidth: .infinity, alignment: .leading)
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
                        .wellKnown(.text("Ти така гарна", .current)),
                        .wellKnown(.url(URL(string: "https://www.apple.com")!)),
                        .wellKnown(
                            .url(
                                URL(
                                    string:
                                        "https://www.youtube.com/watch?v=KPqK5LyGsiE"
                                )!)),
                    ]
                )
            ) {
                ReadTagFeature()
            }
        )
    }
}
