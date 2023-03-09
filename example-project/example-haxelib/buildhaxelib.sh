go run main.go   # check that the Go code is correct
haxelib run go2hx main.go --test --norun # generate Haxe code to emulate the Go code
haxelib run go2hx golang.org/x/example/stringutil --test --norun # add the test code for this Go package
go2hxdoc -interp -hl # generate documentation, running any tests using macro expansion and hashlink