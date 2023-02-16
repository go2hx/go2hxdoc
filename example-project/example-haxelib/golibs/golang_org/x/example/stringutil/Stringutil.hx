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
private var __go2hxdoc__package : Bool;
class T__struct_0_asInterface {
    public function new(__self__, __type__) {
        this.__self__ = __self__;
        this.__type__ = __type__;
    }
    public function __underlying__() return new AnyInterface((__type__.kind() == stdgo.internal.reflect.Reflect.KindType.pointer && !stdgo.internal.reflect.Reflect.isReflectTypeRef(__type__)) ? (__self__ : Dynamic) : (__self__.value : Dynamic), __type__);
    var __self__ : Pointer<T__struct_0>;
    var __type__ : stdgo.internal.reflect.Reflect._Type;
}
@:keep @:allow(golang_org.x.example.stringutil.Stringutil.T__struct_0_asInterface) class T__struct_0_static_extension {

}
@:local @:using(golang_org.x.example.stringutil.Stringutil.T__struct_0_static_extension) private typedef T__struct_0 = {
    public var _in : GoString;
    public var _want : GoString;
};
/**
    // Reverse returns its argument string reversed rune-wise left to right.
**/
function reverse(_s:GoString):GoString {
        var _r = (_s : Slice<GoRune>);
        {
            var _0:GoInt = (0 : GoInt), _1:GoInt = (_r.length) - (1 : GoInt), _j:GoInt = _1, _i:GoInt = _0;
            Go.cfor(_i < (_r.length / (2 : GoInt)), {
                final __tmp__0 = _i + (1 : GoInt);
                final __tmp__1 = _j - (1 : GoInt);
                _i = __tmp__0;
                _j = __tmp__1;
            }, {
                {
                    final __tmp__0 = _r[(_j : GoInt)];
                    final __tmp__1 = _r[(_i : GoInt)];
                    _r[(_i : GoInt)] = __tmp__0;
                    _r[(_j : GoInt)] = __tmp__1;
                };
            });
        };
        return (_r : GoString);
    }
function testReverse(_t:Ref<stdgo.testing.Testing.T>):Void {
        for (_0 => _c in (new Slice<T__struct_0>(0, 0, ({ _in : ("Hello, world" : GoString), _want : ("dlrow ,olleH" : GoString) } : T__struct_0), ({ _in : ("Hello, 世界" : GoString), _want : ("界世 ,olleH" : GoString) } : T__struct_0), ({ _in : Go.str(), _want : Go.str() } : T__struct_0)) : Slice<T__struct_0>)) {
            var _got:GoString = reverse(_c._in);
            if (_got != (_c._want)) {
                _t.errorf(("Reverse(%q) == %q, want %q" : GoString), Go.toInterface(_c._in), Go.toInterface(_got), Go.toInterface(_c._want));
            };
        };
    }
