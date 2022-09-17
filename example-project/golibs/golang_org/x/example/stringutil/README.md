# Module: golang\_org.x.example.stringutil


[(view library index)](../../../../golibs.md)


# Overview


Package stringutil contains utility functions for working with strings. 


<details><summary>cpp tests passed</summary>
<p>

```
=== RUN   TestReverse
--- PASS: TestReverse (0.000191926956176758)
```
</p>
</details>

<details><summary>hl tests passed</summary>
<p>

```
=== RUN   TestReverse
--- PASS: TestReverse (0.0018918514251709)
```
</p>
</details>

<details><summary>interp tests passed</summary>
<p>

```
=== RUN   TestReverse
--- PASS: TestReverse (0.0004119873046875)
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
--- PASS: TestReverse (0.005000114440917969)
```
</p>
</details>


# Index


- [function reverse\(\_s:stdgo.GoString\):stdgo.GoString](<#reverse>)

- [function testReverse\(\_t:stdgo.Ref\<stdgo.testing.T\>\):Void](<#testreverse>)

- [typedef T\_\_struct\_0](<#t__struct_0>)

# Functions


```haxe
import golang_org.x.example.stringutil.Stringutil
```


## reverse


```haxe
function reverse(_s:stdgo.GoString):stdgo.GoString
```


Reverse returns its argument string reversed rune\-wise left to right. 


[\(view code\)](<./Stringutil.hx#L22>)


## testReverse


```haxe
function testReverse(_t:stdgo.Ref<stdgo.testing.T>):Void
```


 


[\(view code\)](<./Stringutil.hx#L42>)


# Typedefs


```haxe
import golang_org.x.example.stringutil.*
```


## typedef T\_\_struct\_0


```haxe
typedef T__struct_0 = var a:{<_in> | stdgo.GoString | stdgo.GoString}
```


 


