import Maelstrom
import util

do {
  let result = try File("test").openForReadingAndWriting { file -> String in
    file.write("foo bar\n")
    file.rewind()
    file.write("hello world\n")
    file.rewind()
    return file.read() ?? ""
  }
  print("expected:", "hello world\n", separator: "\n", terminator: "")
  print("got:", result, separator: "\n", terminator: "")
} catch {
  stderr.print("error: \(error)")
}
