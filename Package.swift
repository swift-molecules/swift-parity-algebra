// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-parity-algebra",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Parity Algebra",
            targets: ["Parity Algebra"]
        ),
        .library(
            name: "Parity Algebra Test Support",
            targets: ["Parity Algebra Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-parity.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-algebra.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-optic.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Parity Algebra",
            dependencies: [
                .product(name: "Parity", package: "swift-parity"),
                .product(name: "Algebra Group", package: "swift-algebra"),
                .product(name: "Algebra Field", package: "swift-algebra"),
                .product(name: "Optic", package: "swift-optic"),
            ]
        ),
        .target(
            name: "Parity Algebra Test Support",
            dependencies: [
                "Parity Algebra"
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Parity Algebra Tests",
            dependencies: [
                "Parity Algebra",
                "Parity Algebra Test Support",
                .product(name: "Algebra Module", package: "swift-algebra"),
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
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
