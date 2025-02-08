//
//  UIApplicationClient.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 09.02.2025.
//

import ComposableArchitecture
import UIKit

@DependencyClient
struct UIApplicationClient {
    var canOpenURL: @MainActor @Sendable (URL) async -> Bool = { _ in false }
    var openSettings: @MainActor @Sendable () async -> Void = {}
    var openNotificationSettings: @MainActor @Sendable () async -> Void = {}
    var openDefaultApplicationsSettings: @MainActor @Sendable () async -> Void =
        {}
}

extension UIApplicationClient: DependencyKey {
    static let liveValue: UIApplicationClient = {
        @Dependency(\.openURL) var openURL

        return UIApplicationClient(
            canOpenURL: { [openURL] url in
                UIApplication.shared.canOpenURL(url)
            },
            openSettings: { [openURL] in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    await openURL(url)
                }
            },
            openNotificationSettings: { [openURL] in
                if let url = URL(
                    string: UIApplication.openNotificationSettingsURLString)
                {
                    await openURL(url)
                }
            },
            openDefaultApplicationsSettings: { [openURL] in
                if #available(iOS 18.3, *) {
                    if let url = URL(
                        string: UIApplication
                            .openDefaultApplicationsSettingsURLString)
                    {
                        await openURL(url)
                    }
                }
            }
        )
    }()
}

extension DependencyValues {
    var application: UIApplicationClient {
        get { self[UIApplicationClient.self] }
        set { self[UIApplicationClient.self] = newValue }
    }
}
