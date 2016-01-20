import func libc.strerror
import var libc.errno

public enum SystemError: ErrorType, CustomStringConvertible {

  case CloseError(Int32, String)
  case OpenError(Int32, String)
  case ReadError(Int32, String)
  case RenameError(Int32, String, String)

  public var description: String {
    switch self {
    case let .CloseError(errno, path):
      return "closing \"\(path)\": \(summary(errno))"
    case let .OpenError(errno, path):
      return "opening \"\(path)\": \(summary(errno))"
    case let .ReadError(errno, path):
      return "reading \"\(path)\": \(summary(errno))"
    case let .RenameError(errno, from, to):
      return "renaming \"\(from)\" => \"\(to)\": \(summary(errno))"
    }
  }

  private func summary(errno: Int32) -> String {
    return "\(strerror(errno)) (\(errno))"
  }

  private func strerror(errno: Int32) -> String {
    let message = String.fromCString(libc.strerror(errno)) ?? "unknown error"
    return message.lowercaseString
  }

}
