import PackageDescription

let package = Package(
  name: "Maelstrom",
  targets: [
    Target(name: "Maelstrom", dependencies: [.Target(name: "libc")]),
    Target(name: "rename", dependencies: [
      .Target(name: "util"),
      .Target(name: "Maelstrom")]),
  ])
