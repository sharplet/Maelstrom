import func POSIX.rename

public struct File {

  public private(set) var path: String

  public init(_ path: String) {
    self.path = path
  }

  public mutating func rename(newPath: String) throws {
    try POSIX.rename(old: path, new: newPath)
    path = newPath
  }

}
