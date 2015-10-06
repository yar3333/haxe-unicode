# unicode #

Unicode-related library for **neko** target:

 * convert strings between OEM and UTF-8 encodings;
 * working with national-named files;
 * UTF-8 support for regular expressions

## unicode.UnicodeStringTools

Static methods to convert from OEM to UTF-8 and vise versa.

```
function oemToUtf8(s)
function utf8ToOem(s)
```

## unicode.FileSystem
Working with a national-named files (file paths in UTF-8).
On Windows loads NDLL with system calls, on *nix just call `sys.FileSystem` methods.
```
function createDirectory(path)
function exists(path)
function readDirectory(path)
function isDirectory(path)
function rename(src, dest)
function fullPath(path)
function stat(path)
function deleteFile(path)
function deleteDirectory(path)
```

## unicode.File
Working with a national-named files (file paths in UTF-8).
On Windows loads NDLL with system calls, on *nix just call `sys.io.File` methods.
```
function getContent(filePath)
function saveContent(filePath, text)
function copy(srcFilePath, destFilePath)
```

## unicode.EReg

UTF-8 regular expressions compatible to standard `EReg` class.
Load NDLL and use system calls to PCRE library.