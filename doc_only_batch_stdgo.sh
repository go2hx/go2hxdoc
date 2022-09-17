#
# Add documentation (but no testing) to the existiing haxelib go2hx instance code directories
# Run haxe sequentially, suitable for batch processing (e.g. Github actions)
# Takes 4 minutes on a very fast machine
#
go build go2hxdoc.go # rebuild the executable for testing
# location of the stdgo code to document must be the same physcal location as the location of go2hx haxelib
./go2hxdoc -dir `haxelib libpath go2hx`stdgo -stats -force -seq 
