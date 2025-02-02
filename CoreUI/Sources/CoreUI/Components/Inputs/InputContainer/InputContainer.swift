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

struct InputContainer<Input: View>: View, InputContainerEnvProtocol {
    private let input: Input

    @Binding
    private var text: String

    private let state: CoreInputState

    private let label: String?
    private let caption: String?
    private let error: String?

    // MARK: - Properties

    @Environment(\.inputContainerSize)
    var size: any CoreInputContainerSizeProtocol

    @Environment(\.inputContainerStyle)
    var style: any CoreInputContainerStyleProtocol

    @Environment(\.inputCharacterLimitConfiguration)
    var characterLimitConfiguration: CoreInputCharacterLimitConfiguration?

    @Environment(\.inputRequired)
    var isRequired: Bool

    // MARK: - State

    @State
    private var counterText: String?

    @State
    private var counterError: Bool = false

    private var captionProxy: String? {
        state == .error ? error : caption
    }

    private var isAppearenceLimit: Bool? {
        guard let appearenceLimit = characterLimitConfiguration?.appearenceLimit else {
            return nil
        }

        return appearenceLimit <= text.count
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
            value: caption != nil ? [label, caption] : [label, captionProxy]
        )
        .animation(
            .easeInOut(duration: 0.2),
            value: isAppearenceLimit
        )
    }

    @ViewBuilder
    private var labelView: some View {
        if let label = label {
            HStack(spacing: 0.0) {
                Text(label)
                    .font(size.labelFont)
                    .foregroundColor(style.labelForegroundColor)
                    .accessibilityIdentifier(Accessibility.labelView.rawValue)

                if isRequired {
                    Text("*")
                        .font(size.labelFont)
                        .foregroundColor(.red.primary)
                        .accessibilityIdentifier(Accessibility.requiredView.rawValue)
                }
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
                    Text(caption)
                        .font(size.captionFont)
                        .foregroundColor(style.captionForegroundColor(for: state))
                        .accessibilityIdentifier(Accessibility.captionView.rawValue)
                }

                if let characterCounter = counterText,
                   isAppearenceLimit ?? true
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

// MARK: - Init

extension InputContainer {
    init(
        text: Binding<String>,
        state: CoreInputState,
        label: String?,
        caption: String?,
        error: String?,
        @ViewBuilder input: () -> Input
    ) {
        _text = text
        self.state = state
        self.label = label
        self.caption = caption
        self.error = error
        self.input = input()
    }
}
