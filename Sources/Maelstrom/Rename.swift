import func libc.rename
import var libc.errno

internal func rename(from old: String, to new: String) throws {
  let result = libc.rename(old, new)

  if result != 0 {
    throw SystemError.RenameError(libc.errno, old, new)
  }
}
