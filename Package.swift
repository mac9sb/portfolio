// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Portfolio",
    platforms: [
        .macOS(.v15), .tvOS(.v13), .iOS(.v16), .watchOS(.v6), .visionOS(.v2),
    ],
    dependencies: [
        .package(path: "../../tooling/web-ui"),
        .package(url: "https://github.com/swiftlang/swift-testing", from: "0.11.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "Portfolio",
            dependencies: [
                .product(name: "WebUI", package: "web-ui"),
                .product(name: "WebUIMarkdown", package: "web-ui"),
            ],
            resources: [
                .copy("Content")
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
