public enum ReadWriteOptions {

  case None
  case Truncate
  case AppendWrites

  internal var mode: String {
    switch self {
    case .None:
      return "r+"
    case .Truncate:
      return "w+"
    case .AppendWrites:
      return "a+"
    }
  }

}
