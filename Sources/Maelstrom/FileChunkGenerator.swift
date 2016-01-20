internal class FileChunkGenerator: GeneratorType {

  // MARK: Initialisation

  private var buffer: [CChar]
  private let file: FileHandle

  init(_ file: FileHandle, chunkSize: Int = 1024) {
    precondition(chunkSize > 0)

    self.buffer = Array(count: chunkSize, repeatedValue: 0)
    self.file = file
  }

  // MARK: Reading

  func read() throws -> String {
    let bytes = GeneratorSequence(self).flatMap { $0 }
    try file.validate()
    return String.fromCString(bytes) ?? ""
  }

  // MARK: GeneratorType

  typealias Element = ArraySlice<CChar>

  func next() -> ArraySlice<CChar>? {
    let bytesRead = file.read(&buffer)
    return bytesRead > 0 ? buffer[0..<bytesRead] : nil
  }

}
