# Module: `golang_org.x.example.stringutil`

[(view library index)](../../../../golibs.md)


# Overview


Package stringutil contains utility functions for working with strings. 


<details><summary>cpp tests failed</summary>
<p>

```
[31;1mError:[0m [1mIn file included from ./src/stdgo/sync/atomic/Uint64.cpp:33:
include/stdgo/sync/atomic/Uint64.h:15:37: error: expected identifier or '{'
HX_DECLARE_CLASS4(stdgo,sync,atomic,_Atomic,T_align64)
                                    ^
include/stdgo/sync/atomic/Uint64.h:15:1: error: expected unqualified-id
HX_DECLARE_CLASS4(stdgo,sync,atomic,_Atomic,T_align64)
^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:21:66: note: expanded from macro 'HX_DECLARE_CLASS4'
#define HX_DECLARE_CLASS4(ns4,ns3,ns2,ns1,klass) namespace ns4 { HX_DECLARE_CLASS3(ns3,ns2,ns1,klass) }
                                                                 ^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:20:62: note: expanded from macro 'HX_DECLARE_CLASS3'
#define HX_DECLARE_CLASS3(ns3,ns2,ns1,klass) namespace ns3 { HX_DECLARE_CLASS2(ns2,ns1,klass) }
                                                             ^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:19:58: note: expanded from macro 'HX_DECLARE_CLASS2'
#define HX_DECLARE_CLASS2(ns2,ns1,klass) namespace ns2 { HX_DECLARE_CLASS1(ns1,klass) }
                                                         ^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:18:52: note: expanded from macro 'HX_DECLARE_CLASS1'
#define HX_DECLARE_CLASS1(ns1,klass) namespace ns1 { HX_DECLARE_CLASS0(klass) }
                                                   ^
In file included from ./src/stdgo/sync/atomic/Uint64.cpp:33:
include/stdgo/sync/atomic/Uint64.h:16:37: error: expected identifier or '{'
HX_DECLARE_CLASS4(stdgo,sync,atomic,_Atomic,T_noCopy)
                                    ^
include/stdgo/sync/atomic/Uint64.h:16:1: error: expected unqualified-id
HX_DECLARE_CLASS4(stdgo,sync,atomic,_Atomic,T_noCopy)
^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:21:66: note: expanded from macro 'HX_DECLARE_CLASS4'
#define HX_DECLARE_CLASS4(ns4,ns3,ns2,ns1,klass) namespace ns4 { HX_DECLARE_CLASS3(ns3,ns2,ns1,klass) }
                                                                 ^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:20:62: note: expanded from macro 'HX_DECLARE_CLASS3'
#define HX_DECLARE_CLASS3(ns3,ns2,ns1,klass) namespace ns3 { HX_DECLARE_CLASS2(ns2,ns1,klass) }
                                                             ^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:19:58: note: expanded from macro 'HX_DECLARE_CLASS2'
#define HX_DECLARE_CLASS2(ns2,ns1,klass) namespace ns2 { HX_DECLARE_CLASS1(ns1,klass) }
                                                         ^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:18:52: note: expanded from macro 'HX_DECLARE_CLASS1'
#define HX_DECLARE_CLASS1(ns1,klass) namespace ns1 { HX_DECLARE_CLASS0(klass) }
                                                   ^
In file included from ./src/stdgo/sync/atomic/Uint64.cpp:33:
include/stdgo/sync/atomic/Uint64.h:33:43: error: expected unqualified-id
                void __construct(::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                        ^
include/stdgo/sync/atomic/Uint64.h:33:20: error: expected parameter declarator
                void __construct(::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                 ^
include/stdgo/sync/atomic/Uint64.h:33:43: error: expected ')'
                void __construct(::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                        ^
include/stdgo/sync/atomic/Uint64.h:33:19: note: to match this '('
                void __construct(::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                ^
include/stdgo/sync/atomic/Uint64.h:38:69: error: expected unqualified-id
                static ::hx::ObjectPtr< Uint64_obj > __new(::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                                                  ^
include/stdgo/sync/atomic/Uint64.h:38:46: error: expected parameter declarator
                static ::hx::ObjectPtr< Uint64_obj > __new(::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                           ^
include/stdgo/sync/atomic/Uint64.h:38:69: error: expected ')'
                static ::hx::ObjectPtr< Uint64_obj > __new(::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                                                  ^
include/stdgo/sync/atomic/Uint64.h:38:45: note: to match this '('
                static ::hx::ObjectPtr< Uint64_obj > __new(::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                          ^
include/stdgo/sync/atomic/Uint64.h:39:90: error: expected unqualified-id
                static ::hx::ObjectPtr< Uint64_obj > __alloc(::hx::Ctx *_hx_ctx,::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                                                                       ^
include/stdgo/sync/atomic/Uint64.h:39:67: error: expected parameter declarator
                static ::hx::ObjectPtr< Uint64_obj > __alloc(::hx::Ctx *_hx_ctx,::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                                                ^
include/stdgo/sync/atomic/Uint64.h:39:90: error: expected ')'
                static ::hx::ObjectPtr< Uint64_obj > __alloc(::hx::Ctx *_hx_ctx,::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                                                                       ^
include/stdgo/sync/atomic/Uint64.h:39:47: note: to match this '('
                static ::hx::ObjectPtr< Uint64_obj > __alloc(::hx::Ctx *_hx_ctx,::stdgo::sync::atomic::_Atomic::T_noCopy _13,::stdgo::sync::atomic::_Atomic::T_align64 _14, ::Dynamic _v);
                                                            ^
include/stdgo/sync/atomic/Uint64.h:55:26: error: expected unqualified-id
                ::stdgo::sync::atomic::_Atomic::T_noCopy _13;
                                       ^
include/stdgo/sync/atomic/Uint64.h:56:26: error: expected unqualified-id
                ::stdgo::sync::atomic::_Atomic::T_align64 _14;
                                       ^
In file included from ./src/stdgo/sync/atomic/Uint64.cpp:36:
include/stdgo/sync/atomic/_Atomic/T_align64.h:10:37: error: expected identifier or '{'
HX_DECLARE_CLASS4(stdgo,sync,atomic,_Atomic,T_align64)
                                    ^
include/stdgo/sync/atomic/_Atomic/T_align64.h:10:1: error: expected unqualified-id
HX_DECLARE_CLASS4(stdgo,sync,atomic,_Atomic,T_align64)
^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:21:66: note: expanded from macro 'HX_DECLARE_CLASS4'
#define HX_DECLARE_CLASS4(ns4,ns3,ns2,ns1,klass) namespace ns4 { HX_DECLARE_CLASS3(ns3,ns2,ns1,klass) }
                                                                 ^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:20:62: note: expanded from macro 'HX_DECLARE_CLASS3'
#define HX_DECLARE_CLASS3(ns3,ns2,ns1,klass) namespace ns3 { HX_DECLARE_CLASS2(ns2,ns1,klass) }
                                                             ^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:19:58: note: expanded from macro 'HX_DECLARE_CLASS2'
#define HX_DECLARE_CLASS2(ns2,ns1,klass) namespace ns2 { HX_DECLARE_CLASS1(ns1,klass) }
                                                         ^
/usr/local/lib/haxe/lib/hxcpp/4,2,1/include/hx/Macros.h:18:52: note: expanded from macro 'HX_DECLARE_CLASS1'
#define HX_DECLARE_CLASS1(ns1,klass) namespace ns1 { HX_DECLARE_CLASS0(klass) }
                                                   ^
In file included from ./src/stdgo/sync/atomic/Uint64.cpp:36:
include/stdgo/sync/atomic/_Atomic/T_align64.h:15:11: error: expected identifier or '{'
namespace _Atomic{
          ^
include/stdgo/sync/atomic/_Atomic/T_align64.h:15:18: error: expected unqualified-id
namespace _Atomic{
                 ^
fatal error: too many errors emitted, stopping now [-ferror-limit=]
20 errors generated.[0m[0m
/usr/local/lib/haxe/lib/go2hx/git/stdgo/reflect/Reflect.hx:2977: characters 28-35 : Warning : Potential typo detected (expected similar values are refType). Consider using `var keyType` instead
Error: Build failed
/usr/local/lib/haxe/lib/go2hx/git/stdgo/internal/Macro.macro.hx:35: define
haxelib run hxcpp Build.xml haxe -Dgo2hx="1" -Dhaxe="4.3.0-rc.1" -Dhaxe3="1" -Dhaxe4="1" -Dhaxe_ver="4.300" -Dhl_ver="1.11.0" -Dhxcpp_api_level="430" -Dhxcpp_smart_strings="1" -Djs_es="6" -Dkeep_inline_positions="1" -Dno_deprecation_warnings="1" -Dshallow_expose="1" -Dsimulate_num="1" -Dsource_header="Generated by Haxe 4.3.0-rc.1+779b005" -Dsource_map="1" -Dstatic="1" -Dstd_encoding_utf8="1" -Dtarget.name="cpp" -Dtarget.static="1" -Dtarget.sys="1" -Dtarget.threaded="1" -Dtarget.unicode="1" -Dtarget.utf16="1" -Dutf16="1" -I/usr/local/lib/haxe/lib/go2hx/git/ -I/Users/elliottstoneham/code/go2hx/go2hxdoc/example-project/golibs/ -I -I/usr/local/lib/haxe/extraLibs/ -I/usr/local/share/haxe/extraLibs/ -I/usr/local/bin/extraLibs/ -I/usr/local/lib/haxe/std/cpp/_std/ -I/usr/local/share/haxe/std/cpp/_std/ -I/usr/local/bin/std/cpp/_std/ -I/usr/local/lib/haxe/std/ -I/usr/local/share/haxe/std/ -I/usr/local/bin/std/
Creating /Users/elliottstoneham/code/go2hx/go2hxdoc/example-project/bin/hxcpp_common/obj/darwin64/__pch/haxe/hxcpp.h.gch...

[33;1mCompiling group: haxe[0m
[1mg++[0m [0m-Iinclude[0m [0m-c[0m [0m-fvisibility=hidden[0m [0m-stdlib=libc++[0m [0m-Qunused-arguments[0m [0m-O2[0m [0m-I/usr/local/lib/haxe/lib/hxcpp/4,2,1/include[0m [1m-DHX_MACOS[0m [0m-m64[0m [0m-Wno-parentheses[0m [0m-Wno-unused-value[0m [0m-Wno-format-extra-args[0m [0m-Wno-overflow[0m [1m-DHXCPP_M64[0m [1m-DHXCPP_VISIT_ALLOCS[0m[2m(haxe)[0m [1m-DHX_SMART_STRINGS[0m[2m(haxe)[0m [1m-DHXCPP_API_LEVEL=430[0m[2m(haxe)[0m [2m...[0m [2mtags=[haxe,static][0m
 [2m-[0m [33msrc/stdgo/io/[33;1mT_multiReader_asInterface.cpp[0m [3m[0m
 [2m-[0m [33msrc/[33;1m__boot__.cpp[0m [3m[0m
 [2m-[0m [33msrc/stdgo/regexp/syntax/[33;1mT_compiler_static_extension.cpp[0m [3m[0m
 [2m-[0m [33msrc/stdgo/sync/atomic/[33;1mInt64__asInterface.cpp[0m [3m[0m
 [2m-[0m [33msrc/stdgo/sync/atomic/[33;1mUint32_asInterface.cpp[0m [3m[0m
 [2m-[0m [33msrc/stdgo/regexp/[33;1mT__struct_3_static_extension.cpp[0m [3m[0m
 [2m-[0m [33msrc/stdgo/sync/atomic/_Atomic/[33;1mAtomic_Fields_.cpp[0m [3m[0m
 [2m-[0m [33msrc/stdgo/sync/[33;1mPool_static_extension.cpp[0m [3m[0m
 [2m-[0m [33msrc/stdgo/_Chan/[33;1mChanIterator.cpp[0m [3m[0m
 [2m-[0m [33msrc/stdgo/sync/atomic/[33;1mUint64.cpp[0m [3m[0m
```
</p>
</details>

