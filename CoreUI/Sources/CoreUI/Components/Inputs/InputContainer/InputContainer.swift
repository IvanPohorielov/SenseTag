//
//  InputContainer.swift
//
//
//  Created Ivan Pohorielov on 23.01.2024.
//  Copyright © 2024 Evo.company. All rights reserved.
//

import Combine
import FoundationUI
import SwiftUI

struct InputContainer<
    Input: View,
    Label: View,
    Caption: View,
    ErrorLabel: View
>: View, InputContainerEnvProtocol {
    private let input: Input
    private let label: Label?
    private let caption: Caption?
    private let error: ErrorLabel?

    @Binding
    private var text: String

    private let state: CoreInputState

    // MARK: - Properties

    @Environment(\.inputContainerSize)
    var size: any CoreInputContainerSizeProtocol

    @Environment(\.inputContainerStyle)
    var style: any CoreInputContainerStyleProtocol

    @Environment(\.inputCharacterLimitConfiguration)
    var characterLimitConfiguration: CoreInputCharacterLimitConfiguration?

    // MARK: - State

    @State
    private var counterText: String?

    @State
    private var counterError: Bool = false

    private var captionProxy: AnyView? {
        state == .error ? AnyView(error) : AnyView(caption)
    }

    private var isAppearanceLimit: Bool? {
        guard let appearenceLimit = characterLimitConfiguration?.appearenceLimit else {
            return nil
        }

        return appearenceLimit <= text.count
    }
    
    // MARK: - Init

    init(
        _ text: Binding<String>,
        state: CoreInputState,
        label: Label,
        caption: Caption,
        error: ErrorLabel,
        input: () -> Input
    ) {
        _text = text
        self.state = state
        self.label = label
        self.caption = caption
        self.error = error
        self.input = input()
    }

    // MARK: - Views

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: size.containerStackSpacing
        ) {
            labelView
                .zIndex(0)
            inputView
                .zIndex(2)
            captionView
                .zIndex(1)
        }
        .animation(
            .easeInOut(duration: 0.2),
            value: isAppearanceLimit
        )
    }

    @ViewBuilder
    private var labelView: some View {
        if let label = label {
            HStack(spacing: 0.0) {
                label
                    .font(size.labelFont)
                    .foregroundColor(style.labelForegroundColor)
                    .accessibilityIdentifier(Accessibility.labelView.rawValue)
            }
            .transition(
                .move(
                    edge: .bottom
                )
                .combined(
                    with: .opacity
                )
            )
        }
    }

    @ViewBuilder
    private var captionView: some View {
        if captionProxy != nil || counterText != nil {
            HStack(
                alignment: .top,
                spacing: size.captionStackSpacing
            ) {
                if let caption = captionProxy {
                    caption
                        .font(size.captionFont)
                        .foregroundColor(style.captionForegroundColor(for: state))
                        .accessibilityIdentifier(Accessibility.captionView.rawValue)
                }

                if let characterCounter = counterText,
                   isAppearanceLimit ?? true
                {
                    Spacer(minLength: 0.0)

                    Text(characterCounter)
                        .font(size.counterFont)
                        .foregroundColor(style.counterForegroundColor(for: self.counterError ? .error : state))
                        .accessibilityIdentifier(Accessibility.characterCounterView.rawValue)
                }
            }
            .transition(
                .move(
                    edge: .top
                )
                .combined(
                    with: .opacity
                )
            )
        }
    }

    private var inputView: some View {
        input
            .onReceive(Just(text)) { newValue in
                let processedTextData = self.truncateIfLimit(
                    limit: characterLimitConfiguration?.limit,
                    text: newValue
                )

                if processedTextData.isLimit {
                    text = processedTextData.limitedText
                }

                self.counterText = makeCharactersCounterText(newValue)
                self.counterError = processedTextData.isLimit
            }
            .onChange(of: counterError) { _, newValue in
                if newValue {
                    DefaultHaptics.sendHapticFeedback(.notification(.warning))
                }
            }
            .padding(.vertical, size.contentVerticalPadding)
            .padding(.horizontal, size.contentHorizontalPadding)
            .background {
                RoundedRectangle(
                    cornerRadius: size.containerCornerRadius,
                    style: .continuous
                )
                .fill(style.backgroundColor(for: state))
            }
            .overlay {
                RoundedRectangle(
                    cornerRadius: size.containerCornerRadius,
                    style: .continuous
                )
                .strokeBorder(
                    style.outlineColor(for: state),
                    lineWidth: size.containerBorderWidth
                )
            }
            .contentShape(Rectangle())
    }

    // MARK: - Private

    private func makeCharactersCounterText(_ text: String) -> String? {
        guard let characterLimit = characterLimitConfiguration?.limit else { return nil }

        return "\(text.count)/\(characterLimit)"
    }

    private func truncateIfLimit(
        limit: Int?,
        text: String
    ) -> (limitedText: String, isLimit: Bool) {
        if let characterLimit = limit,
           text.count >= characterLimit
        {
            let limitedText = String(text.prefix(characterLimit))
            return (limitedText: limitedText, isLimit: true)
        } else {
            return (limitedText: text, isLimit: false)
        }
    }
}
