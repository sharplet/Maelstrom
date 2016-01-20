public struct File {

  public private(set) var path: String

  public init(_ path: String) {
    self.path = path
  }

  public func read() throws -> String {
    return try open { file in
      var bytes = Array(FileChunkSequence(file: file).flatten())
      bytes.append(0)
      return String.fromCString(bytes) ?? ""
    }
  }

  internal func open<Result>(@noescape body: FileHandle throws -> Result) throws -> Result {
    let file = try FileHandle.open(path, "r")
    do {
      let result = try body(file)
      try file.validate()
      try file.close()
      return result
    // if the error occurred closing the file, propagate it
    } catch let SystemError.CloseError(errno, path) {
      throw SystemError.CloseError(errno, path)
    // otherwise, try to close the file before propagating the error
    } catch {
      try file.close()
      throw error
    }
  }

  public mutating func rename(newPath: String) throws {
    try Maelstrom.rename(from: path, to: newPath)
    path = newPath
  }

}
