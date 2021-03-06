import PackageDescription

let package = Package(
  name: "Maelstrom",
  targets: [
    Target(name: "Maelstrom", dependencies: [.Target(name: "libc")]),
    Target(name: "util", dependencies: [.Target(name: "libc")]),
    Target(name: "read", dependencies: [
      .Target(name: "util"),
      .Target(name: "Maelstrom")]),
    Target(name: "readwrite", dependencies: [
      .Target(name: "util"),
      .Target(name: "Maelstrom")]),
    Target(name: "rename", dependencies: [
      .Target(name: "util"),
      .Target(name: "Maelstrom")]),
    Target(name: "seek", dependencies: [
      .Target(name: "util"),
      .Target(name: "Maelstrom")]),
    Target(name: "stdio", dependencies: [
      .Target(name: "Maelstrom")]),
    Target(name: "write", dependencies: [
      .Target(name: "util"),
      .Target(name: "Maelstrom")]),
  ])
