# Module: `golang_org.x.example.stringutil`

[(view library index)](../../../../golibs.md)


# Overview


Package stringutil contains utility functions for working with strings.  



<details><summary>interp tests passed</summary>
<p>

```
=== RUN  TestReverse
--- PASS: TestReverse (%!s(float64=0.0006961822509765625))

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



[\(view code\)](<./Stringutil.hx#L34>)


## function testReverse


```haxe
function testReverse(_t:stdgo.Ref<stdgo.testing.T>):Void
```





[\(view code\)](<./Stringutil.hx#L54>)


