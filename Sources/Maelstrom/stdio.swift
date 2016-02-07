import var libc.stderr
import var libc.stdin
import var libc.stdout

public let stderr: AppendOnlyFile = {
  let handle = FileHandle(libc.stderr, "/dev/stderr")
  return AppendOnlyFile(handle)
}()

public let stdin: ReadOnlyFile = {
  let handle = FileHandle(libc.stdin, "/dev/stdin")
  return ReadOnlyFile(handle)
}()

public let stdout: AppendOnlyFile = {
  let handle = FileHandle(libc.stdout, "/dev/stdout")
  return AppendOnlyFile(handle)
}()
