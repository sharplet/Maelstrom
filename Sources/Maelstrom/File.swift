public struct File {

  public private(set) var path: String

  public init(_ path: String) {
    self.path = path
  }

  public func read() throws -> String {
    let file = try FileHandle.open(path, "r")
    let generator = FileChunkGenerator(file)
    return try generator.read()
  }

  public mutating func rename(newPath: String) throws {
    try Maelstrom.rename(from: path, to: newPath)
    path = newPath
  }

}
