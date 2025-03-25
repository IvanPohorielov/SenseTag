//
//  MainScreenTileView.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 25.03.2025.
//

import SwiftUI
import FoundationUI

public struct MainScreenTileView: View {

    private let title: LocalizedStringKey
    private let systemImage: String
    private let span: Int
    private let action: @MainActor () -> Void

    public init(
        _ title: LocalizedStringKey,
        systemImage: String,
        span: Int,
        action: @MainActor @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.span = span
        self.action = action
    }

    @ScaledMetric(relativeTo: DefaultFont.hZero.textStyle)
    private var largeImageSize: CGFloat = .image56

    public var body: some View {
        VStack {
            Image(systemName: systemImage)
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
        .contentShape(
            .rect(cornerRadius: .radius24)
        )
        .onTapGesture {
            DefaultHaptics.sendHapticFeedback(.selection)
            action()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(Text(title))
    }
}
