# Module: golang\_org.x.example.stringutil


[(view library index)](../../../../golibs.md)


# Overview


Package stringutil contains utility functions for working with strings. 


<details><summary>cpp tests passed</summary>
<p>

```
=== RUN   TestReverse
--- PASS: TestReverse (0.000726938247680664)
```
</p>
</details>

<details><summary>hl tests passed</summary>
<p>

```
=== RUN   TestReverse
--- PASS: TestReverse (0.00185179710388184)
```
</p>
</details>

<details><summary>interp tests passed</summary>
<p>

```
=== RUN   TestReverse
--- PASS: TestReverse (0.000522136688232421875)
```
</p>
</details>

<details><summary>jvm tests failed</summary>
<p>

```
Error: Command failed with error 1
[0.068s][warning][exceptions] Class java.lang.Object in throws clause of method java.lang.String haxe.io.Bytes.toString() is not a subtype of class java.lang.Throwable
[0.068s][warning][exceptions] Class java.lang.Object in throws clause of method haxe.io.Bytes haxe.io.Bytes.ofString(java.lang.String, haxe.io.Encoding) is not a subtype of class java.lang.Throwable
[0.068s][warning][exceptions] Class java.lang.Object in throws clause of method void haxe.io.Bytes.blit(int, haxe.io.Bytes, int, int) is not a subtype of class java.lang.Throwable
=== RUN   TestReverse
Exception: null
Called from stdgo.GoString$GoString_Impl_.__toSliceRune__ (/usr/local/lib/haxe/lib/go2hx/git/stdgo/GoString.hx line 112)
Called from golang_org.x.example.stringutil._Stringutil.Stringutil_Fields_.reverse (golibs/golang_org/x/example/stringutil/Stringutil.hx line 27)
Called from golang_org.x.example.stringutil._Stringutil.Stringutil_Fields_.testReverse (golibs/golang_org/x/example/stringutil/Stringutil.hx line 51)
Called from golang_org.x.example.stringutil_test._Stringutil.Stringutil_Fields_$Stringutil_Fields__testReverse.invoke (golibs/golang_org/x/example/stringutil_test/Stringutil.hx line -1)
Called from golang_org.x.example.stringutil_test._Stringutil.Stringutil_Fields_$Stringutil_Fields__testReverse.invoke (golibs/golang_org/x/example/stringutil_test/Stringutil.hx line -1)
Called from stdgo.testing.M.run (/usr/local/lib/haxe/lib/go2hx/git/stdgo/testing/Testing.hx line 353)
Called from golang_org.x.example.stringutil_test._Stringutil.Stringutil_Fields_.main (golibs/golang_org/x/example/stringutil_test/Stringutil.hx line 30)
Called from golang_org.x.example.stringutil_test._Stringutil.Stringutil_Fields_.main (golibs/golang_org/x/example/stringutil_test/Stringutil.hx line 1)
```
</p>
</details>


# Index


- [function reverse\(\_s:stdgo.GoString\):stdgo.GoString](<#function-reverse>)

- [function testReverse\(\_t:stdgo.Ref\<stdgo.testing.T\>\):Void](<#function-testreverse>)

# Functions


```haxe
import golang_org.x.example.stringutil.Stringutil
```


## function reverse


```haxe
function reverse(_s:stdgo.GoString):stdgo.GoString
```


Reverse returns its argument string reversed rune\-wise left to right. 


[\(view code\)](<./Stringutil.hx#L26>)


## function testReverse


```haxe
function testReverse(_t:stdgo.Ref<stdgo.testing.T>):Void
```


 


[\(view code\)](<./Stringutil.hx#L47>)


