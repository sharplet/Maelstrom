public protocol Readable {
  func read(inout buffer: [CChar]) -> Int
}

extension Readable {

  public func read() -> String {
    var bytes = Array(FileChunkSequence(file: self).flatten())
    bytes.append(0)
    return String.fromCString(bytes) ?? ""
  }

}
