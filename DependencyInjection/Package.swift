// swift-tools-version: 6.0

import CompilerPluginSupport
import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "DependencyInjection",
    platforms: [
        .macOS(.v10_15), .iOS(.v15)
    ],
    products: [
        .library(
            name: "DependencyInjection",
            targets: ["DependencyInjection"]
        )
    ],
    dependencies: [
        // local binary : (when building from .github/bootstrap.sh of enki-fork-swift-syntax-xcframeworks)
        /*
        .binaryTarget(
            name: "SwiftSyntaxWrapper",
            path: "./SwiftSyntaxWrapper.xcframework"
        )
        */
        .package(url: "https://github.com/apple/swift-syntax", from: "600.0.1") // code source package
    ],
    targets: [
        .target(
            name: "DependencyInjection",
            dependencies: [
                .target(name: "DependencyInjectionMacroImpl")
            ]
        ),
        .macro(
            name: "DependencyInjectionMacroImpl",
            dependencies: [
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax", condition: .when(platforms: [.macOS])),
                .product(name: "SwiftSyntax", package: "swift-syntax", condition: .when(platforms: [.macOS])),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax", condition: .when(platforms: [.macOS])),
                .product(name: "SwiftDiagnostics", package: "swift-syntax", condition: .when(platforms: [.macOS]))
                
            ],
            swiftSettings: [
                .unsafeFlags(["-O"]) // quicker code for the plugin which runs on our macs when building the app
            ],
            // prevent ld: warning: ignoring duplicate libraries: '-lSwiftSyntaxWrapper'
            linkerSettings: [.unsafeFlags(["-Xlinker", "-no_warn_duplicate_libraries"])]
        ),
        // Tests
        .testTarget(
            name: "DependencyInjectionMacroTests",
            dependencies: [
                "DependencyInjection",
                "DependencyInjectionMacroImpl",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
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
