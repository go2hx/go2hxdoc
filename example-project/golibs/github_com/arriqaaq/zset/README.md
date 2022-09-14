# Module: github\_com.arriqaaq.zset


[(view library index)](../../../golibs.md)


# Overview


 


# Index


- [Constants](<#constants>)

- [function \_createNode\(\_level:stdgo.GoInt, \_score:stdgo.GoFloat64, \_member:stdgo.GoString, \_value:stdgo.AnyInterface\):github\_com.arriqaaq.zset.\_Zset.T\_zskiplistNode](<#_createnode>)

- [function \_newZSkipList\(\):github\_com.arriqaaq.zset.\_Zset.T\_zskiplist](<#_newzskiplist>)

- [function \_randomLevel\(\):stdgo.GoInt](<#_randomlevel>)

- [function new\_\(\):github\_com.arriqaaq.zset.ZSet](<#new_>)

- [class ZRangeOptions](<#zrangeoptions>)

  - [function new\(?limit:Null\<stdgo.GoInt\>, ?excludeStart:Bool, ?excludeEnd:Bool\):Void](<#zrangeoptions-new>)

- [class ZSet](<#zset>)

  - [function new\(?\_records:stdgo.GoMap\<stdgo.GoString, stdgo.Ref\<github\_com.arriqaaq.zset.\_Zset.T\_zset\>\>\):Void](<#zset-new>)

  - [function \_exist\( \_key:stdgo.GoString\):Bool](<#zset-_exist>)

  - [function keys\(\):stdgo.Slice\<stdgo.GoString\>](<#zset-keys>)

  - [function zadd\( \_key:stdgo.GoString, \_score:stdgo.GoFloat64, \_member:stdgo.GoString, \_value:stdgo.AnyInterface\):stdgo.GoInt](<#zset-zadd>)

  - [function zcard\( \_key:stdgo.GoString\):stdgo.GoInt](<#zset-zcard>)

  - [function zclear\( \_key:stdgo.GoString\):Void](<#zset-zclear>)

  - [function zgetByRank\( \_key:stdgo.GoString, \_rank:stdgo.GoInt\):stdgo.Slice\<stdgo.AnyInterface\>](<#zset-zgetbyrank>)

  - [function zincrBy\( \_key:stdgo.GoString, \_increment:stdgo.GoFloat64, \_member:stdgo.GoString\):stdgo.GoFloat64](<#zset-zincrby>)

  - [function zkeyExists\( \_key:stdgo.GoString\):Bool](<#zset-zkeyexists>)

  - [function zpopMax\( \_key:stdgo.GoString\):github\_com.arriqaaq.zset.\_Zset.T\_zskiplistNode](<#zset-zpopmax>)

  - [function zpopMin\( \_key:stdgo.GoString\):github\_com.arriqaaq.zset.\_Zset.T\_zskiplistNode](<#zset-zpopmin>)

  - [function zrange\( \_key:stdgo.GoString, \_start:stdgo.GoInt, \_stop:stdgo.GoInt\):stdgo.Slice\<stdgo.AnyInterface\>](<#zset-zrange>)

  - [function zrangeByScore\( \_key:stdgo.GoString, \_start:stdgo.GoFloat64, \_end:stdgo.GoFloat64, \_options:github\_com.arriqaaq.zset.ZRangeOptions\):stdgo.Slice\<github\_com.arriqaaq.zset.\_Zset.T\_zskiplistNode\>](<#zset-zrangebyscore>)

  - [function zrangeWithScores\( \_key:stdgo.GoString, \_start:stdgo.GoInt, \_stop:stdgo.GoInt\):stdgo.Slice\<stdgo.AnyInterface\>](<#zset-zrangewithscores>)

  - [function zrank\( \_key:stdgo.GoString, \_member:stdgo.GoString\):stdgo.GoInt64](<#zset-zrank>)

  - [function zrem\( \_key:stdgo.GoString, \_member:stdgo.GoString\):Bool](<#zset-zrem>)

  - [function zrevGetByRank\( \_key:stdgo.GoString, \_rank:stdgo.GoInt\):stdgo.Slice\<stdgo.AnyInterface\>](<#zset-zrevgetbyrank>)

  - [function zrevRange\( \_key:stdgo.GoString, \_start:stdgo.GoInt, \_stop:stdgo.GoInt\):stdgo.Slice\<stdgo.AnyInterface\>](<#zset-zrevrange>)

  - [function zrevRangeWithScores\( \_key:stdgo.GoString, \_start:stdgo.GoInt, \_stop:stdgo.GoInt\):stdgo.Slice\<stdgo.AnyInterface\>](<#zset-zrevrangewithscores>)

  - [function zrevRank\( \_key:stdgo.GoString, \_member:stdgo.GoString\):stdgo.GoInt64](<#zset-zrevrank>)

  - [function zrevScoreRange\( \_key:stdgo.GoString, \_max:stdgo.GoFloat64, \_min:stdgo.GoFloat64\):stdgo.Slice\<stdgo.AnyInterface\>](<#zset-zrevscorerange>)

  - [function zscore\( \_key:stdgo.GoString, \_member:stdgo.GoString\):\{\_1:stdgo.GoFloat64, \_0:Bool\}](<#zset-zscore>)

  - [function zscoreRange\( \_key:stdgo.GoString, \_min:stdgo.GoFloat64, \_max:stdgo.GoFloat64\):stdgo.Slice\<stdgo.AnyInterface\>](<#zset-zscorerange>)

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


## \_createNode


```haxe
function _createNode(_level:stdgo.GoInt, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):github_com.arriqaaq.zset._Zset.T_zskiplistNode
```


 


[\(view code\)](<./Zset.hx#L126>)


## \_newZSkipList


```haxe
function _newZSkipList():github_com.arriqaaq.zset._Zset.T_zskiplist
```


 


[\(view code\)](<./Zset.hx#L133>)


## \_randomLevel


```haxe
function _randomLevel():stdgo.GoInt
```


Returns a random level for the new skiplist node we are going to create. The return value of this function is between 1 and SKIPLIST\_MAXLEVEL \(both inclusive\), with a powerlaw\-alike distribution where higher levels are less likely to be returned. 


[\(view code\)](<./Zset.hx#L116>)


## new\_


```haxe
function new_():github_com.arriqaaq.zset.ZSet
```


New create a new sorted set 


[\(view code\)](<./Zset.hx#L139>)


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


### ZRangeOptions new


```haxe
function new(?limit:Null<stdgo.GoInt>, ?excludeStart:Bool, ?excludeEnd:Bool):Void
```


 


[\(view code\)](<./Zset.hx#L100>)


## class ZSet


 


```haxe
var _records:stdgo.GoMap<stdgo.GoString, stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zset>>
```


### ZSet new


```haxe
function new(?_records:stdgo.GoMap<stdgo.GoString, stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zset>>):Void
```


 


[\(view code\)](<./Zset.hx#L21>)


### ZSet \_exist


```haxe
function _exist( _key:stdgo.GoString):Bool
```


 


[\(view code\)](<./Zset.hx#L737>)


### ZSet keys


```haxe
function keys():stdgo.Slice<stdgo.GoString>
```


 


[\(view code\)](<./Zset.hx#L278>)


### ZSet zadd


```haxe
function zadd( _key:stdgo.GoString, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.GoInt
```


ZAdd Adds the specified member with the specified score to the sorted set stored at key. Add an element into the sorted set with specific key / value / score. Time complexity of this method is : O\(log\(N\)\) 


[\(view code\)](<./Zset.hx#L710>)


### ZSet zcard


```haxe
function zcard( _key:stdgo.GoString):stdgo.GoInt
```


ZCard returns the sorted set cardinality \(number of elements\) of the sorted set stored at key. 


[\(view code\)](<./Zset.hx#L683>)


### ZSet zclear


```haxe
function zclear( _key:stdgo.GoString):Void
```


ZClear clear the key in zset. 


[\(view code\)](<./Zset.hx#L518>)


### ZSet zgetByRank


```haxe
function zgetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZGetByRank gets the member at key by rank, the rank is ordered from lowest to highest. The rank of lowest is 0 and so on. 


[\(view code\)](<./Zset.hx#L456>)


### ZSet zincrBy


```haxe
function zincrBy( _key:stdgo.GoString, _increment:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoFloat64
```


ZIncrBy increments the score of member in the sorted set stored at key by increment. If member does not exist in the sorted set, it is added with increment as its score \(as if its previous score was 0.0\). If key does not exist, a new sorted set with the specified member as its sole member is created. 


[\(view code\)](<./Zset.hx#L629>)


### ZSet zkeyExists


```haxe
function zkeyExists( _key:stdgo.GoString):Bool
```


ZKeyExists check if the key exists in zset. 


[\(view code\)](<./Zset.hx#L527>)


### ZSet zpopMax


```haxe
function zpopMax( _key:stdgo.GoString):github_com.arriqaaq.zset._Zset.T_zskiplistNode
```


get and remove the element with maximum score, nil if the set is empty 


[\(view code\)](<./Zset.hx#L408>)


### ZSet zpopMin


```haxe
function zpopMin( _key:stdgo.GoString):github_com.arriqaaq.zset._Zset.T_zskiplistNode
```


get and remove the element with minimal score, nil if the set is empty 


[\(view code\)](<./Zset.hx#L424>)


### ZSet zrange


```haxe
function zrange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRange returns the specified range of elements in the sorted set stored at \<key\>. 


[\(view code\)](<./Zset.hx#L507>)


### ZSet zrangeByScore


```haxe
function zrangeByScore( _key:stdgo.GoString, _start:stdgo.GoFloat64, _end:stdgo.GoFloat64, _options:github_com.arriqaaq.zset.ZRangeOptions):stdgo.Slice<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


|\* Returns all the elements in the sorted set at key with a score between min and max \(including elements with score equal to min or max\). The elements are considered to be ordered from low to high scores.  If options is nil, it searchs in interval \[start, end\] without any limit by default  https://github.com/wangjia184/sortedset/blob/af6d6d227aa79e2a64b899d995ce18aa0bef437c/sortedset.go#L283 \*|/ 


[\(view code\)](<./Zset.hx#L297>)


### ZSet zrangeWithScores


```haxe
function zrangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRangeWithScores returns the specified range of elements in the sorted set stored at \<key\>. 


[\(view code\)](<./Zset.hx#L496>)


### ZSet zrank


```haxe
function zrank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```


ZRank returns the rank of member in the sorted set stored at key, with the scores ordered from low to high. The rank \(or index\) is 0\-based, which means that the member with the lowest score has rank 0. 


[\(view code\)](<./Zset.hx#L666>)


### ZSet zrem


```haxe
function zrem( _key:stdgo.GoString, _member:stdgo.GoString):Bool
```


ZRem removes the specified members from the sorted set stored at key. Non existing members are ignored. An error is returned when key exists and does not hold a sorted set. 


[\(view code\)](<./Zset.hx#L610>)


### ZSet zrevGetByRank


```haxe
function zrevGetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevGetByRank get the member at key by rank, the rank is ordered from highest to lowest. The rank of highest is 0 and so on. 


[\(view code\)](<./Zset.hx#L441>)


### ZSet zrevRange


```haxe
function zrevRange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevRange returns the specified range of elements in the sorted set stored at key. The elements are considered to be ordered from the highest to the lowest score. Descending lexicographical order is used for elements with equal score. 


[\(view code\)](<./Zset.hx#L485>)


### ZSet zrevRangeWithScores


```haxe
function zrevRangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevRange returns the specified range of elements in the sorted set stored at key. The elements are considered to be ordered from the highest to the lowest score. Descending lexicographical order is used for elements with equal score. 


[\(view code\)](<./Zset.hx#L472>)


### ZSet zrevRank


```haxe
function zrevRank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```


ZRevRank returns the rank of member in the sorted set stored at key, with the scores ordered from high to low. The rank \(or index\) is 0\-based, which means that the member with the highest score has rank 0. 


[\(view code\)](<./Zset.hx#L649>)


### ZSet zrevScoreRange


```haxe
function zrevScoreRange( _key:stdgo.GoString, _max:stdgo.GoFloat64, _min:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```


ZRevScoreRange returns all the elements in the sorted set at key with a score between max and min \(including elements with score equal to max or min\). In contrary to the default ordering of sorted sets, for this command the elements are considered to be ordered from high to low scores. 


[\(view code\)](<./Zset.hx#L535>)


### ZSet zscore


```haxe
function zscore( _key:stdgo.GoString, _member:stdgo.GoString):{_1:stdgo.GoFloat64, _0:Bool}
```


ZScore returns the score of member in the sorted set at key. 


[\(view code\)](<./Zset.hx#L693>)


### ZSet zscoreRange


```haxe
function zscoreRange( _key:stdgo.GoString, _min:stdgo.GoFloat64, _max:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```


ZScoreRange returns all the elements in the sorted set at key with a score between min and max \(including elements with score equal to min or max\). The elements are considered to be ordered from low to high scores. 


[\(view code\)](<./Zset.hx#L572>)


