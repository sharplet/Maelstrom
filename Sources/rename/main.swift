import Maelstrom
import util

do {
  var file = File("myfile")
  try file.rename("notmyfile")
  print(file.path)
} catch {
  stderr.print("error: \(error)")
}
