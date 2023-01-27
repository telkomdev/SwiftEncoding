// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftEncoding",
    products: [
        .library(
            name: "SwiftEncoding",
            targets: ["SwiftEncoding"]),
    ],
    targets: [
        .target(
            name: "SwiftEncoding",
            dependencies: []),
        .testTarget(
            name: "SwiftEncodingTests",
            dependencies: ["SwiftEncoding"]),
    ]
)
