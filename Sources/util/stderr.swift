import libc

public class StandardErrorStream: OutputStreamType {
  public func write(string: String) {
    fwrite(string, sizeof(UInt8.self), string.utf8.count, libc.stderr)
  }
}

public var stderr = StandardErrorStream()
