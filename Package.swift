import PackageDescription

let package = Package(
  name: "Maelstrom",
  targets: [
    Target(name: "Maelstrom", dependencies: [.Target(name: "libc")]),
    Target(name: "read", dependencies: [
      .Target(name: "util"),
      .Target(name: "Maelstrom")]),
    Target(name: "rename", dependencies: [
      .Target(name: "util"),
      .Target(name: "Maelstrom")]),
  ])
