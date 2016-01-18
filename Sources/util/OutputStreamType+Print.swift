extension OutputStreamType {
  public mutating func print(items: Any..., separator: String = " ", terminator: String = "\n") {
    let string = items.map { String($0) }.joinWithSeparator(separator)
    Swift.print(string, terminator: terminator, toStream: &self)
  }
}
