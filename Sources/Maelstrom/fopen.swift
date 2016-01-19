import struct libc.FILE
import func libc.fopen
import var libc.errno

internal typealias FilePointer = UnsafeMutablePointer<FILE>

internal func fopen(path: String, _ mode: String) throws -> FilePointer {
  let handle = libc.fopen(path, mode)

  guard handle != nil else {
      throw SystemError.OpenError(libc.errno, path)
  }

  return handle
}
