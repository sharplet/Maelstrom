import func libc.ferror
import func libc.fread
import var libc.errno

internal class FileHandle: GeneratorType {

  // MARK: Initialisation

  private let handle: FilePointer
  private let path: String

  private var buffer: [CChar]
  private var error: SystemError?

  init(_ path: String, bufferSize: Int = 1024) throws {
    precondition(bufferSize > 0)

    self.handle = try fopen(path, "r")
    self.path = path
    self.buffer = Array(count: bufferSize, repeatedValue: 0)
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
