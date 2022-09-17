cd ..
go build go2hxdoc.go # rebuild to get latest version of code when developing
cd example-project
go run main.go   # check that the Go code is correct
haxelib run go2hx main.go --test --norun # generate Haxe code to emulate the Go code
haxelib run go2hx golang.org/x/example/stringutil --test # add the test code fo this Go package
./../go2hxdoc -interp -hl -cpp -jvm # generate documentation, running any tests for all targets
haxe -m Test -lib go2hx -cp ./golibs --interp # use the library code from a normal Haxe program