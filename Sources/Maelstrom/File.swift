public struct File {

  public private(set) var path: String

  public init(_ path: String) {
    self.path = path
  }

  public func read() throws -> String? {
    return try open { $0.read() }
  }

  public func write(string: String) throws {
    return try openTruncatedForWriting { $0.write(string) }
  }

  public func append(string: String) throws {
    return try openForAppending { $0.write(string) }
  }

  public func open<Result>
    (@noescape body: ReadOnlyFile throws -> Result)
    throws -> Result
  {
    return try open("r") {
      let file = ReadOnlyFile($0)
      return try body(file)
    }
  }

  public func openTruncatedForWriting<Result>
    (@noescape body: WriteOnlyFile throws -> Result)
    throws -> Result
  {
    return try open("w") {
      let file = WriteOnlyFile($0)
      return try body(file)
    }
  }

  public func openForAppending<Result>
    (@noescape body: AppendOnlyFile throws -> Result)
    throws -> Result
  {
    return try open("a") {
      let file = AppendOnlyFile($0)
      return try body(file)
    }
  }

  public func openForReadingAndWriting<Result>
    (options options: ReadWriteOptions = .None,
     @noescape body: ReadWriteFile throws -> Result)
    throws -> Result
  {
    return try open(options.mode) {
      let file = ReadWriteFile($0)
      return try body(file)
    }
  }

  internal func open<Result>
    (mode: String, @noescape body: FileHandle throws -> Result)
    throws -> Result
  {
    let file = try FileHandle.open(path, mode)
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
