// swift-tools-version: 6.3.3

import PackageDescription

let package = Package(
    name: "swift-parity-algebra-primitives",
    platforms: [
        .macOS("27"),
        .iOS("27"),
        .tvOS("27"),
        .watchOS("27"),
        .visionOS("27")
    ],
    products: [
        .library(
            name: "Parity Algebra Primitives",
            targets: ["Parity Algebra Primitives"]
        ),
        .library(
            name: "Parity Algebra Primitives Test Support",
            targets: ["Parity Algebra Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-parity-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-algebra-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-optic-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Parity Algebra Primitives",
            dependencies: [
                .product(name: "Parity Primitives", package: "swift-parity-primitives"),
                .product(name: "Algebra Group Primitives", package: "swift-algebra-primitives"),
                .product(name: "Algebra Field Primitives", package: "swift-algebra-primitives"),
                .product(name: "Optic Primitives", package: "swift-optic-primitives"),
            ]
        ),
        .target(
            name: "Parity Algebra Primitives Test Support",
            dependencies: [
                "Parity Algebra Primitives",
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Parity Algebra Primitives Tests",
            dependencies: [
                "Parity Algebra Primitives",
                "Parity Algebra Primitives Test Support",
                .product(name: "Algebra Module Primitives", package: "swift-algebra-primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
