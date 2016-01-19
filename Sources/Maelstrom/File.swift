import libc

public struct File {

  public private(set) var path: String

  public init(_ path: String) {
    self.path = path
  }

  public func read() throws -> String {
    let handle = try FileHandle(path)
    return try handle.read()
  }

  public mutating func rename(newPath: String) throws {
    try Maelstrom.rename(from: path, to: newPath)
    path = newPath
  }

}

internal class FileHandle: GeneratorType {

  // MARK: Initialisation

  private typealias Handle = UnsafeMutablePointer<FILE>

  private let handle: Handle
  private let path: String

  private var buffer: [CChar]
  private var error: SystemError?

  init(_ path: String, bufferSize: Int = 1024) throws {
    precondition(bufferSize > 0)

    self.handle = libc.fopen(path, "r")
    self.path = path
    self.buffer = Array(count: bufferSize, repeatedValue: 0)

    if handle == nil {
      throw SystemError.OpenError(libc.errno, path)
    }
  }

  // MARK: Reading

  func read() throws -> String {
    let bytes = GeneratorSequence(self).flatMap { $0 }

    if let error = error {
      throw error
    }

    return String.fromCString(bytes) ?? ""
  }

  // MARK: GeneratorType

  typealias Element = ArraySlice<CChar>

  func next() -> ArraySlice<CChar>? {
    let bytesRead = libc.fread(&buffer, sizeof(CChar.self), buffer.count, handle)

    guard bytesRead > 0 else {
      if libc.ferror(handle) > 0 {
        error = SystemError.ReadError(libc.errno, path)
      }
      return nil
    }

    return buffer[0..<bytesRead]
  }

}
