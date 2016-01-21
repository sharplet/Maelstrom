public protocol Readable {
  func read(inout buffer: [CChar]) -> Int
}

public protocol Seekable {
  // TODO: Custom index for seeking?
}

typealias Writable = OutputStreamType
