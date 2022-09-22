Example of how to generate, document and call Haxe modules from Go packages with go2hx and go2hxdoc.

The Haxe code to call the generated libraries in Test.hx.

Before go2hx can work, the Go program containing references to the required Go packages (main.go) needs to compile in Go, see https://go.dev/learn/.

Once go2hx has run, the Go libriaries can be accessed from Haxe by adding the golibs directory to your Haxe code path (-cp).

Once g2hxdoc has run, the documentation for the libraries will be available as README.md in each directory.

if there are Go tests, and at least one testing flag (-cpp,-hl,-interp,-jvm) is set, the test results will appear in the README.md files.

For an example of the CLI commands to do the above, see test.sh.
