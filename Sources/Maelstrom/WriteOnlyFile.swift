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
