import Maelstrom
import func libc.exit

if let input = stdin.read() {
  stderr.write("doing some reading!\n")
  stdout.write(input)
}
