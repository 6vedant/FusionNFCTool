// swift-tools-version:5.3

import Foundation
import PackageDescription

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
  name: "NFCTool",
  platforms: [
    .macOS(.v10_14), .iOS(.v13),
  ],
  products: [
    .library(
      name: "NFCTool",
      type: .static,
      targets: [
        "NFCTool"
      ]
    )
  ],
  dependencies: [
    .package(
      name: "FusionNFC", url: "https://github.com/scade-platform/FusionNFC.git", .branch("main"))
  ],
  targets: [
    .target(
      name: "NFCTool",
      dependencies: [
        .product(name: "FusionNFC", package: "FusionNFC")
      ],
      exclude: ["main.page"],
      swiftSettings: [
        .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
        .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
      ]
    )
  ]
)
