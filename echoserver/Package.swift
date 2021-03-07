// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "echoserver",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    dependencies: [
        .package(url: "git@github.com:apple/swift-nio.git", .upToNextMajor(from: "2.26.0"))
    ],
    targets: [
        .target(
            name: "echoserver",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio")
            ]
        ),
        .testTarget(
            name: "echoserverTests",
            dependencies: ["echoserver"]),
    ]
)
