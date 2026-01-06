// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyToast",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MyToast",
            targets: ["MyToast"]
        ),
    ],
    targets: [
        .target(
            name: "MyToast",
            path: "Sources/MyToast"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
