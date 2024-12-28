//
//  DefaultTextFieldPreview.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 21.10.2024.
//

import SwiftUI
import FoundationUI

#if DEBUG

@_spi(Preview)
public struct DefaultTextFieldPreview: View {

    @FocusState
    private var isFocused: Bool
    
    @State
    private var text: String = ""
    
    // MARK: - State
    
    @State
    private var isError: Bool = false
    @State
    private var isDisabled: Bool = false
    
    // MARK: - Content
    
    @State
    private var showPlaceholder: Bool = false
    @State
    private var showLabel: Bool = false
    @State
    private var showCaption: Bool = false
    
    // MARK: - Views
    
    @State
    private var showLeftView: Bool = false
    @State
    private var showRightView: Bool = false
    
    // MARK: - Configuration
    
    @State
    private var showClearButton: Bool = false
    @State
    private var showRequiredIndicator: Bool = false
    
    // MARK: - Character Limit Configuration
    
    @State
    private var enableCharacterLimitConfiguration: Bool = false
    @State
    private var characterLimit: Int = 20
    @State
    private var enableCharacterLimitAppereance: Bool = false
    @State
    private var characterLimitAppereance: Int = 10
    
    // MARK: - Life cycle
    
    public init() {}
    
    // MARK: - Body
    
    public var body: some View {
        VStack(spacing: 0.0) {
            VStack {
                Text("DefaultTextField")
                    .font(.senseHOne)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer() // Buffer
                
                input
                    .focused($isFocused)
                    .disabled(
                        isDisabled
                    )
                
                Spacer() // Buffer
                
            }
            .inputSize(.regular)
            .inputStyle(.regular)
            .inputRequired(showRequiredIndicator)
            .inputClearButtonEnabled(showClearButton)
            .inputClearButtonAction {
                self.text = ""
            }
            .inputCharacterLimitConfiguration(
                enableCharacterLimitConfiguration ?  CoreInputCharacterLimitConfiguration(
                    limit: characterLimit,
                    appearenceLimit: enableCharacterLimitAppereance ? characterLimitAppereance : nil
                ) : nil
            )
            .frame(height: 200.0) // Buffer and fixed size make animations work better
            .padding(.horizontal, .spacer24)
            .contentShape(Rectangle())
            .onTapGesture {
                isFocused = false
            }
            
            
            Divider()
            
            List {
                
                stateSection
                
                contentSection
                
                contentConfiguration
                
                iconsSection
                
                characterLimitConfigurationSection
            }
        }
    }
    
    
    @ViewBuilder
    private var input: some View {
        DefaultTextField(
            text: $text,
            placeholder: showPlaceholder ? "Placeholder" : nil,
            label: showLabel ? "Label" : nil,
            caption: showCaption ? "Caption" : nil,
            error: isError ? "Some error" : nil,
            leftView: {
                if showLeftView {
                    Image(systemName: "cart")
                }
            },
            rightView: {
                if showRightView {
                    Image(systemName: "microphone")
                }
            }
        )
    }
    
    @ViewBuilder
    private var stateSection: some View {
        Section("State") {
            Toggle("Show error", isOn: $isError)
            Toggle("Make disabled", isOn: $isDisabled)
        }
    }
    
    @ViewBuilder
    private var contentSection: some View {
        Section("Content") {
            Toggle("Show placeholder", isOn: $showPlaceholder)
            Toggle("Show label", isOn: $showLabel)
            Toggle("Show caption", isOn: $showCaption)
        }
    }
    
    @ViewBuilder
    private var contentConfiguration: some View {
        Section("Configuration") {
            Toggle("Show clear button", isOn: $showClearButton)
            Toggle("Show required indicator", isOn: $showRequiredIndicator)
                .disabled(!showLabel)
        }
    }
    
    @ViewBuilder
    private var iconsSection: some View {
        Section("Icons") {
            Toggle("Show left icon", isOn: $showLeftView)
            Toggle("Show right icon", isOn: $showRightView)
        }
    }
    
    @ViewBuilder
    private var characterLimitConfigurationSection: some View {
        Section("Character limit configuration") {
            Toggle("Enable character limit", isOn: $enableCharacterLimitConfiguration)
            Group {
                Stepper("Character limit: \(characterLimit)", value: $characterLimit, in: 1...100)
                Toggle("Show character limit appereance", isOn: $enableCharacterLimitAppereance)
                Stepper("Character limit appereance: \(characterLimitAppereance)", value: $characterLimitAppereance, in: 1...100)
                    .disabled(!enableCharacterLimitAppereance)
            }
            .disabled(!enableCharacterLimitConfiguration)
        }
    }
}

#Preview {
    DefaultTextFieldPreview()
}

#endif
