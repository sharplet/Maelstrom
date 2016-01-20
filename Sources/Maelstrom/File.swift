public struct File {

  public private(set) var path: String

  public init(_ path: String) {
    self.path = path
  }

  public func read() throws -> String {
    let file = try FileHandle.open(path, "r")
    var bytes = Array(FileChunkSequence(file: file).flatten())
    bytes.append(0)
    try file.validate()
    return String.fromCString(bytes) ?? ""
  }

  public mutating func rename(newPath: String) throws {
    try Maelstrom.rename(from: path, to: newPath)
    path = newPath
  }

}
