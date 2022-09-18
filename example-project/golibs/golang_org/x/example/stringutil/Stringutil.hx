package golang_org.x.example.stringutil;

import stdgo.StdGoTypes;
import stdgo.Error;
import stdgo.Go;
import stdgo.GoString;
import stdgo.Pointer;
import stdgo.Slice;
import stdgo.GoArray;
import stdgo.GoMap;
import stdgo.Chan;

/**
	// Package stringutil contains utility functions for working with strings.
**/
private var __go2hxdoc__package:Bool;

@:local private typedef T__struct_0 = {
	public var _in:GoString;
	public var _want:GoString;
};

/**
	// Reverse returns its argument string reversed rune-wise left to right.
**/
function reverse(_s:GoString):GoString {
	var _r = (_s : Slice<GoRune>);
	{
		var _i:GoInt = (0 : GoInt), _j:GoInt = (_r.length) - (1 : GoInt);
		Go.cfor(_i < (_r.length / (2 : GoInt)), {
			final __tmp__0 = _i + (1 : GoInt);
			final __tmp__1 = _j - (1 : GoInt);
			_i = __tmp__0;
			_j = __tmp__1;
		}, {
			{
				final __tmp__0 = _r[_j];
				final __tmp__1 = _r[_i];
				_r[_i] = __tmp__0;
				_r[_j] = __tmp__1;
			};
		});
	};
	return (_r : GoString);
}

function testReverse(_t:Ref<stdgo.testing.Testing.T>):Void {
	for (_0 => _c in(new Slice<T__struct_0>(0, 0, ({_in: (Go.str("Hello, world") : GoString), _want: (Go.str("dlrow ,olleH") : GoString)} : T__struct_0),
		({_in: (Go.str("Hello, 世界") : GoString), _want: (Go.str("界世 ,olleH") : GoString)} : T__struct_0),
		({_in: (Go.str() : GoString), _want: (Go.str() : GoString)} : T__struct_0)) : Slice<T__struct_0>)) {
		var _got:GoString = reverse(_c._in);
		if (_got != _c._want) {
			_t.errorf((Go.str("Reverse(%q) == %q, want %q") : GoString), Go.toInterface(_c._in), Go.toInterface(_got), Go.toInterface(_c._want));
		};
	};
}
