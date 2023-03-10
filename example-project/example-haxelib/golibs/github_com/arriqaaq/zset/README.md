# Module: `github_com.arriqaaq.zset`

[(view library index)](../../../golibs.md)


# Overview


# Index


- [Constants](<#constants>)

- [`function new_():stdgo.Ref<github_com.arriqaaq.zset.ZSet>`](<#function-new_>)

- [class ZRangeOptions](<#class-zrangeoptions>)

  - [`function new(?limit:Null<stdgo.GoInt>, ?excludeStart:Bool, ?excludeEnd:Bool):Void`](<#zrangeoptions-function-new>)

- [class ZSet](<#class-zset>)

  - [`function new(?_records:stdgo.GoMap<stdgo.GoString, stdgo.Ref<github_com.arriqaaq.zset.T_zset>>):Void`](<#zset-function-new>)

  - [`function _exist( _key:stdgo.GoString):Bool`](<#zset-function-_exist>)

  - [`function keys():stdgo.Slice<stdgo.GoString>`](<#zset-function-keys>)

  - [`function zadd( _key:stdgo.GoString, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.GoInt`](<#zset-function-zadd>)

  - [`function zcard( _key:stdgo.GoString):stdgo.GoInt`](<#zset-function-zcard>)

  - [`function zclear( _key:stdgo.GoString):Void`](<#zset-function-zclear>)

  - [`function zgetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zgetbyrank>)

  - [`function zincrBy( _key:stdgo.GoString, _increment:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoFloat64`](<#zset-function-zincrby>)

  - [`function zkeyExists( _key:stdgo.GoString):Bool`](<#zset-function-zkeyexists>)

  - [`function zpopMax( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset.T_zskiplistNode>`](<#zset-function-zpopmax>)

  - [`function zpopMin( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset.T_zskiplistNode>`](<#zset-function-zpopmin>)

  - [`function zrange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrange>)

  - [`function zrangeByScore( _key:stdgo.GoString, _start:stdgo.GoFloat64, _end:stdgo.GoFloat64, _options:stdgo.Ref<github_com.arriqaaq.zset.ZRangeOptions>):stdgo.Slice<stdgo.Ref<github_com.arriqaaq.zset.T_zskiplistNode>>`](<#zset-function-zrangebyscore>)

  - [`function zrangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrangewithscores>)

  - [`function zrank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64`](<#zset-function-zrank>)

  - [`function zrem( _key:stdgo.GoString, _member:stdgo.GoString):Bool`](<#zset-function-zrem>)

  - [`function zrevGetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrevgetbyrank>)

  - [`function zrevRange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrevrange>)

  - [`function zrevRangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrevrangewithscores>)

  - [`function zrevRank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64`](<#zset-function-zrevrank>)

  - [`function zrevScoreRange( _key:stdgo.GoString, _max:stdgo.GoFloat64, _min:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zrevscorerange>)

  - [`function zscore( _key:stdgo.GoString, _member:stdgo.GoString):{ _1:stdgo.GoFloat64; _0:Bool;}`](<#zset-function-zscore>)

  - [`function zscoreRange( _key:stdgo.GoString, _min:stdgo.GoFloat64, _max:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>`](<#zset-function-zscorerange>)

# Constants


```haxe
import github_com.arriqaaq.zset.Zset
```


```haxe
final skiplist_MAXLEVEL:stdgo.GoUInt64 = (("32" : GoUInt64))
```



For 2^32 elements  

```haxe
final skiplist_Probability:stdgo.GoFloat64 = ((0.25 : GoFloat64))
```



Skiplist probability = 1/4  

# Functions


```haxe
import github_com.arriqaaq.zset.Zset
```


## function new\_


```haxe
function new_():stdgo.Ref<github_com.arriqaaq.zset.ZSet>
```



New create a new sorted set  

[\(view code\)](<./Zset.hx#L164>)


# Classes


```haxe
import github_com.arriqaaq.zset.*
```


## class ZRangeOptions


```haxe
var excludeEnd:Bool
```


```haxe
var excludeStart:Bool
```


```haxe
var limit:stdgo.GoInt
```


### ZRangeOptions function new


```haxe
function new(?limit:Null<stdgo.GoInt>, ?excludeStart:Bool, ?excludeEnd:Bool):Void
```


[\(view code\)](<./Zset.hx#L125>)


## class ZSet


```haxe
var _records:stdgo.GoMap<stdgo.GoString, stdgo.Ref<github_com.arriqaaq.zset.T_zset>>
```


### ZSet function new


```haxe
function new(?_records:stdgo.GoMap<stdgo.GoString, stdgo.Ref<github_com.arriqaaq.zset.T_zset>>):Void
```


[\(view code\)](<./Zset.hx#L30>)


### ZSet function \_exist


```haxe
function _exist( _key:stdgo.GoString):Bool
```


[\(view code\)](<./Zset.hx#L764>)


### ZSet function keys


```haxe
function keys():stdgo.Slice<stdgo.GoString>
```


[\(view code\)](<./Zset.hx#L305>)


### ZSet function zadd


```haxe
function zadd( _key:stdgo.GoString, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.GoInt
```



ZAdd Adds the specified member with the specified score to the sorted set stored at key.
Add an element into the sorted set with specific key / value / score.
Time complexity of this method is : O\(log\(N\)\)  

[\(view code\)](<./Zset.hx#L737>)


### ZSet function zcard


```haxe
function zcard( _key:stdgo.GoString):stdgo.GoInt
```



ZCard returns the sorted set cardinality \(number of elements\) of the sorted set stored at key.  

[\(view code\)](<./Zset.hx#L710>)


### ZSet function zclear


```haxe
function zclear( _key:stdgo.GoString):Void
```



ZClear clear the key in zset.  

[\(view code\)](<./Zset.hx#L545>)


### ZSet function zgetByRank


```haxe
function zgetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```



ZGetByRank gets the member at key by rank, the rank is ordered from lowest to highest.
The rank of lowest is 0 and so on.  

[\(view code\)](<./Zset.hx#L483>)


### ZSet function zincrBy


```haxe
function zincrBy( _key:stdgo.GoString, _increment:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoFloat64
```



ZIncrBy increments the score of member in the sorted set stored at key by increment.
If member does not exist in the sorted set, it is added with increment as its score \(as if its previous score was 0.0\).
If key does not exist, a new sorted set with the specified member as its sole member is created.  

[\(view code\)](<./Zset.hx#L656>)


### ZSet function zkeyExists


```haxe
function zkeyExists( _key:stdgo.GoString):Bool
```



ZKeyExists check if the key exists in zset.  

[\(view code\)](<./Zset.hx#L554>)


### ZSet function zpopMax


```haxe
function zpopMax( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset.T_zskiplistNode>
```



get and remove the element with maximum score, nil if the set is empty  

[\(view code\)](<./Zset.hx#L435>)


### ZSet function zpopMin


```haxe
function zpopMin( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset.T_zskiplistNode>
```



get and remove the element with minimal score, nil if the set is empty  

[\(view code\)](<./Zset.hx#L451>)


### ZSet function zrange


```haxe
function zrange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```



ZRange returns the specified range of elements in the sorted set stored at \<key\>.  

[\(view code\)](<./Zset.hx#L534>)


### ZSet function zrangeByScore


```haxe
function zrangeByScore( _key:stdgo.GoString, _start:stdgo.GoFloat64, _end:stdgo.GoFloat64, _options:stdgo.Ref<github_com.arriqaaq.zset.ZRangeOptions>):stdgo.Slice<stdgo.Ref<github_com.arriqaaq.zset.T_zskiplistNode>>
```


```
        	Returns all the elements in the sorted set at key with a score between min and max (including
        	elements with score equal to min or max). The elements are considered to be ordered from low to
        	high scores.
```
```
        	If options is nil, it searchs in interval [start, end] without any limit by default
```
```
        	https://github.com/wangjia184/sortedset/blob/af6d6d227aa79e2a64b899d995ce18aa0bef437c/sortedset.go#L283
```
[\(view code\)](<./Zset.hx#L324>)


### ZSet function zrangeWithScores


```haxe
function zrangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```



ZRangeWithScores returns the specified range of elements in the sorted set stored at \<key\>.  

[\(view code\)](<./Zset.hx#L523>)


### ZSet function zrank


```haxe
function zrank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```



ZRank returns the rank of member in the sorted set stored at key, with the scores ordered from low to high.
The rank \(or index\) is 0\-based, which means that the member with the lowest score has rank 0.  

[\(view code\)](<./Zset.hx#L693>)


### ZSet function zrem


```haxe
function zrem( _key:stdgo.GoString, _member:stdgo.GoString):Bool
```



ZRem removes the specified members from the sorted set stored at key. Non existing members are ignored.
An error is returned when key exists and does not hold a sorted set.  

[\(view code\)](<./Zset.hx#L637>)


### ZSet function zrevGetByRank


```haxe
function zrevGetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```



ZRevGetByRank get the member at key by rank, the rank is ordered from highest to lowest.
The rank of highest is 0 and so on.  

[\(view code\)](<./Zset.hx#L468>)


### ZSet function zrevRange


```haxe
function zrevRange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```



ZRevRange returns the specified range of elements in the sorted set stored at key.
The elements are considered to be ordered from the highest to the lowest score.
Descending lexicographical order is used for elements with equal score.  

[\(view code\)](<./Zset.hx#L512>)


### ZSet function zrevRangeWithScores


```haxe
function zrevRangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```



ZRevRange returns the specified range of elements in the sorted set stored at key.
The elements are considered to be ordered from the highest to the lowest score.
Descending lexicographical order is used for elements with equal score.  

[\(view code\)](<./Zset.hx#L499>)


### ZSet function zrevRank


```haxe
function zrevRank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```



ZRevRank returns the rank of member in the sorted set stored at key, with the scores ordered from high to low.
The rank \(or index\) is 0\-based, which means that the member with the highest score has rank 0.  

[\(view code\)](<./Zset.hx#L676>)


### ZSet function zrevScoreRange


```haxe
function zrevScoreRange( _key:stdgo.GoString, _max:stdgo.GoFloat64, _min:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```



ZRevScoreRange returns all the elements in the sorted set at key with a score between max and min \(including elements with score equal to max or min\).
In contrary to the default ordering of sorted sets, for this command the elements are considered to be ordered from high to low scores.  

[\(view code\)](<./Zset.hx#L562>)


### ZSet function zscore


```haxe
function zscore( _key:stdgo.GoString, _member:stdgo.GoString):{
	_1:stdgo.GoFloat64;
	_0:Bool;
}
```



ZScore returns the score of member in the sorted set at key.  

[\(view code\)](<./Zset.hx#L720>)


### ZSet function zscoreRange


```haxe
function zscoreRange( _key:stdgo.GoString, _min:stdgo.GoFloat64, _max:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```



ZScoreRange returns all the elements in the sorted set at key with a score between min and max \(including elements with score equal to min or max\).
The elements are considered to be ordered from low to high scores.  

[\(view code\)](<./Zset.hx#L599>)


