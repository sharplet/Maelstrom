import struct libc.FILE
import func libc.ferror
import func libc.fopen
import func libc.fread
import var libc.errno

internal final class FileHandle {

  private let pointer: UnsafeMutablePointer<FILE>
  let path: String

  static func open(path: String, _ mode: String) throws -> FileHandle {
    let pointer = libc.fopen(path, mode)

    guard pointer != nil else {
        throw SystemError.OpenError(libc.errno, path)
    }

    return FileHandle(pointer, path)
  }

  private init(_ pointer: UnsafeMutablePointer<FILE>, _ path: String) {
    self.pointer = pointer
    self.path = path
  }

  func read(inout buffer: [CChar]) throws -> Int {
    let bytesRead = libc.fread(&buffer, sizeof(CChar.self), buffer.count, pointer)

    if bytesRead == 0, let error = error {
      throw error
    }

    return bytesRead
  }

  var error: ErrorType? {
    if libc.ferror(pointer) > 0 {
      return SystemError.ReadError(libc.errno, path)
    } else {
      return nil
    }
  }

}
