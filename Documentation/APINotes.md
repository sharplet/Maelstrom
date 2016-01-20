Opening files and error handling:

```
let contents = try File("foo").read()

// after executing the closure, open would validate() the file handle
let contents = try File("foo").open { file in
  file.read()
}

let data = try File("foo").open { file in
  file.readData()
}

let startingWithFoo = try File("foo").open { file in
  return file
    .lines()
    .grep("^foo")
}
```

Type safe file operations:

```
r: read, seek
r+: read, write, seek
w: overwritten, write, seek
w+: overwritten, read, write, seek
a: append
a+: read, append, seek

roles:
 - Readable
 - Seekable
 - Writeable

raw option set: {
  read       00001
  seek       00010
  write      00100
  overwrite  01000
  append     10000

  ForReading                         = read|seek                           = 00011 = <Readable, Seekable>
  ForWritingWithTruncation           = truncate|write|seek                 = 01110 = <Writeable, Seekable>
  ForAppending                       = append                              = 10000 = <Writeable>
  ForReadingAndWriting               = ForReading|write                    = 00111 = <Readable, Writeable, Seekable>
  ForReadingAndWritingWithTruncation = ForReading|ForWritingWithTruncation = 01111 = <Readable, Writeable, Seekable>
  ForReadingAndAppending             = ForReading|ForAppending             = 10011 = <Readable, Writeable, Seekable>
}

open()                                                            -> protocol<Readable, Seekable>            // ReadableFile  ("r")
openTruncatedForWriting()                                         -> protocol<Writeable, Seeakable>          // WriteableFile ("w")
openForAppending()                                                -> protocol<Writeable>                     // WriteOnlyFile ("a")
openForReadingAndWriting(options: {None, Truncate, AppendWrites}) -> protocol<Readable, Writeable, Seekable> // ReadWriteFile ("r+", "w+", "a+")
```
