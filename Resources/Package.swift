// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "Resources",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Resources",
            targets: [
                "Assets"
            ]
        )
    ],
    dependencies: [
        .package(name: "Dependencies", path: "./Dependencies"),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", exact: "6.6.2")
    ],
    targets: [
        .target(
            name: "Assets",
            dependencies: [
                .product(
                    name: "ResourcesDependencies",
                    package: "Dependencies"
                )
            ],
            resources: [
                .process("Resources/Assets")
            ]
        )
    ]
)

for target in package.targets {
    var settings = target.swiftSettings ?? []
    // InternalImportsByDefault to be deleted when feature activated by default
    settings.append(.enableUpcomingFeature("InternalImportsByDefault"))
    target.swiftSettings = settings
}
