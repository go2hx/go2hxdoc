// Example of how to generate and document Haxe modules from Go packages with go2hx and go2hxdoc.
// Before go2hx can work, the program below needs to compile in Go, see https://go.dev/learn/
// Once go2hx has run, the Go libriaries can be accessed from Haxe by adding the golibs directory to your Haxe code path (-cp).
// Once g2hxdoc has run, the documentation for the libraries will be available as README.md in each directory.
// if there are Go tests, and at least one testing flag (-cpp,-hl,-interp,-jvm) is set, the results will appear in the README.md files.
package main

import (
	_ "github.com/arriqaaq/zset"
	_ "github.com/kr/text"
)

func main() {}
