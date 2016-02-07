import struct libc.FILE
import func libc.fclose
import func libc.ferror
import func libc.fopen
import func libc.fread
import func libc.fwrite
import func libc.rewind
import var libc.EOF
import var libc.errno

internal final class FileHandle: Readable, Writable, Seekable {

  private let pointer: UnsafeMutablePointer<FILE>
  let path: String

  static func open(path: String, _ mode: String) throws -> FileHandle {
    let pointer = libc.fopen(path, mode)

    guard pointer != nil else {
        throw SystemError.OpenError(libc.errno, path)
    }

    return FileHandle(pointer, path)
  }

  init(_ pointer: UnsafeMutablePointer<FILE>, _ path: String) {
    self.pointer = pointer
    self.path = path
  }

  func close() throws {
    if libc.fclose(pointer) == libc.EOF {
      throw SystemError.CloseError(libc.errno, path)
    }
  }

  func read(inout buffer: [CChar]) -> Int {
    return libc.fread(&buffer, sizeof(CChar.self), buffer.count, pointer)
  }

  func write(string: String) {
    string.withCString { cstring in
      libc.fwrite(cstring, sizeof(CChar.self), string.utf8.count, pointer)
    }
  }

  func rewind() {
    libc.rewind(pointer)
  }

  func validate() throws {
    if libc.ferror(pointer) > 0 {
      throw SystemError.ReadError(libc.errno, path)
    }
  }

}
