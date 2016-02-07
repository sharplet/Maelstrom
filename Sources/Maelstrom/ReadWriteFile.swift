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
