public struct File {

  public private(set) var path: String

  public init(_ path: String) {
    self.path = path
  }

  public func read() throws -> String {
    let handle = try FileChunkGenerator(path)
    return try handle.read()
  }

  public mutating func rename(newPath: String) throws {
    try Maelstrom.rename(from: path, to: newPath)
    path = newPath
  }

}
