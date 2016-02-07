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
