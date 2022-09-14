go2hxdoc
========

go2hxdoc provides documentation of the generated code, and testing of that generated code, for Go libraries that have been transpiled into Haxe by [go2hx](https://github.com/go2hx/go2hx).

go2hxdoc writes README.md files into each directory contianing generated Haxe code. 

go2hxdoc also writes a summary markdown file into the top level code-generated directory. This links to the individual README.md files. You can see an example [here](./example-project/golibs/golibs.md).

The project targets GitHub flavoured markdown. 

To enable tests on specific targets, use one or more of the `-cpp -hl -interp -jvm` command line flags.

go2hxdoc is a Go program, which must be built or installed before use.

This project has only been tested on OSX.

TO DO
-----

- Fix Typedef Haxe display to be correct