//
//  LPLinkViewRepresentable.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 10.03.2025.
//


import SwiftUI
@preconcurrency import LinkPresentation

/// A view that displays an Open Graph Protocol preview of the given URL.
public struct LinkPresentationView: UIViewRepresentable {
    
    /// The URL of the content to display.
    private let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public func makeUIView(context: Context) -> LPLinkView {
        let linkView = LPLinkView(url: url)
        linkView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        linkView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        linkView.sizeToFit()
        return linkView
    }
    
    public func updateUIView(_ uiView: LPLinkView, context: Context) {
        let provider = LPMetadataProvider()
        Task {
            if let metadata = try? await provider.startFetchingMetadata(for: url) {
                await MainActor.run {
                    uiView.metadata = metadata
                }
            }
        }
    }
}


