// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .macOS("10.15")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "video_player_avfoundation", path: "../.packages/video_player_avfoundation"),
        .package(name: "url_launcher_macos", path: "../.packages/url_launcher_macos"),
        .package(name: "audioplayers_darwin", path: "../.packages/audioplayers_darwin"),
        .package(name: "firebase_core", path: "../.packages/firebase_core"),
        .package(name: "firebase_ai", path: "../.packages/firebase_ai"),
        .package(name: "firebase_auth", path: "../.packages/firebase_auth"),
        .package(name: "firebase_app_check", path: "../.packages/firebase_app_check"),
        .package(name: "FlutterFramework", path: "../.packages/FlutterFramework")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "video-player-avfoundation", package: "video_player_avfoundation"),
                .product(name: "url-launcher-macos", package: "url_launcher_macos"),
                .product(name: "audioplayers-darwin", package: "audioplayers_darwin"),
                .product(name: "firebase-core", package: "firebase_core"),
                .product(name: "firebase-ai", package: "firebase_ai"),
                .product(name: "firebase-auth", package: "firebase_auth"),
                .product(name: "firebase-app-check", package: "firebase_app_check"),
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
