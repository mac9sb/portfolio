// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Portfolio",
    platforms: [
        .macOS(.v15), .tvOS(.v13), .iOS(.v16), .watchOS(.v6), .visionOS(.v2),
    ],
    dependencies: [
        .package(url: "https://github.com/mac9sb/web-ui", branch: "main"),
        .package(url: "https://github.com/swiftlang/swift-testing", from: "0.11.0"),

    ],
    targets: [
        .executableTarget(
            name: "Portfolio",
            dependencies: [
                .product(name: "WebUI", package: "web-ui"),
                .product(name: "WebUIMarkdown", package: "web-ui"),
            ],
            resources: [
                .process("Content")
            ]
        ),
        .testTarget(
            name: "PortfolioTests",
            dependencies: [
                "Portfolio",
                .product(name: "Testing", package: "swift-testing"),
            ]
        ),
    ]
)
