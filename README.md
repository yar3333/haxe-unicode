# unicode #

Unicode-related library for neko target. Allow read/write utf8-named files and convert strings between OEM and UTF-8 encodings.
On Windows loads ndll with these functions, on *nix just call sys.File's methods.
