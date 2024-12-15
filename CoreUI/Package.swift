// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreUI",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: TargetNames.foundationUI,
            targets: [TargetNames.foundationUI]
        ),
        .library(
            name: TargetNames.coreUI,
            targets: [TargetNames.coreUI]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/siteline/swiftui-introspect",
            .upToNextMajor(
                from: "1.3.0"
            )
        )
    ],
    targets: [
        .target(
            name: TargetNames.foundationUI,
            dependencies:
            [
                .product(name: "SwiftUIIntrospect", package: "swiftui-introspect")
            ],
            path: "Sources/FoundationUI"
        ),
        .target(
            name: TargetNames.coreUI,
            dependencies:
            [
                .target(name: TargetNames.foundationUI)
            ],
            path: "Sources/CoreUI"
        )
    ]
)

// MARK: - TARGET NAMES

fileprivate struct TargetNames {
    static let foundationUI: String = "FoundationUI"
    static let coreUI: String = "CoreUI"
}