<details><summary>interp tests passed</summary>
<p>

```
=== RUN  TestReverse
--- PASS: TestReverse (%!s(float64=0.0006349086761474609))

```
</p>
</details>

<details><summary>js tests failed</summary>
<p>

```
/usr/local/lib/haxe/lib/go2hx/git/stdgo/reflect/Reflect.hx:2977: characters 28-35 : Warning : Potential typo detected (expected similar values are refType). Consider using `var keyType` instead
/usr/local/lib/haxe/lib/go2hx/git/stdgo/os/Os.hx:151: characters 43-49 : Accessing this field requires a system platform (php,neko,cpp,etc.)
/usr/local/lib/haxe/lib/go2hx/git/stdgo/os/Os.hx:151: characters 43-49 : ... For optional function argument '_input'
```
</p>
</details>


# Index


- [`function reverse(_s:stdgo.GoString):stdgo.GoString`](<#function-reverse>)

- [`function testReverse(_t:stdgo.Ref<stdgo.testing.T>):Void`](<#function-testreverse>)

# Functions


```haxe
import golang_org.x.example.stringutil.Stringutil
```


## function reverse


```haxe
function reverse(_s:stdgo.GoString):stdgo.GoString
```


Reverse returns its argument string reversed rune\-wise left to right. 


[\(view code\)](<./Stringutil.hx#L43>)


## function testReverse


```haxe
function testReverse(_t:stdgo.Ref<stdgo.testing.T>):Void
```


 


[\(view code\)](<./Stringutil.hx#L67>)


