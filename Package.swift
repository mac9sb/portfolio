// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Portfolio",
    platforms: [
        .macOS(.v15), .tvOS(.v13), .iOS(.v16), .watchOS(.v6), .visionOS(.v2),
    ],
    dependencies: [
        .package(path: "../../tooling/web-ui")
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
    ]
)
