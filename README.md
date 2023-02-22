go2hxdoc
========

go2hxdoc provides documentation of the generated code, and testing of that generated code, for Go libraries that have been transpiled into Haxe by [go2hx](https://github.com/go2hx/go2hx).

go2hxdoc writes README.md files into each directory contianing generated Haxe code. 

go2hxdoc also writes a summary markdown file into the top level code-generated directory. This links to the individual README.md files. You can see an example [here](./example-project/golibs/golibs.md).

The project targets GitHub flavoured markdown. 

To enable tests on specific targets, use one or more of the `-cpp -hl -interp -js -jvm` command line flags.

go2hxdoc is a Go program, which must be built or installed before use.

```
$ go install go2hxdoc.go   # from the same directory as the file go2hxdoc.go
```

This project has only been tested on OSX and Ubuntu.


Further possible improvements:
------------------------------

Robustness:
- Check format of generated json test result file for use in regression testing
- Add test targets: "cs", "lua", "python", "php", "neko"
- Investigate orphan processes after timeout to see if tidy-up is required
- Consider ways to avoid re-building documentation or re-running tests when this work has already been done

Example project:
- Integrate with [go2hx/libraries](https://github.com/go2hx/libraries)
- Create a better working Haxe programe using transpiled libraries
- Demonstrate better use of Go package tests
- Generate, or document how to generate, Haxe test code, at least for top-level `_ "packages"`
- Add [go.work file](https://github.com/golang/tools/blob/master/gopls/doc/workspace.md) if required
