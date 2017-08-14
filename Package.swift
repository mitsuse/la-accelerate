// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "LaAccelerate",
    dependencies: [
        .Package(url: "https://github.com/mitsuse/la", majorVersion: 0, minor: 7),
    ]
)
