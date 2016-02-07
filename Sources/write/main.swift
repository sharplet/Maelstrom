import Maelstrom
import util

do {
  let file = File("test")
  try file.write("foo bar\n")
  try file.append("hello world\n")
  let contents = try file.read()
  print("expected:", "foo bar", "hello world\n", separator: "\n", terminator: "")
  print("got:", contents, separator: "\n", terminator: "")
} catch {
  stderr.print("error: \(error)")
}
