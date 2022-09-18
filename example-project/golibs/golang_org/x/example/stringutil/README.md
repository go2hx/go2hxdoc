# Module: golang\_org.x.example.stringutil


[(view library index)](../../../../golibs.md)


# Overview


Package stringutil contains utility functions for working with strings. 


<details><summary>cpp tests passed</summary>
<p>

```
=== RUN   TestReverse
--- PASS: TestReverse (0.00019383430480957)
```
</p>
</details>

<details><summary>hl tests passed</summary>
<p>

```
=== RUN   TestReverse
--- PASS: TestReverse (0.0018467903137207)
```
</p>
</details>

<details><summary>interp tests passed</summary>
<p>

```
=== RUN   TestReverse
--- PASS: TestReverse (0.00049304962158203125)
```
</p>
</details>

<details><summary>jvm tests failed</summary>
<p>

```
Exception in thread "main" java.lang.NullPointerException: Cannot read field "name" because "test" is null
	at stdgo.testing.M.run(/usr/local/lib/haxe/lib/go2hx/git/stdgo/testing/Testing.hx:351)
	at golang_org.x.example.stringutil_test._Stringutil.Stringutil_Fields_.main(golibs/golang_org/x/example/stringutil_test/Stringutil.hx:17)
	at golang_org.x.example.stringutil_test._Stringutil.Stringutil_Fields_.main(golibs/golang_org/x/example/stringutil_test/Stringutil.hx:1)
Error: Command failed with error 1
=== RUN   TestReverse
--- PASS: TestReverse (0.003999948501586914)
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


[\(view code\)](<./Stringutil.hx#L22>)


## function testReverse


```haxe
function testReverse(_t:stdgo.Ref<stdgo.testing.T>):Void
```


 


[\(view code\)](<./Stringutil.hx#L42>)


