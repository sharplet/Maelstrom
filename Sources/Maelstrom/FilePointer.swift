import struct libc.FILE
import func libc.ferror
import func libc.fopen
import func libc.fread
import var libc.errno

internal final class FilePointer {

  let pointer: UnsafeMutablePointer<FILE>
  let path: String

  static func open(path: String, _ mode: String) throws -> FilePointer {
    let pointer = libc.fopen(path, mode)

    guard pointer != nil else {
        throw SystemError.OpenError(libc.errno, path)
    }

    return FilePointer(pointer, path)
  }

  private init(_ pointer: UnsafeMutablePointer<FILE>, _ path: String) {
    self.pointer = pointer
    self.path = path
  }

  func read(inout buffer: [CChar]) throws -> Int {
    let bytesRead = libc.fread(&buffer, sizeof(CChar.self), buffer.count, pointer)

    if bytesRead == 0 && libc.ferror(pointer) > 0 {
      throw SystemError.ReadError(libc.errno, path)
    }

    return bytesRead
  }

}
