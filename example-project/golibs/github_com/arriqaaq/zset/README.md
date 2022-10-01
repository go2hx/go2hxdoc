# Module: `github_com.arriqaaq.zset`

[(view library index)](../../../golibs.md)


# Overview


 


# Index


- [Constants](<#constants>)

- [`function _createNode(_level:stdgo.GoInt, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>`](<#>)

- [`function _newZSkipList():stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>`](<#>)

- [`function _randomLevel():stdgo.GoInt`](<#>)

- [`function new_():stdgo.Ref<github_com.arriqaaq.zset.ZSet>`](<#>)

- [`class ZRangeOptions`](<#class-zrangeoptions>)

  - [`function new(?limit:Null<stdgo.GoInt>, ?excludeStart:Bool, ?excludeEnd:Bool):Void`](<#zrangeoptions-function-new>)

- [`class ZSet`](<#class-zset>)

  - [`function new(?_records:stdgo.GoMap<stdgo.GoString, stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zset>>):Void`](<#zset-function-new>)

  - [`function _exist( _key:stdgo.GoString):Bool`](<#zset-function-_exist>)

  - [`function keys():stdgo.Slice<stdgo.GoString>`](<#zset-function-keys>)

  - [`function zadd( _key:stdgo.GoString, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.GoInt`](<#zset-function-zadd>)

  - [`function zcard( _key:stdgo.GoString):stdgo.GoInt`](<#zset-function-zcard>)

  - [`function zclear( _key:stdgo.GoString):Void`](<#zset-function-zclear>)

  - [`function zgetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zgetbyrank>)

  - [`function zincrBy( _key:stdgo.GoString, _increment:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoFloat64`](<#zset-function-zincrby>)

  - [`function zkeyExists( _key:stdgo.GoString):Bool`](<#zset-function-zkeyexists>)

  - [`function zpopMax( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>`](<#zset-function-zpopmax>)

  - [`function zpopMin( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>`](<#zset-function-zpopmin>)

  - [`function zrange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrange>)

  - [`function zrangeByScore( _key:stdgo.GoString, _start:stdgo.GoFloat64, _end:stdgo.GoFloat64, _options:stdgo.Ref<github_com.arriqaaq.zset.ZRangeOptions>):stdgo.Slice<stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>>`](<#zset-function-zrangebyscore>)

  - [`function zrangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrangewithscores>)

  - [`function zrank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64`](<#zset-function-zrank>)

  - [`function zrem( _key:stdgo.GoString, _member:stdgo.GoString):Bool`](<#zset-function-zrem>)

  - [`function zrevGetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrevgetbyrank>)

  - [`function zrevRange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrevrange>)

  - [`function zrevRangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrevrangewithscores>)

  - [`function zrevRank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64`](<#zset-function-zrevrank>)

  - [`function zrevScoreRange( _key:stdgo.GoString, _max:stdgo.GoFloat64, _min:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrevscorerange>)

  - [`function zscore( _key:stdgo.GoString, _member:stdgo.GoString):{_1:stdgo.GoFloat64, _0:Bool}`](<#zset-function-zscore>)

  - [`function zscoreRange( _key:stdgo.GoString, _min:stdgo.GoFloat64, _max:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zscorerange>)

# Constants


```haxe
import github_com.arriqaaq.zset.Zset
```


```haxe
final skiplist_MAXLEVEL:stdgo.GoUnTypedInt = ((32 : GoUnTypedInt))
```


|\* For 2^32 elements \*|/ 


```haxe
final skiplist_Probability:stdgo.GoUnTypedFloat = ((0.25 : GoUnTypedFloat))
```


|\* Skiplist probability = 1/4 \*|/ 


# Functions


```haxe
import github_com.arriqaaq.zset.Zset
```


## `function _createNode`
```haxe
function _createNode(_level:stdgo.GoInt, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


 


[\(view code\)](<./Zset.hx#L180>)


## `function _newZSkipList`
```haxe
function _newZSkipList():stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>
```


 


[\(view code\)](<./Zset.hx#L193>)


## `function _randomLevel`
```haxe
function _randomLevel():stdgo.GoInt
```


Returns a random level for the new skiplist node we are going to create. The return value of this function is between 1 and SKIPLIST\_MAXLEVEL \(both inclusive\), with a powerlaw\-alike distribution where higher levels are less likely to be returned. 


[\(view code\)](<./Zset.hx#L169>)


## `function new_`
```haxe
function new_():stdgo.Ref<github_com.arriqaaq.zset.ZSet>
```


New create a new sorted set 


[\(view code\)](<./Zset.hx#L200>)


# Classes


```haxe
import github_com.arriqaaq.zset.*
```


## class ZRangeOptions


 


```haxe
var excludeEnd:Bool
```


exclude end value, so it search in interval \[start, end\) or \(start, end\) 


```haxe
var excludeStart:Bool
```


exclude start value, so it search in interval \(start, end\] or \(start, end\) 


```haxe
var limit:stdgo.GoInt
```


limit the max nodes to return 


### ZRangeOptions function new


```haxe
function new(?limit:Null<stdgo.GoInt>, ?excludeStart:Bool, ?excludeEnd:Bool):Void
```


 


[\(view code\)](<./Zset.hx#L146>)


## class ZSet


 


```haxe
var _records:stdgo.GoMap<stdgo.GoString, stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zset>>
```


### ZSet function new


```haxe
function new(?_records:stdgo.GoMap<stdgo.GoString, stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zset>>):Void
```


 


[\(view code\)](<./Zset.hx#L26>)


### ZSet function \_exist


```haxe
function _exist( _key:stdgo.GoString):Bool
```


 


[\(view code\)](<./Zset.hx#L1129>)


### ZSet function keys


```haxe
function keys():stdgo.Slice<stdgo.GoString>
```


 


[\(view code\)](<./Zset.hx#L573>)


### ZSet function zadd


```haxe
function zadd( _key:stdgo.GoString, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.GoInt
```


ZAdd Adds the specified member with the specified score to the sorted set stored at key. Add an element into the sorted set with specific key / value / score. Time complexity of this method is : O\(log\(N\)\) 


[\(view code\)](<./Zset.hx#L1049>)


### ZSet function zcard


```haxe
function zcard( _key:stdgo.GoString):stdgo.GoInt
```


ZCard returns the sorted set cardinality \(number of elements\) of the sorted set stored at key. 


[\(view code\)](<./Zset.hx#L1016>)


### ZSet function zclear


```haxe
function zclear( _key:stdgo.GoString):Void
```


ZClear clear the key in zset. 


[\(view code\)](<./Zset.hx#L828>)


### ZSet function zgetByRank


```haxe
function zgetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZGetByRank gets the member at key by rank, the rank is ordered from lowest to highest. The rank of lowest is 0 and so on. 


[\(view code\)](<./Zset.hx#L759>)


### ZSet function zincrBy


```haxe
function zincrBy( _key:stdgo.GoString, _increment:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoFloat64
```


ZIncrBy increments the score of member in the sorted set stored at key by increment. If member does not exist in the sorted set, it is added with increment as its score \(as if its previous score was 0.0\). If key does not exist, a new sorted set with the specified member as its sole member is created. 


[\(view code\)](<./Zset.hx#L949>)


### ZSet function zkeyExists


```haxe
function zkeyExists( _key:stdgo.GoString):Bool
```


ZKeyExists check if the key exists in zset. 


[\(view code\)](<./Zset.hx#L839>)


### ZSet function zpopMax


```haxe
function zpopMax( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


get and remove the element with maximum score, nil if the set is empty 


[\(view code\)](<./Zset.hx#L706>)


### ZSet function zpopMin


```haxe
function zpopMin( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


get and remove the element with minimal score, nil if the set is empty 


[\(view code\)](<./Zset.hx#L723>)


### ZSet function zrange


```haxe
function zrange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRange returns the specified range of elements in the sorted set stored at \<key\>. 


[\(view code\)](<./Zset.hx#L816>)


### ZSet function zrangeByScore


```haxe
function zrangeByScore( _key:stdgo.GoString, _start:stdgo.GoFloat64, _end:stdgo.GoFloat64, _options:stdgo.Ref<github_com.arriqaaq.zset.ZRangeOptions>):stdgo.Slice<stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>>
```


|\* Returns all the elements in the sorted set at key with a score between min and max \(including elements with score equal to min or max\). The elements are considered to be ordered from low to high scores.  If options is nil, it searchs in interval \[start, end\] without any limit by default  https://github.com/wangjia184/sortedset/blob/af6d6d227aa79e2a64b899d995ce18aa0bef437c/sortedset.go#L283 \*|/ 


[\(view code\)](<./Zset.hx#L594>)


### ZSet function zrangeWithScores


```haxe
function zrangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRangeWithScores returns the specified range of elements in the sorted set stored at \<key\>. 


[\(view code\)](<./Zset.hx#L804>)


### ZSet function zrank


```haxe
function zrank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```


ZRank returns the rank of member in the sorted set stored at key, with the scores ordered from low to high. The rank \(or index\) is 0\-based, which means that the member with the lowest score has rank 0. 


[\(view code\)](<./Zset.hx#L995>)


### ZSet function zrem


```haxe
function zrem( _key:stdgo.GoString, _member:stdgo.GoString):Bool
```


ZRem removes the specified members from the sorted set stored at key. Non existing members are ignored. An error is returned when key exists and does not hold a sorted set. 


[\(view code\)](<./Zset.hx#L925>)


### ZSet function zrevGetByRank


```haxe
function zrevGetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevGetByRank get the member at key by rank, the rank is ordered from highest to lowest. The rank of highest is 0 and so on. 


[\(view code\)](<./Zset.hx#L741>)


### ZSet function zrevRange


```haxe
function zrevRange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevRange returns the specified range of elements in the sorted set stored at key. The elements are considered to be ordered from the highest to the lowest score. Descending lexicographical order is used for elements with equal score. 


[\(view code\)](<./Zset.hx#L792>)


### ZSet function zrevRangeWithScores


```haxe
function zrevRangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevRange returns the specified range of elements in the sorted set stored at key. The elements are considered to be ordered from the highest to the lowest score. Descending lexicographical order is used for elements with equal score. 


[\(view code\)](<./Zset.hx#L778>)


### ZSet function zrevRank


```haxe
function zrevRank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```


ZRevRank returns the rank of member in the sorted set stored at key, with the scores ordered from high to low. The rank \(or index\) is 0\-based, which means that the member with the highest score has rank 0. 


[\(view code\)](<./Zset.hx#L974>)


### ZSet function zrevScoreRange


```haxe
function zrevScoreRange( _key:stdgo.GoString, _max:stdgo.GoFloat64, _min:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```


ZRevScoreRange returns all the elements in the sorted set at key with a score between max and min \(including elements with score equal to max or min\). In contrary to the default ordering of sorted sets, for this command the elements are considered to be ordered from high to low scores. 


[\(view code\)](<./Zset.hx#L848>)


### ZSet function zscore


```haxe
function zscore( _key:stdgo.GoString, _member:stdgo.GoString):{_1:stdgo.GoFloat64, _0:Bool}
```


ZScore returns the score of member in the sorted set at key. 


[\(view code\)](<./Zset.hx#L1027>)


### ZSet function zscoreRange


```haxe
function zscoreRange( _key:stdgo.GoString, _min:stdgo.GoFloat64, _max:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```


ZScoreRange returns all the elements in the sorted set at key with a score between min and max \(including elements with score equal to min or max\). The elements are considered to be ordered from low to high scores. 


[\(view code\)](<./Zset.hx#L886>)


