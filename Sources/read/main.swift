import Maelstrom
import util

do {
  let file = File("/usr/share/dict/words")
  let contents = try file.read()
  print("contents:", contents, separator: "\n", terminator: "")
} catch {
  stderr.print("error: \(error)")
}
