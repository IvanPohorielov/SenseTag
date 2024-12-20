//
//  DefaultButtonPreview.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 21.10.2024.
//

import SwiftUI
import FoundationUI

#if DEBUG

@_spi(Preview)
public struct DefaultButtonPreview: View {
    
    // MARK: - State
    
    @State
    private var isLoading: Bool = false
    @State
    private var isDisabled: Bool = false
    
    // MARK: - Content
    
    @State
    private var isShowIcon: Bool = false
    
    // MARK: - Configuration
    
    @State
    private var size: Size = .regular
    
    @State
    private var style: Style = .secondary
    
    @State
    private var borderShage: BorderShape = .roundedRectangle
    
    @State
    private var isFullWidht: Bool = false
    
    // MARK: - Life cycle
    
    public init() {}
    
    // MARK: - Body
    
    public var body: some View {
        VStack(spacing: 0.0) {
            VStack {
                Text("PromButton")
                    .font(.senseHOne)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer() // Buffer
                
                button
                    .animation(.default, value: isLoading)
                    .animation(.default, value: isDisabled)
                    .animation(.default, value: isShowIcon)
                    .animation(.default, value: size)
                    .animation(.default, value: style)
                    .animation(.default, value: borderShage)
                    .animation(.default, value: isFullWidht)
                
                Spacer() // Buffer
            }
            .defaultButtonSize(size.mapped())
            .defaultButtonStyle(style.mapped())
            .defaultButtonBorderShape(borderShage.mapped())
            .defaultButtonFullWidth(isFullWidht)
            .isLoading(isLoading)
            .disabled(isDisabled)
            .frame(height: 200.0)
            .padding(.horizontal, .spacer24)
            
            Divider()
            
            List {
                
                stateSection
                
                contentSection
                
                configurationSection
            }
        }
    }
    
    
    @ViewBuilder
    private var button: some View {
        DefaultButton(
            text: "Button",
            icon: isShowIcon ? .systemImage("xmark") : nil
        ) {
            DefaultHaptics.sendHapticFeedback(.selection)
        }
    }
    
    @ViewBuilder
    private var stateSection: some View {
        Section("State") {
            Toggle("Show loading", isOn: $isLoading)
            Toggle("Make disabled", isOn: $isDisabled)
        }
    }
    
    @ViewBuilder
    private var contentSection: some View {
        Section("Content") {
            Toggle("Show icon", isOn: $isShowIcon)
        }
    }
    
    @ViewBuilder
    private var configurationSection: some View {
        Section("Configuration") {
            
            Toggle("Make full width", isOn: $isFullWidht)
            
            VStack {
                Text("Bornder shape")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker("", selection: $borderShage) {
                    ForEach(BorderShape.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            VStack {
                HStack {
                    Text("Style")
                        .frame(maxWidth: .infinity)
                    Text("Size")
                        .frame(maxWidth: .infinity)
                }
                HStack {
                    Picker("", selection: $style) {
                        ForEach(Style.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Picker("", selection: $size) {
                        ForEach(Size.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .frame(height: 150)
        }
    }
}

private extension DefaultButtonPreview {
    
    enum Style: Int, Hashable, CaseIterable {
        case primary
        case secondary
        case tertiary
        
        func mapped() -> DefaultButtonStyle {
            switch self {
            case .primary:
                return .primary
            case .secondary:
                return .secondary
            case .tertiary:
                return .tertiary
            }
        }
        
        var name: String {
            switch self {
            case .primary:
                return "Primary"
            case .secondary:
                return "Secondary"
            case .tertiary:
                return "Tertiary"
            }
        }
    }
    
    enum Size: Int, Hashable, CaseIterable {
        case large
        case regular
        case compact
        
        func mapped() -> DefaultButtonSize {
            switch self {
            case .large:
                return .large
            case .regular:
                return .regular
            case .compact:
                return .compact
            }
        }
        
        var name: String {
            switch self {
            case .large:
                return "Large"
            case .regular:
                return "Regular"
            case .compact:
                return "Compact"
            }
        }
    }
    
    enum BorderShape: Int, Hashable, CaseIterable {
        case roundedRectangle
        case capsule
        
        func mapped() -> ButtonCoreBorderShape {
            switch self {
            case .roundedRectangle:
                return .roundedRectangle
            case .capsule:
                return .capsule
            }
        }
        
        var name: String {
            switch self {
            case .roundedRectangle:
                return "Rounded rectangle"
            case .capsule:
                return "Capsule"
            }
        }
    }
}

#Preview {
    DefaultButtonPreview()
}

#endif
