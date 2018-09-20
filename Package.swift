// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OreOre",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "OreOre",
            targets: ["OreOre"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
      .package(url: "git@github.com:apollographql/apollo-ios.git", from: "4.0.0"),
      .package(url: "git@github.com:envoy/Ambassador.git", from: "4.0.0"),
      .package(url: "git@github.com:envoy/Embassy.git", from: "4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "OreOre",
            dependencies: []),
        .testTarget(
            name: "OreOreTests",
            dependencies: ["OreOre"]),
    ]
)
