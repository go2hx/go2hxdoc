# Module: `github_com.arriqaaq.zset`

[(view library index)](../../../golibs.md)


# Overview


 


# Index


- [Constants](<#constants>)

- [`function _createNode(_level:stdgo.GoInt, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>`](<#function-_createnode>)

- [`function _newZSkipList():stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>`](<#function-_newzskiplist>)

- [`function _randomLevel():stdgo.GoInt`](<#function-_randomlevel>)

- [`function new_():stdgo.Ref<github_com.arriqaaq.zset.ZSet>`](<#function-new_>)

- [class T\_zset\_static\_extension](<#class-t_zset_static_extension>)

  - [`function _findRange(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zset>, _key:stdgo.GoString, _start:stdgo.GoInt64, _stop:stdgo.GoInt64, _reverse:Bool, _withScores:Bool):stdgo.Slice<stdgo.AnyInterface>`](<#t_zset_static_extension-function-_findrange>)

  - [`function _getNodeByRank(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zset>, _key:stdgo.GoString, _rank:stdgo.GoInt64, _reverse:Bool):{_1:stdgo.GoFloat64, _0:stdgo.GoString}`](<#t_zset_static_extension-function-_getnodebyrank>)

- [class T\_zskiplist\_static\_extension](<#class-t_zskiplist_static_extension>)

  - [`function _delete(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _score:stdgo.GoFloat64, _member:stdgo.GoString):Void`](<#t_zskiplist_static_extension-function-_delete>)

  - [`function _deleteNode(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _x:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>, _updates:stdgo.Slice<stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>>):Void`](<#t_zskiplist_static_extension-function-_deletenode>)

  - [`function _getNodeByRank(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _rank:stdgo.GoUInt64):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>`](<#t_zskiplist_static_extension-function-_getnodebyrank>)

  - [`function _getRank(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _score:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoInt64`](<#t_zskiplist_static_extension-function-_getrank>)

  - [`function _insert(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>`](<#t_zskiplist_static_extension-function-_insert>)

- [class ZRangeOptions](<#class-zrangeoptions>)

  - [`function new(?limit:Null<stdgo.GoInt>, ?excludeStart:Bool, ?excludeEnd:Bool):Void`](<#zrangeoptions-function-new>)

- [class ZSet](<#class-zset>)

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

- [class ZSet\_static\_extension](<#class-zset_static_extension>)

  - [`function _exist( _key:stdgo.GoString):Bool`](<#zset_static_extension-function-_exist>)

  - [`function keys():stdgo.Slice<stdgo.GoString>`](<#zset_static_extension-function-keys>)

  - [`function zadd( _key:stdgo.GoString, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.GoInt`](<#zset_static_extension-function-zadd>)

  - [`function zcard( _key:stdgo.GoString):stdgo.GoInt`](<#zset_static_extension-function-zcard>)

  - [`function zclear( _key:stdgo.GoString):Void`](<#zset_static_extension-function-zclear>)

  - [`function zgetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset_static_extension-function-zgetbyrank>)

  - [`function zincrBy( _key:stdgo.GoString, _increment:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoFloat64`](<#zset_static_extension-function-zincrby>)

  - [`function zkeyExists( _key:stdgo.GoString):Bool`](<#zset_static_extension-function-zkeyexists>)

  - [`function zpopMax( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>`](<#zset_static_extension-function-zpopmax>)

  - [`function zpopMin( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>`](<#zset_static_extension-function-zpopmin>)

  - [`function zrange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset_static_extension-function-zrange>)

  - [`function zrangeByScore( _key:stdgo.GoString, _start:stdgo.GoFloat64, _end:stdgo.GoFloat64, _options:stdgo.Ref<github_com.arriqaaq.zset.ZRangeOptions>):stdgo.Slice<stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>>`](<#zset_static_extension-function-zrangebyscore>)

  - [`function zrangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset_static_extension-function-zrangewithscores>)

  - [`function zrank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64`](<#zset_static_extension-function-zrank>)

  - [`function zrem( _key:stdgo.GoString, _member:stdgo.GoString):Bool`](<#zset_static_extension-function-zrem>)

  - [`function zrevGetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset_static_extension-function-zrevgetbyrank>)

  - [`function zrevRange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset_static_extension-function-zrevrange>)

  - [`function zrevRangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>`](<#zset_static_extension-function-zrevrangewithscores>)

  - [`function zrevRank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64`](<#zset_static_extension-function-zrevrank>)

  - [`function zrevScoreRange( _key:stdgo.GoString, _max:stdgo.GoFloat64, _min:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>`](<#zset_static_extension-function-zrevscorerange>)

  - [`function zscore( _key:stdgo.GoString, _member:stdgo.GoString):{_1:stdgo.GoFloat64, _0:Bool}`](<#zset_static_extension-function-zscore>)

  - [`function zscoreRange( _key:stdgo.GoString, _min:stdgo.GoFloat64, _max:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>`](<#zset_static_extension-function-zscorerange>)

# Constants


```haxe
import github_com.arriqaaq.zset.Zset
```


```haxe
final skiplist_MAXLEVEL:stdgo.GoUInt64 = (("32" : GoUInt64))
```


|\* For 2^32 elements \*|/ 


```haxe
final skiplist_Probability:stdgo.GoFloat64 = ((0.25 : GoFloat64))
```


|\* Skiplist probability = 1/4 \*|/ 


# Functions


```haxe
import github_com.arriqaaq.zset.Zset
```


## function \_createNode


```haxe
function _createNode(_level:stdgo.GoInt, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


 


[\(view code\)](<./Zset.hx#L180>)


## function \_newZSkipList


```haxe
function _newZSkipList():stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>
```


 


[\(view code\)](<./Zset.hx#L193>)


## function \_randomLevel


```haxe
function _randomLevel():stdgo.GoInt
```


Returns a random level for the new skiplist node we are going to create. The return value of this function is between 1 and SKIPLIST\_MAXLEVEL \(both inclusive\), with a powerlaw\-alike distribution where higher levels are less likely to be returned. 


[\(view code\)](<./Zset.hx#L169>)


## function new\_


```haxe
function new_():stdgo.Ref<github_com.arriqaaq.zset.ZSet>
```


New create a new sorted set 


[\(view code\)](<./Zset.hx#L200>)


# Classes


```haxe
import github_com.arriqaaq.zset.*
```


## class T\_zset\_static\_extension


 


### T\_zset\_static\_extension function \_findRange


```haxe
function _findRange(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zset>, _key:stdgo.GoString, _start:stdgo.GoInt64, _stop:stdgo.GoInt64, _reverse:Bool, _withScores:Bool):stdgo.Slice<stdgo.AnyInterface>
```


 


[\(view code\)](<./Zset.hx#L1625>)


### T\_zset\_static\_extension function \_getNodeByRank


```haxe
function _getNodeByRank(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zset>, _key:stdgo.GoString, _rank:stdgo.GoInt64, _reverse:Bool):{_1:stdgo.GoFloat64, _0:stdgo.GoString}
```


 


[\(view code\)](<./Zset.hx#L1673>)


## class T\_zskiplist\_static\_extension


 


### T\_zskiplist\_static\_extension function \_delete


```haxe
function _delete(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _score:stdgo.GoFloat64, _member:stdgo.GoString):Void
```


|\* Delete an element with matching score/key from the skiplist. \*|/ 


[\(view code\)](<./Zset.hx#L1481>)


### T\_zskiplist\_static\_extension function \_deleteNode


```haxe
function _deleteNode(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _x:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>, _updates:stdgo.Slice<stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>>):Void
```


|\* Internal function used by delete, DeleteByScore and DeleteByRank \*|/ 


[\(view code\)](<./Zset.hx#L1506>)


### T\_zskiplist\_static\_extension function \_getNodeByRank


```haxe
function _getNodeByRank(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _rank:stdgo.GoUInt64):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


 


[\(view code\)](<./Zset.hx#L1434>)


### T\_zskiplist\_static\_extension function \_getRank


```haxe
function _getRank(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _score:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoInt64
```


Find the rank of the node specified by key Note that the rank is 0\-based integer. Rank 0 means the first node 


[\(view code\)](<./Zset.hx#L1457>)


### T\_zskiplist\_static\_extension function \_insert


```haxe
function _insert(_z:stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplist>, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


|\* Insert a new node in the skiplist. Assumes the element does not already exist \(up to the caller to enforce that\). The skiplist takes ownership of the passed member string. \*|/ 


[\(view code\)](<./Zset.hx#L1537>)


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


 


[\(view code\)](<./Zset.hx#L1374>)


### ZSet function keys


```haxe
function keys():stdgo.Slice<stdgo.GoString>
```


 


[\(view code\)](<./Zset.hx#L818>)


### ZSet function zadd


```haxe
function zadd( _key:stdgo.GoString, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.GoInt
```


ZAdd Adds the specified member with the specified score to the sorted set stored at key. Add an element into the sorted set with specific key / value / score. Time complexity of this method is : O\(log\(N\)\) 


[\(view code\)](<./Zset.hx#L1294>)


### ZSet function zcard


```haxe
function zcard( _key:stdgo.GoString):stdgo.GoInt
```


ZCard returns the sorted set cardinality \(number of elements\) of the sorted set stored at key. 


[\(view code\)](<./Zset.hx#L1261>)


### ZSet function zclear


```haxe
function zclear( _key:stdgo.GoString):Void
```


ZClear clear the key in zset. 


[\(view code\)](<./Zset.hx#L1073>)


### ZSet function zgetByRank


```haxe
function zgetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZGetByRank gets the member at key by rank, the rank is ordered from lowest to highest. The rank of lowest is 0 and so on. 


[\(view code\)](<./Zset.hx#L1004>)


### ZSet function zincrBy


```haxe
function zincrBy( _key:stdgo.GoString, _increment:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoFloat64
```


ZIncrBy increments the score of member in the sorted set stored at key by increment. If member does not exist in the sorted set, it is added with increment as its score \(as if its previous score was 0.0\). If key does not exist, a new sorted set with the specified member as its sole member is created. 


[\(view code\)](<./Zset.hx#L1194>)


### ZSet function zkeyExists


```haxe
function zkeyExists( _key:stdgo.GoString):Bool
```


ZKeyExists check if the key exists in zset. 


[\(view code\)](<./Zset.hx#L1084>)


### ZSet function zpopMax


```haxe
function zpopMax( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


get and remove the element with maximum score, nil if the set is empty 


[\(view code\)](<./Zset.hx#L951>)


### ZSet function zpopMin


```haxe
function zpopMin( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


get and remove the element with minimal score, nil if the set is empty 


[\(view code\)](<./Zset.hx#L968>)


### ZSet function zrange


```haxe
function zrange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRange returns the specified range of elements in the sorted set stored at \<key\>. 


[\(view code\)](<./Zset.hx#L1061>)


### ZSet function zrangeByScore


```haxe
function zrangeByScore( _key:stdgo.GoString, _start:stdgo.GoFloat64, _end:stdgo.GoFloat64, _options:stdgo.Ref<github_com.arriqaaq.zset.ZRangeOptions>):stdgo.Slice<stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>>
```


|\* Returns all the elements in the sorted set at key with a score between min and max \(including elements with score equal to min or max\). The elements are considered to be ordered from low to high scores.  If options is nil, it searchs in interval \[start, end\] without any limit by default  https://github.com/wangjia184/sortedset/blob/af6d6d227aa79e2a64b899d995ce18aa0bef437c/sortedset.go#L283 \*|/ 


[\(view code\)](<./Zset.hx#L839>)


### ZSet function zrangeWithScores


```haxe
function zrangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRangeWithScores returns the specified range of elements in the sorted set stored at \<key\>. 


[\(view code\)](<./Zset.hx#L1049>)


### ZSet function zrank


```haxe
function zrank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```


ZRank returns the rank of member in the sorted set stored at key, with the scores ordered from low to high. The rank \(or index\) is 0\-based, which means that the member with the lowest score has rank 0. 


[\(view code\)](<./Zset.hx#L1240>)


### ZSet function zrem


```haxe
function zrem( _key:stdgo.GoString, _member:stdgo.GoString):Bool
```


ZRem removes the specified members from the sorted set stored at key. Non existing members are ignored. An error is returned when key exists and does not hold a sorted set. 


[\(view code\)](<./Zset.hx#L1170>)


### ZSet function zrevGetByRank


```haxe
function zrevGetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevGetByRank get the member at key by rank, the rank is ordered from highest to lowest. The rank of highest is 0 and so on. 


[\(view code\)](<./Zset.hx#L986>)


### ZSet function zrevRange


```haxe
function zrevRange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevRange returns the specified range of elements in the sorted set stored at key. The elements are considered to be ordered from the highest to the lowest score. Descending lexicographical order is used for elements with equal score. 


[\(view code\)](<./Zset.hx#L1037>)


### ZSet function zrevRangeWithScores


```haxe
function zrevRangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevRange returns the specified range of elements in the sorted set stored at key. The elements are considered to be ordered from the highest to the lowest score. Descending lexicographical order is used for elements with equal score. 


[\(view code\)](<./Zset.hx#L1023>)


### ZSet function zrevRank


```haxe
function zrevRank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```


ZRevRank returns the rank of member in the sorted set stored at key, with the scores ordered from high to low. The rank \(or index\) is 0\-based, which means that the member with the highest score has rank 0. 


[\(view code\)](<./Zset.hx#L1219>)


### ZSet function zrevScoreRange


```haxe
function zrevScoreRange( _key:stdgo.GoString, _max:stdgo.GoFloat64, _min:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```


ZRevScoreRange returns all the elements in the sorted set at key with a score between max and min \(including elements with score equal to max or min\). In contrary to the default ordering of sorted sets, for this command the elements are considered to be ordered from high to low scores. 


[\(view code\)](<./Zset.hx#L1093>)


### ZSet function zscore


```haxe
function zscore( _key:stdgo.GoString, _member:stdgo.GoString):{_1:stdgo.GoFloat64, _0:Bool}
```


ZScore returns the score of member in the sorted set at key. 


[\(view code\)](<./Zset.hx#L1272>)


### ZSet function zscoreRange


```haxe
function zscoreRange( _key:stdgo.GoString, _min:stdgo.GoFloat64, _max:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```


ZScoreRange returns all the elements in the sorted set at key with a score between min and max \(including elements with score equal to min or max\). The elements are considered to be ordered from low to high scores. 


[\(view code\)](<./Zset.hx#L1131>)


## class ZSet\_static\_extension


 


### ZSet\_static\_extension function \_exist


```haxe
function _exist( _key:stdgo.GoString):Bool
```


 


[\(view code\)](<./Zset.hx#L1374>)


### ZSet\_static\_extension function keys


```haxe
function keys():stdgo.Slice<stdgo.GoString>
```


 


[\(view code\)](<./Zset.hx#L818>)


### ZSet\_static\_extension function zadd


```haxe
function zadd( _key:stdgo.GoString, _score:stdgo.GoFloat64, _member:stdgo.GoString, _value:stdgo.AnyInterface):stdgo.GoInt
```


ZAdd Adds the specified member with the specified score to the sorted set stored at key. Add an element into the sorted set with specific key / value / score. Time complexity of this method is : O\(log\(N\)\) 


[\(view code\)](<./Zset.hx#L1294>)


### ZSet\_static\_extension function zcard


```haxe
function zcard( _key:stdgo.GoString):stdgo.GoInt
```


ZCard returns the sorted set cardinality \(number of elements\) of the sorted set stored at key. 


[\(view code\)](<./Zset.hx#L1261>)


### ZSet\_static\_extension function zclear


```haxe
function zclear( _key:stdgo.GoString):Void
```


ZClear clear the key in zset. 


[\(view code\)](<./Zset.hx#L1073>)


### ZSet\_static\_extension function zgetByRank


```haxe
function zgetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZGetByRank gets the member at key by rank, the rank is ordered from lowest to highest. The rank of lowest is 0 and so on. 


[\(view code\)](<./Zset.hx#L1004>)


### ZSet\_static\_extension function zincrBy


```haxe
function zincrBy( _key:stdgo.GoString, _increment:stdgo.GoFloat64, _member:stdgo.GoString):stdgo.GoFloat64
```


ZIncrBy increments the score of member in the sorted set stored at key by increment. If member does not exist in the sorted set, it is added with increment as its score \(as if its previous score was 0.0\). If key does not exist, a new sorted set with the specified member as its sole member is created. 


[\(view code\)](<./Zset.hx#L1194>)


### ZSet\_static\_extension function zkeyExists


```haxe
function zkeyExists( _key:stdgo.GoString):Bool
```


ZKeyExists check if the key exists in zset. 


[\(view code\)](<./Zset.hx#L1084>)


### ZSet\_static\_extension function zpopMax


```haxe
function zpopMax( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


get and remove the element with maximum score, nil if the set is empty 


[\(view code\)](<./Zset.hx#L951>)


### ZSet\_static\_extension function zpopMin


```haxe
function zpopMin( _key:stdgo.GoString):stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>
```


get and remove the element with minimal score, nil if the set is empty 


[\(view code\)](<./Zset.hx#L968>)


### ZSet\_static\_extension function zrange


```haxe
function zrange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRange returns the specified range of elements in the sorted set stored at \<key\>. 


[\(view code\)](<./Zset.hx#L1061>)


### ZSet\_static\_extension function zrangeByScore


```haxe
function zrangeByScore( _key:stdgo.GoString, _start:stdgo.GoFloat64, _end:stdgo.GoFloat64, _options:stdgo.Ref<github_com.arriqaaq.zset.ZRangeOptions>):stdgo.Slice<stdgo.Ref<github_com.arriqaaq.zset._Zset.T_zskiplistNode>>
```


|\* Returns all the elements in the sorted set at key with a score between min and max \(including elements with score equal to min or max\). The elements are considered to be ordered from low to high scores.  If options is nil, it searchs in interval \[start, end\] without any limit by default  https://github.com/wangjia184/sortedset/blob/af6d6d227aa79e2a64b899d995ce18aa0bef437c/sortedset.go#L283 \*|/ 


[\(view code\)](<./Zset.hx#L839>)


### ZSet\_static\_extension function zrangeWithScores


```haxe
function zrangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRangeWithScores returns the specified range of elements in the sorted set stored at \<key\>. 


[\(view code\)](<./Zset.hx#L1049>)


### ZSet\_static\_extension function zrank


```haxe
function zrank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```


ZRank returns the rank of member in the sorted set stored at key, with the scores ordered from low to high. The rank \(or index\) is 0\-based, which means that the member with the lowest score has rank 0. 


[\(view code\)](<./Zset.hx#L1240>)


### ZSet\_static\_extension function zrem


```haxe
function zrem( _key:stdgo.GoString, _member:stdgo.GoString):Bool
```


ZRem removes the specified members from the sorted set stored at key. Non existing members are ignored. An error is returned when key exists and does not hold a sorted set. 


[\(view code\)](<./Zset.hx#L1170>)


### ZSet\_static\_extension function zrevGetByRank


```haxe
function zrevGetByRank( _key:stdgo.GoString, _rank:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevGetByRank get the member at key by rank, the rank is ordered from highest to lowest. The rank of highest is 0 and so on. 


[\(view code\)](<./Zset.hx#L986>)


### ZSet\_static\_extension function zrevRange


```haxe
function zrevRange( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevRange returns the specified range of elements in the sorted set stored at key. The elements are considered to be ordered from the highest to the lowest score. Descending lexicographical order is used for elements with equal score. 


[\(view code\)](<./Zset.hx#L1037>)


### ZSet\_static\_extension function zrevRangeWithScores


```haxe
function zrevRangeWithScores( _key:stdgo.GoString, _start:stdgo.GoInt, _stop:stdgo.GoInt):stdgo.Slice<stdgo.AnyInterface>
```


ZRevRange returns the specified range of elements in the sorted set stored at key. The elements are considered to be ordered from the highest to the lowest score. Descending lexicographical order is used for elements with equal score. 


[\(view code\)](<./Zset.hx#L1023>)


### ZSet\_static\_extension function zrevRank


```haxe
function zrevRank( _key:stdgo.GoString, _member:stdgo.GoString):stdgo.GoInt64
```


ZRevRank returns the rank of member in the sorted set stored at key, with the scores ordered from high to low. The rank \(or index\) is 0\-based, which means that the member with the highest score has rank 0. 


[\(view code\)](<./Zset.hx#L1219>)


### ZSet\_static\_extension function zrevScoreRange


```haxe
function zrevScoreRange( _key:stdgo.GoString, _max:stdgo.GoFloat64, _min:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```


ZRevScoreRange returns all the elements in the sorted set at key with a score between max and min \(including elements with score equal to max or min\). In contrary to the default ordering of sorted sets, for this command the elements are considered to be ordered from high to low scores. 


[\(view code\)](<./Zset.hx#L1093>)


### ZSet\_static\_extension function zscore


```haxe
function zscore( _key:stdgo.GoString, _member:stdgo.GoString):{_1:stdgo.GoFloat64, _0:Bool}
```


ZScore returns the score of member in the sorted set at key. 


[\(view code\)](<./Zset.hx#L1272>)


### ZSet\_static\_extension function zscoreRange


```haxe
function zscoreRange( _key:stdgo.GoString, _min:stdgo.GoFloat64, _max:stdgo.GoFloat64):stdgo.Slice<stdgo.AnyInterface>
```


ZScoreRange returns all the elements in the sorted set at key with a score between min and max \(including elements with score equal to min or max\). The elements are considered to be ordered from low to high scores. 


[\(view code\)](<./Zset.hx#L1131>)


