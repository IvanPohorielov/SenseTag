//
//  Haptics.swift
//
//
//  Created by Ivan Pohorielov on 22.04.2024.
//

import UIKit

@MainActor
public enum DefaultHaptics {
    public enum HapticFeedbackType {
        case selection
        case light(_ intensity: CGFloat = 1.0)
        case medium(_ intensity: CGFloat = 1.0)
        case heavy(_ intensity: CGFloat = 1.0)
        case notification(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType)
    }

    private static let isEnabled: Bool = true

    private static let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    private static let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private static let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private static let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    private static let notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    public static func prepareHapticFeedbackGenerator(_ type: HapticFeedbackType) {
        guard isEnabled else { return }

        switch type {
        case .selection: selectionFeedbackGenerator.prepare()
        case .light: lightImpactFeedbackGenerator.prepare()
        case .medium: mediumImpactFeedbackGenerator.prepare()
        case .heavy: heavyImpactFeedbackGenerator.prepare()
        case .notification: notificationFeedbackGenerator.prepare()
        }
    }

    public static func sendHapticFeedback(_ type: HapticFeedbackType) {
        guard isEnabled else { return }

        prepareHapticFeedbackGenerator(type)

        switch type {
        case .selection: selectionFeedbackGenerator.selectionChanged()
        case let .light(intensity): Self.lightImpactFeedbackGenerator.impactOccurred(intensity: intensity)
        case let .medium(intensity): Self.mediumImpactFeedbackGenerator.impactOccurred(intensity: intensity)
        case let .heavy(intensity): Self.heavyImpactFeedbackGenerator.impactOccurred(intensity: intensity)
        case let .notification(type): Self.notificationFeedbackGenerator.notificationOccurred(type)
        }
    }
}
