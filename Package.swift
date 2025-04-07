// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let essentialsPackageLocal: Bool = false
let testCaseExtensionPackageLocal: Bool = false

let oscaEssentialsVersion = Version("1.1.0")
let oscaTestCaseExtensionVersion = Version("1.1.0")
let matomoVersion = Version("7.7.0")

let package = Package(
  name: "OSCADistrict",
  defaultLocalization: "de",
  platforms: [.iOS(.v15)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "OSCADistrict",
      targets: ["OSCADistrict"]
    ),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/parse-community/Parse-SDK-iOS-OSX.git", from: "4.1.1"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.2.3"),
    .package(url: "https://github.com/SDWebImage/SDWebImageSVGCoder.git", from: "1.7.0"),
    .package(url: "https://github.com/joshuawright11/papyrus.git", .upToNextMinor(from: "0.6.16")),
    .package(url: "https://github.com/hmlongco/Factory.git", from: "2.4.1"),
    .package(url: "https://github.com/gonzalezreal/swift-markdown-ui", from: "2.4.1"),
    .package(url: "https://github.com/SDWebImage/SDWebImageVideoCoder.git", from: "0.2.0"),
    .package(url: "https://github.com/matomo-org/matomo-sdk-ios.git", .upToNextMinor(from: matomoVersion)),
    /* OSCAEssentials */
    /// use local package path
    essentialsPackageLocal ? .package(path: "modules/OSCAEssentials") :
    .package(url: "https://git-dev.solingen.de/smartcityapp/modules/oscaessentials-ios.git",
             .upToNextMinor(from: oscaEssentialsVersion)),
    // OSCATestCaseExtension
    /// use local package path
    testCaseExtensionPackageLocal ? .package(path: "modules/OSCATestCaseExtension") :
    .package(url: "https://git-dev.solingen.de/smartcityapp/modules/oscatestcaseextension-ios.git",
             .upToNextMinor(from: oscaTestCaseExtensionVersion)),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "OSCADistrict",
      dependencies: [
        .product(name: "ParseObjC", package: "Parse-SDK-iOS-OSX"),
        .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
        .product(name: "SDWebImageVideoCoder", package: "SDWebImageVideoCoder"),
        .product(name: "SDWebImageSVGCoder", package: "SDWebImageSVGCoder"),
        .product(name: "Factory", package: "factory"),
        .product(name: "Papyrus", package: "papyrus"),
        .product(name: "MarkdownUI", package: "swift-markdown-ui"),
        /* OSCAEssentials */
        .product(name: "OSCAEssentials",
                 package: essentialsPackageLocal ? "OSCAEssentials" : "oscaessentials-ios"),
        .product(name: "MatomoTracker", package: "matomo-sdk-ios"),
      ],
      path: "OSCADistrict/OSCADistrict",
      exclude: [
        "Info.plist",
        "SupportingFiles"
      ],
      resources: [.process("Resources")]),
    .testTarget(
      name: "OSCADistrictTests",
      dependencies: ["OSCADistrict",
        .product(name: "OSCATestCaseExtension", package: "oscatestcaseextension-ios")
      ],
      path: "OSCADistrict/OSCADistrictTests",
      exclude: ["Info.plist"],
      resources: [.process("Resources")]
    ),
  ]
)
