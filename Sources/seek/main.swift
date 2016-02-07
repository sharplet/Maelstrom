import Maelstrom
import util

do {
  let file = File("test")
  try file.openTruncatedForWriting { file in
    file.write("foo bar\n")
    file.rewind()
    file.write("hello world\n")
  }
  let contents = try file.read()
  print("expected:", "hello world\n", separator: "\n", terminator: "")
  print("got:", contents, separator: "\n", terminator: "")
} catch {
  stderr.print("error: \(error)")
}
