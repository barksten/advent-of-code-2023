// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "advent-of-code-2023",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
        name: "Common",
        targets: [
            "Common"
        ]
    ),
    .executable(
      name: "Day1",
      targets: ["Day1"]
    ),
    .executable(
      name: "Day2",
      targets: ["Day2"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.13.0"),
  ],
  targets: [
    .target(
        name: "Common"
    ),
    .executableTarget(
      name: "Day1",
      dependencies: [
        "Common",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),
    .executableTarget(
      name: "Day2",
      dependencies: [
        "Common",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "Parsing", package: "swift-parsing"),
      ]
    ),
    .testTarget(
      name: "Day1Tests",
      dependencies: ["Day1"],
      resources: [
        .process("input.txt")
      ]
    ),
    .testTarget(
      name: "Day2Tests",
      dependencies: ["Day2"],
      resources: [
        .process("input.txt")
      ]
    ),
  ]
)
