internal class FileChunkGenerator: GeneratorType {

  // MARK: Initialisation

  private let file: FileHandle

  private var buffer: [CChar]
  private var error: ErrorType?

  init(_ path: String, chunkSize: Int = 1024) throws {
    precondition(chunkSize > 0)

    self.file = try FileHandle.open(path, "r")
    self.buffer = Array(count: chunkSize, repeatedValue: 0)
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
    do {
      let bytesRead = try file.read(&buffer)
      return bytesRead > 0 ? buffer[0..<bytesRead] : nil
    } catch {
      self.error = error
      return nil
    }
  }

}
