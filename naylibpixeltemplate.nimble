# Package

version       = "0.1.0"
author        = "Weldify"
description   = "naylib template for pixel perfect 2d games"
license       = "MIT"
srcDir        = "src"
bin           = @["naylibpixeltemplate"]


# Dependencies

requires "nim >= 1.9.3"
requires "naylib >= 4.5.1"

task debug, "Builds and runs debug":
    exec "nim c -r -d:debug --outdir:out src/main.nim"

task releasewin, "Builds release for windows (no console)":
    exec "nim c -d:danger --passL:-mwindows --outdir:out src/main.nim"