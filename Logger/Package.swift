// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "Logger",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Logger",
            targets: ["Logger"]
        )
    ],
    dependencies: [
        .package(name: "DependencyInjection", path: "./DependencyInjection"),
        .package(name: "Utils", path: "./Utils")
    ],
    targets: [
        .target(
            name: "Logger",
            dependencies: [
                "DependencyInjection",
                "Utils"
            ]
        ),
        .testTarget(
            name: "LoggerTests",
            dependencies: ["Logger"]
        )
    ]
)

for target in package.targets {
    var settings = target.swiftSettings ?? []
    // InternalImportsByDefault to be deleted when feature activated by default
    settings.append(.enableUpcomingFeature("InternalImportsByDefault"))
    target.swiftSettings = settings
}
