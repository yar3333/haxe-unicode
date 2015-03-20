# unicode #

Unicode-related library for **neko** target.

Allow read/write UTF8-named files and convert strings between OEM and UTF-8 encodings.

On Windows loads ndll with system calls, on *nix just call `sys.FilSystem`/`sys.io.File` methods.


## unicode.UnicodeStringTools

Static methods to convert UTF-8 <-> OEM encodings.

```
function oemToUtf8(s) : STring
function utf8ToOem(s) : STring
```

## unicode.FileSystem

```
function exists(path) : Bool
function readDirectory(dirPath) : Array<String>
function isDirectory(path) : Bool
function rename(src, dest)
```

## unicode.File

```
	function getContent(filePath) : String
	function saveContent(filePath, text)
```

## unicode.EReg

UTF-8 regular expressions compatible to standard `EReg` class.
