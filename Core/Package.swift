// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: TargetNames.coreDependencies,
            targets: [
                TargetNames.coreDependencies
            ]),
        .library(
            name: TargetNames.coreFeature,
            targets: [
                TargetNames.coreFeature,
                TargetNames.coreDependencies,
            ]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "1.17.0")
    ],
    targets: [
        .target(
            name: TargetNames.coreFeature,
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: TargetNames.coreDependencies,
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture")
            ]
        ),
    ]
)

// MARK: - TARGET NAMES

private enum TargetNames {
    static let coreFeature: String = "CoreFeature"
    static let coreFeatureUI: String = "CoreFeatureUI"
    static let coreDependencies: String = "CoreDependencies"
}
