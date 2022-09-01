// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "crypto-protocols-swift",
    products: [
        .library(
            name: "CryptoProtocols",
            targets: [
                "Common",
                "Duplex",
            ]),
    ],
    targets: [
        .target(
            name: "Common"),
        .target(
            name: "Duplex",
            dependencies: ["Common"]),
        .testTarget(
            name: "DuplexTests",
            dependencies: ["Duplex"]),
    ]
)
