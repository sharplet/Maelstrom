import Maelstrom
import util

let file = File("test")

do {
  let readWriteResult = try file
    .openForReadingAndWriting { file -> String in
      file.write("foo bar\n")
      file.rewind()
      file.write("hello world\n")
      file.rewind()
      return file.read() ?? ""
    }

  print("READ / WRITE")
  print("expected:", "hello world\n", separator: "\n", terminator: "")
  print("got:", readWriteResult, separator: "\n", terminator: "")

  print("")

  let truncateResult = try file
    .openForReadingAndWriting(options: .Truncate) { file -> String in
      return file.read() ?? ""
    }

  print("TRUNCATE")
  print("empty? \(truncateResult.isEmpty)")

  print("")

  let appendResult: [String] = try file
    .openForReadingAndWriting(options: .AppendWrites) { file in
      var states: [String] = []
      states.append(file.read() ?? "")

      file.write("foo")
      file.rewind()
      states.append(file.read() ?? "")

      file.write("bar")
      file.rewind()
      states.append(file.read() ?? "")

      return states
    }

  print("APPEND WRITES")
  print("expected: [\"\", \"foo\", \"foobar\"]")
  print("got: \(appendResult)")

} catch {
  stderr.print("error: \(error)")
}
