// MARK: - Protocols

public protocol Readable {
  func read(inout buffer: [CChar]) -> Int
}

public protocol Seekable {
  func rewind()
  // TODO: Custom index for seeking?
}

typealias Writable = OutputStreamType

// MARK: - File handle decorators

public final class ReadOnlyFile: Readable, Seekable {

  internal let handle: FileHandle

  internal init(_ handle: FileHandle) {
    self.handle = handle
  }

  public func read(inout buffer: [CChar]) -> Int {
    return handle.read(&buffer)
  }

  public func rewind() {
    handle.rewind()
  }

}

public final class WriteOnlyFile: Writable, Seekable {

  internal let handle: FileHandle

  internal init(_ handle: FileHandle) {
    self.handle = handle
  }

  public func write(string: String) {
    handle.write(string)
  }

  public func rewind() {
    handle.rewind()
  }

}

public final class AppendOnlyFile: Writable {

  internal let handle: FileHandle

  internal init(_ handle: FileHandle) {
    self.handle = handle
  }

  public func write(string: String) {
    handle.write(string)
  }

}

public final class ReadWriteFile: Readable, Writable, Seekable {

  internal let handle: FileHandle

  internal init(_ handle: FileHandle) {
    self.handle = handle
  }

  public func read(inout buffer: [CChar]) -> Int {
    return handle.read(&buffer)
  }

  public func write(string: String) {
    handle.write(string)
  }

  public func rewind() {
    handle.rewind()
  }

}
