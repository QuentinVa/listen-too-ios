// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

// swiftlint:disable:next prefixed_toplevel_constant
let package = Package(
    name: "Dependencies",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ResourcesDependencies",
            targets: ["ResourcesDependencies"]
        )
    ],
    dependencies: [
//        .package(
//            // Releases: https://github.com/adeo/listenToo-design-system-ios/releases
//            url: "https://github.com/adeo/listenToo-design-system-ios",
//            exact: "1.77.0"
//        )
    ],
    targets: [
//        // ListenTooDesignSystemDependencies
//        .target(
//            name: "ListenTooDesignSystemDependencies",
//            dependencies: [
//                .product(
//                    name: "ListenTooDesignSystem",
//                    package: "listen-too-design-system-ios"
//                )
//            ],
//            path: ".",
//            sources: ["ListenTooDesignSystemEmpty.swift"]
//        ),
        // Resources
        .target(
            name: "ResourcesDependencies",
            dependencies: [],
            path: ".",
            sources: ["ResourcesEmpty.swift"]
        )
        // SwiftLint binary used in swiftlint.sh script build phase
        // binary is already gathered from design-system
        /*
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.54.0/SwiftLintBinary-macos.artifactbundle.zip",
            // curl -L https://github.com/realm/SwiftLint/releases/download/0.54.0/SwiftLintBinary-macos.artifactbundle.zip \
            // -o /tmp/SwiftLintBinary-macos.artifactbundle.zip
            // sha256sum /tmp/SwiftLintBinary-macos.artifactbundle.zip
            checksum: "963121d6babf2bf5fd66a21ac9297e86d855cbc9d28322790646b88dceca00f1"
        )
        */
    ]
)
