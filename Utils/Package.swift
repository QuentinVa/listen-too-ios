// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "Utils",
    platforms: [
        .iOS(.v15), .macOS(.v15), .watchOS(.v11)
    ],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"]
        )
    ],
    targets: [
        .target(
            name: "Utils",
            dependencies: []
        ),
        .testTarget(
            name: "UtilsTests",
            dependencies: ["Utils"]
        )
    ]
)

for target in package.targets {
    var settings = target.swiftSettings ?? []
    // InternalImportsByDefault to be deleted when feature activated by default
    settings.append(.enableUpcomingFeature("InternalImportsByDefault"))
    target.swiftSettings = settings
}
