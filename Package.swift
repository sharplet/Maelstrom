import PackageDescription

let package = Package(
  name: "Maelstrom",
  targets: [
    Target(name: "Maelstrom", dependencies: [.Target(name: "libc")]),
    Target(name: "rename", dependencies: [.Target(name: "Maelstrom")]),
  ],
  dependencies: [
    .Package(url: "file:///Users/adamsharp/src/apple/swift-package-manager", majorVersion: 0),
  ])
