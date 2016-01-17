import func libc.strerror
import var libc.errno

public enum SystemError: ErrorType, CustomStringConvertible {

  case RenameError(Int32, String, String)

  public var description: String {
    switch self {
    case let .RenameError(errno, from, to):
      return "renaming \"\(from)\" => \"\(to)\": \(strerror(errno)) (\(errno))"
    }
  }

  private func strerror(errno: Int32) -> String {
    let message = String.fromCString(libc.strerror(errno)) ?? "unknown error"
    return message.lowercaseString
  }

}
