#
# Add documentation and testing to the existiing haxelib go2hx instance code directories
# Warning, this code takes 10 minutes to complete on a very fast machine 
#
go install go2hxdoc.go # rebuild the executable for testing
# location of the stdgo code to document must be the same physcal location as the location of go2hx haxelib
# -timeout defaut value is overriden (m=mins), -force the production of .md files even if they are older than the .hx files 
go2hxdoc -dir `haxelib libpath go2hx`stdgo -interp -jvm -hl -cpp -stats -timeout 1m -force # all testing possible in parallel (-seq for sequential)
