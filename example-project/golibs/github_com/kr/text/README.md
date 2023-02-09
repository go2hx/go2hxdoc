# Module: `github_com.kr.text`

[(view library index)](../../../golibs.md)


# Overview


Package text provides rudimentary functions for manipulating text in paragraphs. 


# Index


- [`function indent(_s:stdgo.GoString, _prefix:stdgo.GoString):stdgo.GoString`](<#function-indent>)

- [`function indentBytes(_b:stdgo.Slice<stdgo.GoByte>, _prefix:stdgo.Slice<stdgo.GoByte>):stdgo.Slice<stdgo.GoByte>`](<#function-indentbytes>)

- [`function newIndentWriter(_w:stdgo.io.Writer, _pre:haxe.Rest<stdgo.Slice<stdgo.GoByte>>):stdgo.io.Writer`](<#function-newindentwriter>)

- [`function wrap(_s:stdgo.GoString, _lim:stdgo.GoInt):stdgo.GoString`](<#function-wrap>)

- [`function wrapBytes(_b:stdgo.Slice<stdgo.GoByte>, _lim:stdgo.GoInt):stdgo.Slice<stdgo.GoByte>`](<#function-wrapbytes>)

- [`function wrapWords(_words:stdgo.Slice<stdgo.Slice<stdgo.GoByte>>, _spc:stdgo.GoInt, _lim:stdgo.GoInt, _pen:stdgo.GoInt):stdgo.Slice<stdgo.Slice<stdgo.Slice<stdgo.GoByte>>>`](<#function-wrapwords>)

# Functions


```haxe
import github_com.kr.text.Text
```


## function indent


```haxe
function indent(_s:stdgo.GoString, _prefix:stdgo.GoString):stdgo.GoString
```


Indent inserts prefix at the beginning of each non\-empty line of s. The end\-of\-line marker is NL. 


[\(view code\)](<./Text.hx#L58>)


## function indentBytes


```haxe
function indentBytes(_b:stdgo.Slice<stdgo.GoByte>, _prefix:stdgo.Slice<stdgo.GoByte>):stdgo.Slice<stdgo.GoByte>
```


IndentBytes inserts prefix at the beginning of each non\-empty line of b. The end\-of\-line marker is NL. 


[\(view code\)](<./Text.hx#L66>)


## function newIndentWriter


```haxe
function newIndentWriter(_w:stdgo.io.Writer, _pre:haxe.Rest<stdgo.Slice<stdgo.GoByte>>):stdgo.io.Writer
```


NewIndentWriter makes a new write filter that indents the input lines. Each line is prefixed in order with the corresponding element of pre. If there are more lines than elements, the last element of pre is repeated for each subsequent line. 


[\(view code\)](<./Text.hx#L85>)


## function wrap


```haxe
function wrap(_s:stdgo.GoString, _lim:stdgo.GoInt):stdgo.GoString
```


Wrap wraps s into a paragraph of lines of length lim, with minimal raggedness. 


[\(view code\)](<./Text.hx#L94>)


## function wrapBytes


```haxe
function wrapBytes(_b:stdgo.Slice<stdgo.GoByte>, _lim:stdgo.GoInt):stdgo.Slice<stdgo.GoByte>
```


WrapBytes wraps b into a paragraph of lines of length lim, with minimal raggedness. 


[\(view code\)](<./Text.hx#L102>)


## function wrapWords


```haxe
function wrapWords(_words:stdgo.Slice<stdgo.Slice<stdgo.GoByte>>, _spc:stdgo.GoInt, _lim:stdgo.GoInt, _pen:stdgo.GoInt):stdgo.Slice<stdgo.Slice<stdgo.Slice<stdgo.GoByte>>>
```


WrapWords is the low\-level line\-breaking algorithm, useful if you need more control over the details of the text wrapping process. For most uses, either Wrap or WrapBytes will be sufficient and more convenient. 


WrapWords splits a list of words into lines with minimal "raggedness", treating each byte as one unit, accounting for spc units between adjacent words on each line, and attempting to limit lines to lim units. Raggedness is the total error over all lines, where error is the square of the difference of the length of the line and lim. Too\-long lines \(which only happen when a single word is longer than lim units\) have pen penalty units added to the error. 


[\(view code\)](<./Text.hx#L124>)


