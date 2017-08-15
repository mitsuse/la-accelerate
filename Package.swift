// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "LaAccelerate",
    products: [
        .library(name: "LaAccelerate", targets: ["LaAccelerate"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mitsuse/la", .upToNextMinor(from: "0.9.1")),
    ],
    targets: [
        .target(name: "LaAccelerate", dependencies: ["La"]),
        .testTarget(name: "LaAccelerateTests", dependencies: ["LaAccelerate"]),
    ],
    swiftLanguageVersions: [4]
)
