public final class AppendOnlyFile: Writable {

  internal let handle: FileHandle

  internal init(_ handle: FileHandle) {
    self.handle = handle
  }

  public func write(string: String) {
    handle.write(string)
  }

}
