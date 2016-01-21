internal struct FileChunkSequence: LazySequenceType {

  let file: Readable

  // MARK: SequenceType

  typealias Generator = FileChunkGenerator

  func generate() -> FileChunkGenerator {
    return FileChunkGenerator(file)
  }

}

internal final class FileChunkGenerator: GeneratorType {

  // MARK: Initialisation

  private var buffer: [CChar]
  private let file: Readable

  init(_ file: Readable, chunkSize: Int = 1024) {
    precondition(chunkSize > 0)

    self.buffer = Array(count: chunkSize, repeatedValue: 0)
    self.file = file
  }

  // MARK: GeneratorType

  typealias Element = ArraySlice<CChar>

  func next() -> ArraySlice<CChar>? {
    let bytesRead = file.read(&buffer)
    return bytesRead > 0 ? buffer[0..<bytesRead] : nil
  }

}
