cd ../.. # go to the go2hxdoc top level
go install go2hxdoc.go # refresh the go2hxdoc installation
cd example-project
cd example-haxelib
./buildhaxelib.sh # refresh the haxelib build
cd ../example-test # back here again
haxelib remove go2hxdoc_example
haxelib dev go2hxdoc_example ../example-haxelib
haxe -m Test -lib go2hx -lib go2hxdoc_example --interp