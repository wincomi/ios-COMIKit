// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "COMIKit",
	platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "COMIKit",
            targets: ["COMIKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "COMIKit",
            dependencies: []),
        .testTarget(
            name: "COMIKitTests",
            dependencies: ["COMIKit"]),
    ]
)
