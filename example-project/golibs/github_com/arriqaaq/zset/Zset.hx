package github_com.arriqaaq.zset;

import stdgo.StdGoTypes;
import stdgo.Error;
import stdgo.Go;
import stdgo.GoString;
import stdgo.Pointer;
import stdgo.Slice;
import stdgo.GoArray;
import stdgo.GoMap;
import stdgo.Chan;

/**
	/|* For 2^32 elements *|/
**/
final skiplist_MAXLEVEL:GoUnTypedInt = (32 : GoUnTypedInt);

/**
	/|* Skiplist probability = 1/4 *|/
**/
final skiplist_Probability:GoUnTypedFloat = (0.25 : GoUnTypedFloat);

@:structInit @:using(github_com.arriqaaq.zset.Zset.ZSet_static_extension) class ZSet {
	public var _records:GoMap<GoString, Ref<T_zset>> = (null : GoMap<GoString, Ref<T_zset>>);

	public function new(?_records:GoMap<GoString, Ref<T_zset>>) {
		if (_records != null)
			this._records = _records;
	}

	public function __underlying__():AnyInterface
		return Go.toInterface(this);

	public function __copy__() {
		return new ZSet(_records);
	}
}

@:structInit private class T_zskiplistLevel {
	public var _forward:Ref<T_zskiplistNode> = (null : T_zskiplistNode);
	public var _span:GoUInt64 = 0;

	public function new(?_forward:Ref<T_zskiplistNode>, ?_span:GoUInt64) {
		if (_forward != null)
			this._forward = _forward;
		if (_span != null)
			this._span = _span;
	}

	public function __underlying__():AnyInterface
		return Go.toInterface(this);

	public function __copy__() {
		return new T_zskiplistLevel(_forward, _span);
	}
}

@:structInit private class T_zskiplistNode {
	public var _member:GoString = "";
	public var _value:AnyInterface = (null : AnyInterface);
	public var _score:GoFloat64 = 0;
	public var _backward:Ref<T_zskiplistNode> = (null : T_zskiplistNode);
	public var _level:Slice<Ref<T_zskiplistLevel>> = (null : Slice<Ref<T_zskiplistLevel>>);

	public function new(?_member:GoString, ?_value:AnyInterface, ?_score:GoFloat64, ?_backward:Ref<T_zskiplistNode>, ?_level:Slice<Ref<T_zskiplistLevel>>) {
		if (_member != null)
			this._member = _member;
		if (_value != null)
			this._value = _value;
		if (_score != null)
			this._score = _score;
		if (_backward != null)
			this._backward = _backward;
		if (_level != null)
			this._level = _level;
	}

	public function __underlying__():AnyInterface
		return Go.toInterface(this);

	public function __copy__() {
		return new T_zskiplistNode(_member, _value, _score, _backward, _level);
	}
}

@:structInit @:using(github_com.arriqaaq.zset.Zset.T_zskiplist_static_extension) private class T_zskiplist {
	public var _head:Ref<T_zskiplistNode> = (null : T_zskiplistNode);
	public var _tail:Ref<T_zskiplistNode> = (null : T_zskiplistNode);
	public var _length:GoInt64 = 0;
	public var _level:GoInt = 0;

	public function new(?_head:Ref<T_zskiplistNode>, ?_tail:Ref<T_zskiplistNode>, ?_length:GoInt64, ?_level:GoInt) {
		if (_head != null)
			this._head = _head;
		if (_tail != null)
			this._tail = _tail;
		if (_length != null)
			this._length = _length;
		if (_level != null)
			this._level = _level;
	}

	public function __underlying__():AnyInterface
		return Go.toInterface(this);

	public function __copy__() {
		return new T_zskiplist(_head, _tail, _length, _level);
	}
}

@:structInit @:using(github_com.arriqaaq.zset.Zset.T_zset_static_extension) private class T_zset {
	public var _dict:GoMap<GoString, Ref<T_zskiplistNode>> = (null : GoMap<GoString, Ref<T_zskiplistNode>>);
	public var _zsl:Ref<T_zskiplist> = (null : T_zskiplist);

	public function new(?_dict:GoMap<GoString, Ref<T_zskiplistNode>>, ?_zsl:Ref<T_zskiplist>) {
		if (_dict != null)
			this._dict = _dict;
		if (_zsl != null)
			this._zsl = _zsl;
	}

	public function __underlying__():AnyInterface
		return Go.toInterface(this);

	public function __copy__() {
		return new T_zset(_dict, _zsl);
	}
}

@:structInit class ZRangeOptions {
	/**
		// limit the max nodes to return
	**/
	public var limit:GoInt = 0;

	/**
		// exclude start value, so it search in interval (start, end] or (start, end)
	**/
	public var excludeStart:Bool = false;

	/**
		// exclude end value, so it search in interval [start, end) or (start, end)
	**/
	public var excludeEnd:Bool = false;

	public function new(?limit:GoInt, ?excludeStart:Bool, ?excludeEnd:Bool) {
		if (limit != null)
			this.limit = limit;
		if (excludeStart != null)
			this.excludeStart = excludeStart;
		if (excludeEnd != null)
			this.excludeEnd = excludeEnd;
	}

	public function __underlying__():AnyInterface
		return Go.toInterface(this);

	public function __copy__() {
		return new ZRangeOptions(limit, excludeStart, excludeEnd);
	}
}

/**
	// Returns a random level for the new skiplist node we are going to create.
	// The return value of this function is between 1 and SKIPLIST_MAXLEVEL
	// (both inclusive), with a powerlaw-alike distribution where higher
	// levels are less likely to be returned.
**/
function _randomLevel():GoInt {
	var _level:GoInt = (1 : GoInt);
	while ((stdgo.math.rand.Rand.int31() & (65535 : GoInt32):GoFloat64) < (16383.75 : GoFloat64)) {
		_level = _level + ((1 : GoInt));
	};
	if (_level < (32:GoInt)) {
		return _level;
	};
	return (32 : GoInt);
}

function _createNode(_level:GoInt, _score:GoFloat64, _member:GoString, _value:AnyInterface):Ref<T_zskiplistNode> {
	var _node = ({
		_score: _score,
		_member: _member,
		_value: _value,
		_level: new Slice<Ref<T_zskiplistLevel>>((_level : GoInt).toBasic(), 0, ...[for (i in 0...(_level : GoInt).toBasic()) (null : T_zskiplistLevel)])
	} : T_zskiplistNode);
	for (_i => _ in _node._level) {
		_node._level[_i] = ({} : T_zskiplistLevel);
	};
	return _node;
}

function _newZSkipList():Ref<T_zskiplist> {
	return ({_level: (1 : GoInt), _head: _createNode((32 : GoInt), (0 : GoFloat64), (Go.str() : GoString), (null : AnyInterface))} : T_zskiplist);
}

/**
	// New create a new sorted set
**/
function new_():Ref<ZSet> {
	return (new ZSet((new GoObjectMap<GoString,
		Ref<T_zset>>(new stdgo.reflect.Reflect._Type(stdgo.reflect.Reflect.GoType.mapType(stdgo.reflect.Reflect.GoType.basic(string_kind),
		stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zset", [], stdgo.reflect.Reflect.GoType.structType([
			{
				name: "_dict",
				embedded: false,
				tag: "",
				type: stdgo.reflect.Reflect.GoType.mapType(stdgo.reflect.Reflect.GoType.basic(string_kind),
					stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [], stdgo.reflect.Reflect.GoType.structType([
						{
							name: "_member",
							embedded: false,
							tag: "",
							type: stdgo.reflect.Reflect.GoType.basic(string_kind)
						},
						{
							name: "_value",
							embedded: false,
							tag: "",
							type: stdgo.reflect.Reflect.GoType.interfaceType(true, [])
						},
						{
							name: "_score",
							embedded: false,
							tag: "",
							type: stdgo.reflect.Reflect.GoType.basic(float64_kind)
						},
						{
							name: "_backward",
							embedded: false,
							tag: "",
							type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
								stdgo.reflect.Reflect.GoType.invalidType))
						},
						{
							name: "_level",
							embedded: false,
							tag: "",
							type: stdgo.reflect.Reflect.GoType.sliceType(stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistLevel",
									[], stdgo.reflect.Reflect.GoType.structType([
								{
									name: "_forward",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
										stdgo.reflect.Reflect.GoType.invalidType))
								},
								{
									name: "_span",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.basic(uint64_kind)
								}
							]))))
						}
					]))))
			},
			{
				name: "_zsl",
				embedded: false,
				tag: "",
				type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplist", [], stdgo.reflect.Reflect.GoType.structType([
					{
						name: "_head",
						embedded: false,
						tag: "",
						type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
							stdgo.reflect.Reflect.GoType.structType([
								{
									name: "_member",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.basic(string_kind)
								},
								{
									name: "_value",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.interfaceType(true, [])
								},
								{
									name: "_score",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.basic(float64_kind)
								},
								{
									name: "_backward",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
										stdgo.reflect.Reflect.GoType.invalidType))
								},
								{
									name: "_level",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.sliceType(stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistLevel",
											[], stdgo.reflect.Reflect.GoType.structType([
										{
											name: "_forward",
											embedded: false,
											tag: "",
											type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
												stdgo.reflect.Reflect.GoType.invalidType))
										},
										{
											name: "_span",
											embedded: false,
											tag: "",
											type: stdgo.reflect.Reflect.GoType.basic(uint64_kind)
										}
									]))))
								}
							])))
					},
					{
						name: "_tail",
						embedded: false,
						tag: "",
						type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
							stdgo.reflect.Reflect.GoType.structType([
								{
									name: "_member",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.basic(string_kind)
								},
								{
									name: "_value",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.interfaceType(true, [])
								},
								{
									name: "_score",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.basic(float64_kind)
								},
								{
									name: "_backward",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
										stdgo.reflect.Reflect.GoType.invalidType))
								},
								{
									name: "_level",
									embedded: false,
									tag: "",
									type: stdgo.reflect.Reflect.GoType.sliceType(stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistLevel",
											[], stdgo.reflect.Reflect.GoType.structType([
										{
											name: "_forward",
											embedded: false,
											tag: "",
											type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
												stdgo.reflect.Reflect.GoType.invalidType))
										},
										{
											name: "_span",
											embedded: false,
											tag: "",
											type: stdgo.reflect.Reflect.GoType.basic(uint64_kind)
										}
									]))))
								}
							])))
					},
					{
						name: "_length",
						embedded: false,
						tag: "",
						type: stdgo.reflect.Reflect.GoType.basic(int64_kind)
					},
					{
						name: "_level",
						embedded: false,
						tag: "",
						type: stdgo.reflect.Reflect.GoType.basic(int_kind)
					}
				])))
			}
		])))))) : GoMap<GoString, Ref<T_zset>>)) : ZSet);
}

class ZSet_asInterface {
	@:keep
	public function keys():Slice<GoString>
		return __self__.keys();

	/**
		/|*
			Returns all the elements in the sorted set at key with a score between min and max (including
			elements with score equal to min or max). The elements are considered to be ordered from low to
			high scores.

			If options is nil, it searchs in interval [start, end] without any limit by default

			https://github.com/wangjia184/sortedset/blob/af6d6d227aa79e2a64b899d995ce18aa0bef437c/sortedset.go#L283
		*|/
	**/
	@:keep
	public function zrangeByScore(_key:GoString, _start:GoFloat64, _end:GoFloat64, _options:Ref<ZRangeOptions>):Slice<Ref<T_zskiplistNode>>
		return __self__.zrangeByScore(_key, _start, _end, _options);

	/**
		// get and remove the element with maximum score, nil if the set is empty
	**/
	@:keep
	public function zpopMax(_key:GoString):Ref<T_zskiplistNode>
		return __self__.zpopMax(_key);

	/**
		// get and remove the element with minimal score, nil if the set is empty
	**/
	@:keep
	public function zpopMin(_key:GoString):Ref<T_zskiplistNode>
		return __self__.zpopMin(_key);

	/**
		// ZRevGetByRank get the member at key by rank, the rank is ordered from highest to lowest.
		// The rank of highest is 0 and so on.
	**/
	@:keep
	public function zrevGetByRank(_key:GoString, _rank:GoInt):Slice<AnyInterface>
		return __self__.zrevGetByRank(_key, _rank);

	/**
		// ZGetByRank gets the member at key by rank, the rank is ordered from lowest to highest.
		// The rank of lowest is 0 and so on.
	**/
	@:keep
	public function zgetByRank(_key:GoString, _rank:GoInt):Slice<AnyInterface>
		return __self__.zgetByRank(_key, _rank);

	/**
		// ZRevRange returns the specified range of elements in the sorted set stored at key.
		// The elements are considered to be ordered from the highest to the lowest score.
		// Descending lexicographical order is used for elements with equal score.
	**/
	@:keep
	public function zrevRangeWithScores(_key:GoString, _start:GoInt, _stop:GoInt):Slice<AnyInterface>
		return __self__.zrevRangeWithScores(_key, _start, _stop);

	/**
		// ZRevRange returns the specified range of elements in the sorted set stored at key.
		// The elements are considered to be ordered from the highest to the lowest score.
		// Descending lexicographical order is used for elements with equal score.
	**/
	@:keep
	public function zrevRange(_key:GoString, _start:GoInt, _stop:GoInt):Slice<AnyInterface>
		return __self__.zrevRange(_key, _start, _stop);

	/**
		// ZRangeWithScores returns the specified range of elements in the sorted set stored at <key>.
	**/
	@:keep
	public function zrangeWithScores(_key:GoString, _start:GoInt, _stop:GoInt):Slice<AnyInterface>
		return __self__.zrangeWithScores(_key, _start, _stop);

	/**
		// ZRange returns the specified range of elements in the sorted set stored at <key>.
	**/
	@:keep
	public function zrange(_key:GoString, _start:GoInt, _stop:GoInt):Slice<AnyInterface>
		return __self__.zrange(_key, _start, _stop);

	/**
		// ZClear clear the key in zset.
	**/
	@:keep
	public function zclear(_key:GoString):Void
		__self__.zclear(_key);

	/**
		// ZKeyExists check if the key exists in zset.
	**/
	@:keep
	public function zkeyExists(_key:GoString):Bool
		return __self__.zkeyExists(_key);

	/**
		// ZRevScoreRange returns all the elements in the sorted set at key with a score between max and min (including elements with score equal to max or min).
		// In contrary to the default ordering of sorted sets, for this command the elements are considered to be ordered from high to low scores.
	**/
	@:keep
	public function zrevScoreRange(_key:GoString, _max:GoFloat64, _min:GoFloat64):Slice<AnyInterface>
		return __self__.zrevScoreRange(_key, _max, _min);

	/**
		// ZScoreRange returns all the elements in the sorted set at key with a score between min and max (including elements with score equal to min or max).
		// The elements are considered to be ordered from low to high scores.
	**/
	@:keep
	public function zscoreRange(_key:GoString, _min:GoFloat64, _max:GoFloat64):Slice<AnyInterface>
		return __self__.zscoreRange(_key, _min, _max);

	/**
		// ZRem removes the specified members from the sorted set stored at key. Non existing members are ignored.
		// An error is returned when key exists and does not hold a sorted set.
	**/
	@:keep
	public function zrem(_key:GoString, _member:GoString):Bool
		return __self__.zrem(_key, _member);

	/**
		// ZIncrBy increments the score of member in the sorted set stored at key by increment.
		// If member does not exist in the sorted set, it is added with increment as its score (as if its previous score was 0.0).
		// If key does not exist, a new sorted set with the specified member as its sole member is created.
	**/
	@:keep
	public function zincrBy(_key:GoString, _increment:GoFloat64, _member:GoString):GoFloat64
		return __self__.zincrBy(_key, _increment, _member);

	/**
		// ZRevRank returns the rank of member in the sorted set stored at key, with the scores ordered from high to low.
		// The rank (or index) is 0-based, which means that the member with the highest score has rank 0.
	**/
	@:keep
	public function zrevRank(_key:GoString, _member:GoString):GoInt64
		return __self__.zrevRank(_key, _member);

	/**
		// ZRank returns the rank of member in the sorted set stored at key, with the scores ordered from low to high.
		// The rank (or index) is 0-based, which means that the member with the lowest score has rank 0.
	**/
	@:keep
	public function zrank(_key:GoString, _member:GoString):GoInt64
		return __self__.zrank(_key, _member);

	/**
		// ZCard returns the sorted set cardinality (number of elements) of the sorted set stored at key.
	**/
	@:keep
	public function zcard(_key:GoString):GoInt
		return __self__.zcard(_key);

	/**
		// ZScore returns the score of member in the sorted set at key.
	**/
	@:keep
	public function zscore(_key:GoString, _member:GoString):{var _0:Bool; var _1:GoFloat64;}
		return __self__.zscore(_key, _member);

	/**
		// ZAdd Adds the specified member with the specified score to the sorted set stored at key.
		// Add an element into the sorted set with specific key / value / score.
		// Time complexity of this method is : O(log(N))
	**/
	@:keep
	public function zadd(_key:GoString, _score:GoFloat64, _member:GoString, _value:AnyInterface):GoInt
		return __self__.zadd(_key, _score, _member, _value);

	@:keep
	public function _exist(_key:GoString):Bool
		return __self__._exist(_key);

	public function new(?__self__) {
		if (__self__ != null)
			this.__self__ = __self__;
	}

	public function __underlying__()
		return Go.toInterface(__self__);

	var __self__:ZSet;
}

@:keep private class ZSet_static_extension {
	@:keep
	static public function keys(_z:Ref<ZSet>):Slice<GoString> {
		var _keys = new Slice<GoString>((0 : GoInt).toBasic(), (_z._records.length), ...[for (i in 0...(0 : GoInt).toBasic()) ("" : GoString)]);
		for (_k => _ in _z._records) {
			_keys = (_keys.__append__(_k));
		};
		return _keys;
	}

	/**
		/|*
			Returns all the elements in the sorted set at key with a score between min and max (including
			elements with score equal to min or max). The elements are considered to be ordered from low to
			high scores.

			If options is nil, it searchs in interval [start, end] without any limit by default

			https://github.com/wangjia184/sortedset/blob/af6d6d227aa79e2a64b899d995ce18aa0bef437c/sortedset.go#L283
		*|/
	**/
	@:keep
	static public function zrangeByScore(_z:Ref<ZSet>, _key:GoString, _start:GoFloat64, _end:GoFloat64,
			_options:Ref<ZRangeOptions>):Slice<Ref<T_zskiplistNode>> {
		var _nodes:Slice<Ref<T_zskiplistNode>> = (null : Slice<Ref<T_zskiplistNode>>);
		if (!_z._exist(_key)) {
			return _nodes;
		};
		var _n = _z._records[_key];
		var _zsl = _n._zsl;
		var _limit:GoInt = ((2147483647 : GoUInt) : GoInt);
		if ((_options != null) && (_options.limit > (0 : GoInt))) {
			_limit = _options.limit;
		};
		var _excludeStart:Bool = (_options != null) && _options.excludeStart;
		var _excludeEnd:Bool = (_options != null) && _options.excludeEnd;
		var _reverse:Bool = _start > _end;
		if (_reverse) {
			{
				final __tmp__0 = _end;
				final __tmp__1 = _start;
				_start = __tmp__0;
				_end = __tmp__1;
			};
			{
				final __tmp__0 = _excludeEnd;
				final __tmp__1 = _excludeStart;
				_excludeStart = __tmp__0;
				_excludeEnd = __tmp__1;
			};
		};
		if (_zsl._length == (0 : GoInt64)) {
			return _nodes;
		};
		if (_reverse) {
			var _x = _zsl._head;
			if (_excludeEnd) {
				{
					var _i:GoInt = _zsl._level - (1 : GoInt);
					Go.cfor(_i >= (0 : GoInt), _i--, {
						while ((_x._level[_i]._forward != null) && (_x._level[_i]._forward._score < _end)) {
							_x = _x._level[_i]._forward;
						};
					});
				};
			} else {
				{
					var _i:GoInt = _zsl._level - (1 : GoInt);
					Go.cfor(_i >= (0 : GoInt), _i--, {
						while ((_x._level[_i]._forward != null) && (_x._level[_i]._forward._score <= _end)) {
							_x = _x._level[_i]._forward;
						};
					});
				};
			};
			while ((_x != null) && (_limit > (0 : GoInt))) {
				if (_excludeStart) {
					if (_x._score <= _start) {
						break;
					};
				} else {
					if (_x._score < _start) {
						break;
					};
				};
				var _next = _x._backward;
				_nodes = (_nodes.__append__(_x));
				_limit--;
				_x = _next;
			};
		} else {
			var _x = _zsl._head;
			if (_excludeStart) {
				{
					var _i:GoInt = _zsl._level - (1 : GoInt);
					Go.cfor(_i >= (0 : GoInt), _i--, {
						while ((_x._level[_i]._forward != null) && (_x._level[_i]._forward._score <= _start)) {
							_x = _x._level[_i]._forward;
						};
					});
				};
			} else {
				{
					var _i:GoInt = _zsl._level - (1 : GoInt);
					Go.cfor(_i >= (0 : GoInt), _i--, {
						while ((_x._level[_i]._forward != null) && (_x._level[_i]._forward._score < _start)) {
							_x = _x._level[_i]._forward;
						};
					});
				};
			};
			_x = _x._level[(0 : GoInt)]._forward;
			while ((_x != null) && (_limit > (0 : GoInt))) {
				if (_excludeEnd) {
					if (_x._score >= _end) {
						break;
					};
				} else {
					if (_x._score > _end) {
						break;
					};
				};
				var _next = _x._level[(0 : GoInt)]._forward;
				_nodes = (_nodes.__append__(_x));
				_limit--;
				_x = _next;
			};
		};
		return _nodes;
	}

	/**
		// get and remove the element with maximum score, nil if the set is empty
	**/
	@:keep
	static public function zpopMax(_z:Ref<ZSet>, _key:GoString):Ref<T_zskiplistNode> {
		var _rec:Ref<T_zskiplistNode> = (null : T_zskiplistNode);
		if (!_z._exist(_key)) {
			return _rec;
		};
		var _n = _z._records[_key];
		var _x = _n._zsl._tail;
		if (_x != null) {
			_z.zrem(_key, _x._member);
		};
		return _x;
	}

	/**
		// get and remove the element with minimal score, nil if the set is empty
	**/
	@:keep
	static public function zpopMin(_z:Ref<ZSet>, _key:GoString):Ref<T_zskiplistNode> {
		var _rec:Ref<T_zskiplistNode> = (null : T_zskiplistNode);
		if (!_z._exist(_key)) {
			return _rec;
		};
		var _n = _z._records[_key];
		var _x = _n._zsl._head._level[(0 : GoInt)]._forward;
		if (_x != null) {
			_z.zrem(_key, _x._member);
		};
		return _x;
	}

	/**
		// ZRevGetByRank get the member at key by rank, the rank is ordered from highest to lowest.
		// The rank of highest is 0 and so on.
	**/
	@:keep
	static public function zrevGetByRank(_z:Ref<ZSet>, _key:GoString, _rank:GoInt):Slice<AnyInterface> {
		var _val:Slice<AnyInterface> = (null : Slice<AnyInterface>);
		if (!_z._exist(_key)) {
			return _val;
		};
		var _n = _z._records[_key];
		var __tmp__ = _n._getNodeByRank(_key, (_rank : GoInt64), true),
			_member:GoString = __tmp__._0,
			_score:GoFloat64 = __tmp__._1;
		_val = (_val.__append__(Go.toInterface(_member), Go.toInterface(_score)));
		return _val;
	}

	/**
		// ZGetByRank gets the member at key by rank, the rank is ordered from lowest to highest.
		// The rank of lowest is 0 and so on.
	**/
	@:keep
	static public function zgetByRank(_z:Ref<ZSet>, _key:GoString, _rank:GoInt):Slice<AnyInterface> {
		var _val:Slice<AnyInterface> = (null : Slice<AnyInterface>);
		if (!_z._exist(_key)) {
			return _val;
		};
		var _n = _z._records[_key];
		var __tmp__ = _n._getNodeByRank(_key, (_rank : GoInt64), false),
			_member:GoString = __tmp__._0,
			_score:GoFloat64 = __tmp__._1;
		_val = (_val.__append__(Go.toInterface(_member), Go.toInterface(_score)));
		return _val;
	}

	/**
		// ZRevRange returns the specified range of elements in the sorted set stored at key.
		// The elements are considered to be ordered from the highest to the lowest score.
		// Descending lexicographical order is used for elements with equal score.
	**/
	@:keep
	static public function zrevRangeWithScores(_z:Ref<ZSet>, _key:GoString, _start:GoInt, _stop:GoInt):Slice<AnyInterface> {
		if (!_z._exist(_key)) {
			return (null : Slice<AnyInterface>);
		};
		var _n = _z._records[_key];
		return _n._findRange(_key, (_start : GoInt64), (_stop : GoInt64), true, true);
	}

	/**
		// ZRevRange returns the specified range of elements in the sorted set stored at key.
		// The elements are considered to be ordered from the highest to the lowest score.
		// Descending lexicographical order is used for elements with equal score.
	**/
	@:keep
	static public function zrevRange(_z:Ref<ZSet>, _key:GoString, _start:GoInt, _stop:GoInt):Slice<AnyInterface> {
		if (!_z._exist(_key)) {
			return (null : Slice<AnyInterface>);
		};
		var _n = _z._records[_key];
		return _n._findRange(_key, (_start : GoInt64), (_stop : GoInt64), true, false);
	}

	/**
		// ZRangeWithScores returns the specified range of elements in the sorted set stored at <key>.
	**/
	@:keep
	static public function zrangeWithScores(_z:Ref<ZSet>, _key:GoString, _start:GoInt, _stop:GoInt):Slice<AnyInterface> {
		if (!_z._exist(_key)) {
			return (null : Slice<AnyInterface>);
		};
		var _n = _z._records[_key];
		return _n._findRange(_key, (_start : GoInt64), (_stop : GoInt64), false, true);
	}

	/**
		// ZRange returns the specified range of elements in the sorted set stored at <key>.
	**/
	@:keep
	static public function zrange(_z:Ref<ZSet>, _key:GoString, _start:GoInt, _stop:GoInt):Slice<AnyInterface> {
		if (!_z._exist(_key)) {
			return (null : Slice<AnyInterface>);
		};
		var _n = _z._records[_key];
		return _n._findRange(_key, (_start : GoInt64), (_stop : GoInt64), false, false);
	}

	/**
		// ZClear clear the key in zset.
	**/
	@:keep
	static public function zclear(_z:Ref<ZSet>, _key:GoString):Void {
		if (_z.zkeyExists(_key)) {
			if (_z._records != null)
				_z._records.__remove__(_key);
		};
	}

	/**
		// ZKeyExists check if the key exists in zset.
	**/
	@:keep
	static public function zkeyExists(_z:Ref<ZSet>, _key:GoString):Bool {
		return _z._exist(_key);
	}

	/**
		// ZRevScoreRange returns all the elements in the sorted set at key with a score between max and min (including elements with score equal to max or min).
		// In contrary to the default ordering of sorted sets, for this command the elements are considered to be ordered from high to low scores.
	**/
	@:keep
	static public function zrevScoreRange(_z:Ref<ZSet>, _key:GoString, _max:GoFloat64, _min:GoFloat64):Slice<AnyInterface> {
		var _val:Slice<AnyInterface> = (null : Slice<AnyInterface>);
		if (!_z._exist(_key) || (_max < _min)) {
			return _val;
		};
		var _item = _z._records[_key]._zsl;
		var _minScore:GoFloat64 = _item._head._level[(0 : GoInt)]._forward._score;
		if (_min < _minScore) {
			_min = _minScore;
		};
		var _maxScore:GoFloat64 = _item._tail._score;
		if (_max > _maxScore) {
			_max = _maxScore;
		};
		var _x = _item._head;
		{
			var _i:GoInt = _item._level - (1 : GoInt);
			Go.cfor(_i >= (0 : GoInt), _i--, {
				while ((_x._level[_i]._forward != null) && (_x._level[_i]._forward._score <= _max)) {
					_x = _x._level[_i]._forward;
				};
			});
		};
		while (_x != null) {
			if (_x._score < _min) {
				break;
			};
			_val = (_val.__append__(Go.toInterface(_x._member), Go.toInterface(_x._score)));
			_x = _x._backward;
		};
		return _val;
	}

	/**
		// ZScoreRange returns all the elements in the sorted set at key with a score between min and max (including elements with score equal to min or max).
		// The elements are considered to be ordered from low to high scores.
	**/
	@:keep
	static public function zscoreRange(_z:Ref<ZSet>, _key:GoString, _min:GoFloat64, _max:GoFloat64):Slice<AnyInterface> {
		var _val:Slice<AnyInterface> = (null : Slice<AnyInterface>);
		if (!_z._exist(_key) || (_min > _max)) {
			return _val;
		};
		var _item = _z._records[_key]._zsl;
		var _minScore:GoFloat64 = _item._head._level[(0 : GoInt)]._forward._score;
		if (_min < _minScore) {
			_min = _minScore;
		};
		var _maxScore:GoFloat64 = _item._tail._score;
		if (_max > _maxScore) {
			_max = _maxScore;
		};
		var _x = _item._head;
		{
			var _i:GoInt = _item._level - (1 : GoInt);
			Go.cfor(_i >= (0 : GoInt), _i--, {
				while ((_x._level[_i]._forward != null) && (_x._level[_i]._forward._score < _min)) {
					_x = _x._level[_i]._forward;
				};
			});
		};
		_x = _x._level[(0 : GoInt)]._forward;
		while (_x != null) {
			if (_x._score > _max) {
				break;
			};
			_val = (_val.__append__(Go.toInterface(_x._member), Go.toInterface(_x._score)));
			_x = _x._level[(0 : GoInt)]._forward;
		};
		return _val;
	}

	/**
		// ZRem removes the specified members from the sorted set stored at key. Non existing members are ignored.
		// An error is returned when key exists and does not hold a sorted set.
	**/
	@:keep
	static public function zrem(_z:Ref<ZSet>, _key:GoString, _member:GoString):Bool {
		if (!_z._exist(_key)) {
			return false;
		};
		var _n = _z._records[_key];
		var __tmp__ = (_n._dict != null
			&& _n._dict.__exists__(_member) ? {value: _n._dict[_member], ok: true} : {value: (null : T_zskiplistNode), ok: false}),
			_v:Ref<T_zskiplistNode> = __tmp__.value,
			_exist:Bool = __tmp__.ok;
		if (_exist) {
			_n._zsl._delete(_v._score, _member);
			if (_n._dict != null)
				_n._dict.__remove__(_member);
			return true;
		};
		return false;
	}

	/**
		// ZIncrBy increments the score of member in the sorted set stored at key by increment.
		// If member does not exist in the sorted set, it is added with increment as its score (as if its previous score was 0.0).
		// If key does not exist, a new sorted set with the specified member as its sole member is created.
	**/
	@:keep
	static public function zincrBy(_z:Ref<ZSet>, _key:GoString, _increment:GoFloat64, _member:GoString):GoFloat64 {
		var _memberExists:Bool = false;
		var _keyExists:Bool = _z._exist(_key);
		if (_keyExists) {
			var __tmp__ = (_z._records[_key]._dict != null
				&& _z._records[_key]._dict.__exists__(_member) ? {value: _z._records[_key]._dict[_member], ok: true} : {value: (null : T_zskiplistNode),
					ok: false}),
				_node:Ref<T_zskiplistNode> = __tmp__.value,
				_memberExists:Bool = __tmp__.ok;
			if (_memberExists) {
				_increment = _increment + (_node._score);
				_z.zadd(_key, _increment, _member, _node._value);
			};
		};
		if (!_keyExists || !_memberExists) {
			_z.zadd(_key, _increment, _member, (null : AnyInterface));
		};
		return _increment;
	}

	/**
		// ZRevRank returns the rank of member in the sorted set stored at key, with the scores ordered from high to low.
		// The rank (or index) is 0-based, which means that the member with the highest score has rank 0.
	**/
	@:keep
	static public function zrevRank(_z:Ref<ZSet>, _key:GoString, _member:GoString):GoInt64 {
		if (!_z._exist(_key)) {
			return (-1 : GoInt64);
		};
		var _n = _z._records[_key];
		var __tmp__ = (_n._dict != null
			&& _n._dict.__exists__(_member) ? {value: _n._dict[_member], ok: true} : {value: (null : T_zskiplistNode), ok: false}),
			_v:Ref<T_zskiplistNode> = __tmp__.value,
			_exist:Bool = __tmp__.ok;
		if (!_exist) {
			return (-1 : GoInt64);
		};
		var _rank:GoInt64 = _n._zsl._getRank(_v._score, _member);
		return _n._zsl._length - _rank;
	}

	/**
		// ZRank returns the rank of member in the sorted set stored at key, with the scores ordered from low to high.
		// The rank (or index) is 0-based, which means that the member with the lowest score has rank 0.
	**/
	@:keep
	static public function zrank(_z:Ref<ZSet>, _key:GoString, _member:GoString):GoInt64 {
		if (!_z._exist(_key)) {
			return (-1 : GoInt64);
		};
		var _n = _z._records[_key];
		var __tmp__ = (_n._dict != null
			&& _n._dict.__exists__(_member) ? {value: _n._dict[_member], ok: true} : {value: (null : T_zskiplistNode), ok: false}),
			_v:Ref<T_zskiplistNode> = __tmp__.value,
			_exist:Bool = __tmp__.ok;
		if (!_exist) {
			return (-1 : GoInt64);
		};
		var _rank:GoInt64 = _n._zsl._getRank(_v._score, _member);
		_rank--;
		return _rank;
	}

	/**
		// ZCard returns the sorted set cardinality (number of elements) of the sorted set stored at key.
	**/
	@:keep
	static public function zcard(_z:Ref<ZSet>, _key:GoString):GoInt {
		if (!_z._exist(_key)) {
			return (0 : GoInt);
		};
		return (_z._records[_key]._dict.length);
	}

	/**
		// ZScore returns the score of member in the sorted set at key.
	**/
	@:keep
	static public function zscore(_z:Ref<ZSet>, _key:GoString, _member:GoString):{var _0:Bool; var _1:GoFloat64;} {
		var _ok:Bool = false, _score:GoFloat64 = (0 : GoFloat64);
		if (!_z._exist(_key)) {
			return {_0: _ok, _1: _score};
		};
		var __tmp__ = (_z._records[_key]._dict != null
			&& _z._records[_key]._dict.__exists__(_member) ? {value: _z._records[_key]._dict[_member], ok: true} : {value: (null : T_zskiplistNode),
				ok: false}),
			_node:Ref<T_zskiplistNode> = __tmp__.value,
			_exist:Bool = __tmp__.ok;
		if (!_exist) {
			return {_0: _ok, _1: _score};
		};
		return {_0: true, _1: _node._score};
	}

	/**
		// ZAdd Adds the specified member with the specified score to the sorted set stored at key.
		// Add an element into the sorted set with specific key / value / score.
		// Time complexity of this method is : O(log(N))
	**/
	@:keep
	static public function zadd(_z:Ref<ZSet>, _key:GoString, _score:GoFloat64, _member:GoString, _value:AnyInterface):GoInt {
		var _val:GoInt = (0 : GoInt);
		if (!_z._exist(_key)) {
			var _node = ({_dict: (new GoObjectMap<GoString,
				Ref<T_zskiplistNode>>(new stdgo.reflect.Reflect._Type(stdgo.reflect.Reflect.GoType.mapType(stdgo.reflect.Reflect.GoType.basic(string_kind),
				stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [], stdgo.reflect.Reflect.GoType.structType([
					{
						name: "_member",
						embedded: false,
						tag: "",
						type: stdgo.reflect.Reflect.GoType.basic(string_kind)
					},
					{
						name: "_value",
						embedded: false,
						tag: "",
						type: stdgo.reflect.Reflect.GoType.interfaceType(true, [])
					},
					{
						name: "_score",
						embedded: false,
						tag: "",
						type: stdgo.reflect.Reflect.GoType.basic(float64_kind)
					},
					{
						name: "_backward",
						embedded: false,
						tag: "",
						type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
							stdgo.reflect.Reflect.GoType.invalidType))
					},
					{
						name: "_level",
						embedded: false,
						tag: "",
						type: stdgo.reflect.Reflect.GoType.sliceType(stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistLevel",
								[], stdgo.reflect.Reflect.GoType.structType([
							{
								name: "_forward",
								embedded: false,
								tag: "",
								type: stdgo.reflect.Reflect.GoType.refType(stdgo.reflect.Reflect.GoType.named("T_zskiplistNode", [],
									stdgo.reflect.Reflect.GoType.invalidType))
							},
							{
								name: "_span",
								embedded: false,
								tag: "",
								type: stdgo.reflect.Reflect.GoType.basic(uint64_kind)
							}
						]))))
					}
				])))))) : GoMap<GoString, Ref<T_zskiplistNode>>), _zsl: _newZSkipList()} : T_zset);
			_z._records[_key] = _node;
		};
		var _item = _z._records[_key];
		var __tmp__ = (_item._dict != null
			&& _item._dict.__exists__(_member) ? {value: _item._dict[_member], ok: true} : {value: (null : T_zskiplistNode), ok: false}),
			_v:Ref<T_zskiplistNode> = __tmp__.value,
			_exist:Bool = __tmp__.ok;
		var _node:Ref<T_zskiplistNode> = (null : T_zskiplistNode);
		if (_exist) {
			_val = (0 : GoInt);
			if (_score != _v._score) {
				_item._zsl._delete(_v._score, _member);
				_node = _item._zsl._insert(_score, _member, _value);
			} else {
				_v._value = _value;
			};
		} else {
			_val = (1 : GoInt);
			_node = _item._zsl._insert(_score, _member, _value);
		};
		if (_node != null) {
			_item._dict[_member] = _node;
		};
		return _val;
	}

	@:keep
	static public function _exist(_z:Ref<ZSet>, _key:GoString):Bool {
		var __tmp__ = (_z._records != null
			&& _z._records.__exists__(_key) ? {value: _z._records[_key], ok: true} : {value: (null : T_zset), ok: false}),
			_0:Ref<T_zset> = __tmp__.value,
			_exist:Bool = __tmp__.ok;
		return _exist;
	}
}

private class T_zskiplist_asInterface {
	@:keep
	public function _getNodeByRank(_rank:GoUInt64):Ref<T_zskiplistNode>
		return __self__._getNodeByRank(_rank);

	/**
		// Find the rank of the node specified by key
		// Note that the rank is 0-based integer. Rank 0 means the first node
	**/
	@:keep
	public function _getRank(_score:GoFloat64, _member:GoString):GoInt64
		return __self__._getRank(_score, _member);

	/**
		/|* Delete an element with matching score/key from the skiplist. *|/
	**/
	@:keep
	public function _delete(_score:GoFloat64, _member:GoString):Void
		__self__._delete(_score, _member);

	/**
		/|* Internal function used by delete, DeleteByScore and DeleteByRank *|/
	**/
	@:keep
	public function _deleteNode(_x:Ref<T_zskiplistNode>, _updates:Slice<Ref<T_zskiplistNode>>):Void
		__self__._deleteNode(_x, _updates);

	/**
		/|*
			Insert a new node in the skiplist. Assumes the element does not already
			exist (up to the caller to enforce that). The skiplist takes ownership
			of the passed member string.
		*|/
	**/
	@:keep
	public function _insert(_score:GoFloat64, _member:GoString, _value:AnyInterface):Ref<T_zskiplistNode>
		return __self__._insert(_score, _member, _value);

	public function new(?__self__) {
		if (__self__ != null)
			this.__self__ = __self__;
	}

	public function __underlying__()
		return Go.toInterface(__self__);

	var __self__:T_zskiplist;
}

@:keep private class T_zskiplist_static_extension {
	@:keep
	static public function _getNodeByRank(_z:Ref<T_zskiplist>, _rank:GoUInt64):Ref<T_zskiplistNode> {
		var _traversed:GoUInt64 = (0 : GoUInt64);
		var _x = _z._head;
		{
			var _i:GoInt = _z._level - (1 : GoInt);
			Go.cfor(_i >= (0 : GoInt), _i--, {
				while ((_x._level[_i]._forward != null) && ((_traversed + _x._level[_i]._span) <= _rank)) {
					_traversed = _traversed + (_x._level[_i]._span);
					_x = _x._level[_i]._forward;
				};
				if (_traversed == _rank) {
					return _x;
				};
			});
		};
		return null;
	}

	/**
		// Find the rank of the node specified by key
		// Note that the rank is 0-based integer. Rank 0 means the first node
	**/
	@:keep
	static public function _getRank(_z:Ref<T_zskiplist>, _score:GoFloat64, _member:GoString):GoInt64 {
		var _rank:GoUInt64 = (0 : GoUInt64);
		var _x = _z._head;
		{
			var _i:GoInt = _z._level - (1 : GoInt);
			Go.cfor(_i >= (0 : GoInt), _i--, {
				while ((_x._level[_i]._forward != null)
					&& ((_x._level[_i]._forward._score < _score)
						|| ((_x._level[_i]._forward._score == _score) && (_x._level[_i]._forward._member <= _member)))) {
					_rank = _rank + (_x._level[_i]._span);
					_x = _x._level[_i]._forward;
				};
				if (_x._member == _member) {
					return (_rank : GoInt64);
				};
			});
		};
		return (0 : GoInt64);
	}

	/**
		/|* Delete an element with matching score/key from the skiplist. *|/
	**/
	@:keep
	static public function _delete(_z:Ref<T_zskiplist>, _score:GoFloat64, _member:GoString):Void {
		var _update = new Slice<Ref<T_zskiplistNode>>((32 : GoInt).toBasic(), 0, ...[for (i in 0...(32 : GoInt).toBasic()) (null : T_zskiplistNode)]);
		var _x = _z._head;
		{
			var _i:GoInt = _z._level - (1 : GoInt);
			Go.cfor(_i >= (0 : GoInt), _i--, {
				while ((_x._level[_i]._forward != null)
					&& ((_x._level[_i]._forward._score < _score)
						|| ((_x._level[_i]._forward._score == _score) && (_x._level[_i]._forward._member < _member)))) {
					_x = _x._level[_i]._forward;
				};
				_update[_i] = _x;
			});
		};
		_x = _x._level[(0 : GoInt)]._forward;
		if (((_x != null) && (_score == _x._score)) && (_x._member == _member)) {
			_z._deleteNode(_x, _update);
			return;
		};
	}

	/**
		/|* Internal function used by delete, DeleteByScore and DeleteByRank *|/
	**/
	@:keep
	static public function _deleteNode(_z:Ref<T_zskiplist>, _x:Ref<T_zskiplistNode>, _updates:Slice<Ref<T_zskiplistNode>>):Void {
		{
			var _i:GoInt = (0 : GoInt);
			Go.cfor(_i < _z._level, _i++, {
				if (_updates[_i]._level[_i]._forward == _x) {
					_updates[_i]._level[_i]._span = _updates[_i]._level[_i]._span + (_x._level[_i]._span - (1 : GoUInt64));
					_updates[_i]._level[_i]._forward = _x._level[_i]._forward;
				} else {
					_updates[_i]._level[_i]._span--;
				};
			});
		};
		if (_x._level[(0 : GoInt)]._forward != null) {
			_x._level[(0 : GoInt)]._forward._backward = _x._backward;
		} else {
			_z._tail = _x._backward;
		};
		while ((_z._level > (1 : GoInt)) && (_z._head._level[_z._level - (1 : GoInt)]._forward == null)) {
			_z._level--;
		};
		_z._length--;
	}

	/**
		/|*
			Insert a new node in the skiplist. Assumes the element does not already
			exist (up to the caller to enforce that). The skiplist takes ownership
			of the passed member string.
		*|/
	**/
	@:keep
	static public function _insert(_z:Ref<T_zskiplist>, _score:GoFloat64, _member:GoString, _value:AnyInterface):Ref<T_zskiplistNode> {
		var _updates = new Slice<Ref<T_zskiplistNode>>((32 : GoInt).toBasic(), 0, ...[for (i in 0...(32 : GoInt).toBasic()) (null : T_zskiplistNode)]);
		var _rank = new Slice<GoUInt64>((32 : GoInt).toBasic(), 0, ...[for (i in 0...(32 : GoInt).toBasic()) (0 : GoUInt64)]);
		var _x = _z._head;
		{
			var _i:GoInt = _z._level - (1 : GoInt);
			Go.cfor(_i >= (0 : GoInt), _i--, {
				if (_i == (_z._level - (1 : GoInt))) {
					_rank[_i] = (0 : GoUInt64);
				} else {
					_rank[_i] = _rank[_i + (1 : GoInt)];
				};
				if (_x._level[_i] != null) {
					while ((_x._level[_i]._forward != null)
						&& ((_x._level[_i]._forward._score < _score)
							|| ((_x._level[_i]._forward._score == _score) && (_x._level[_i]._forward._member < _member)))) {
						_rank[_i] = _rank[_i] + (_x._level[_i]._span);
						_x = _x._level[_i]._forward;
					};
				};
				_updates[_i] = _x;
			});
		};
		var _level:GoInt = _randomLevel();
		if (_level > _z._level) {
			{
				var _i:GoInt = _z._level;
				Go.cfor(_i < _level, _i++, {
					_rank[_i] = (0 : GoUInt64);
					_updates[_i] = _z._head;
					_updates[_i]._level[_i]._span = (_z._length : GoUInt64);
				});
			};
			_z._level = _level;
		};
		_x = _createNode(_level, _score, _member, _value);
		{
			var _i:GoInt = (0 : GoInt);
			Go.cfor(_i < _level, _i++, {
				_x._level[_i]._forward = _updates[_i]._level[_i]._forward;
				_updates[_i]._level[_i]._forward = _x;
				_x._level[_i]._span = _updates[_i]._level[_i]._span - (_rank[(0 : GoInt)] - _rank[_i]);
				_updates[_i]._level[_i]._span = (_rank[(0 : GoInt)] - _rank[_i]) + (1 : GoUInt64);
			});
		};
		{
			var _i:GoInt = _level;
			Go.cfor(_i < _z._level, _i++, {
				_updates[_i]._level[_i]._span++;
			});
		};
		if (_updates[(0 : GoInt)] == _z._head) {
			_x._backward = null;
		} else {
			_x._backward = _updates[(0 : GoInt)];
		};
		if (_x._level[(0 : GoInt)]._forward != null) {
			_x._level[(0 : GoInt)]._forward._backward = _x;
		} else {
			_z._tail = _x;
		};
		_z._length++;
		return _x;
	}
}

private class T_zset_asInterface {
	@:keep
	public function _findRange(_key:GoString, _start:GoInt64, _stop:GoInt64, _reverse:Bool, _withScores:Bool):Slice<AnyInterface>
		return __self__._findRange(_key, _start, _stop, _reverse, _withScores);

	@:keep
	public function _getNodeByRank(_key:GoString, _rank:GoInt64, _reverse:Bool):{var _0:GoString; var _1:GoFloat64;}
		return __self__._getNodeByRank(_key, _rank, _reverse);

	public function new(?__self__) {
		if (__self__ != null)
			this.__self__ = __self__;
	}

	public function __underlying__()
		return Go.toInterface(__self__);

	var __self__:T_zset;
}

@:keep private class T_zset_static_extension {
	@:keep
	static public function _findRange(_z:Ref<T_zset>, _key:GoString, _start:GoInt64, _stop:GoInt64, _reverse:Bool, _withScores:Bool):Slice<AnyInterface> {
		var _val:Slice<AnyInterface> = (null : Slice<AnyInterface>);
		var _length:GoInt64 = _z._zsl._length;
		if (_start < (0:GoInt64)) {
			_start = _start + (_length);
			if (_start < (0:GoInt64)) {
				_start = (0 : GoInt64);
			};
		};
		if (_stop < (0:GoInt64)) {
			_stop = _stop + (_length);
		};
		if ((_start > _stop) || (_start >= _length)) {
			return _val;
		};
		if (_stop >= _length) {
			_stop = _length - (1 : GoInt64);
		};
		var _span:GoInt64 = (_stop - _start) + (1 : GoInt64);
		var _node:Ref<T_zskiplistNode> = (null : T_zskiplistNode);
		if (_reverse) {
			_node = _z._zsl._tail;
			if (_start > (0 : GoInt64)) {
				_node = _z._zsl._getNodeByRank((_length - _start : GoUInt64));
			};
		} else {
			_node = _z._zsl._head._level[(0 : GoInt)]._forward;
			if (_start > (0 : GoInt64)) {
				_node = _z._zsl._getNodeByRank((_start + (1 : GoInt64) : GoUInt64));
			};
		};
		while (_span > (0 : GoInt64)) {
			_span--;
			if (_withScores) {
				_val = (_val.__append__(Go.toInterface(_node._member), Go.toInterface(_node._score)));
			} else {
				_val = (_val.__append__(Go.toInterface(_node._member)));
			};
			if (_reverse) {
				_node = _node._backward;
			} else {
				_node = _node._level[(0 : GoInt)]._forward;
			};
		};
		return _val;
	}

	@:keep
	static public function _getNodeByRank(_z:Ref<T_zset>, _key:GoString, _rank:GoInt64, _reverse:Bool):{var _0:GoString; var _1:GoFloat64;} {
		if ((_rank < (0:GoInt64)) || (_rank > _z._zsl._length)) {
			return {_0: (Go.str() : GoString), _1: (-9.223372036854776e+18 : GoFloat64)};
		};
		if (_reverse) {
			_rank = _z._zsl._length - _rank;
		} else {
			_rank++;
		};
		var _n = _z._zsl._getNodeByRank((_rank : GoUInt64));
		if (_n == null) {
			return {_0: (Go.str() : GoString), _1: (-9.223372036854776e+18 : GoFloat64)};
		};
		var _node = _z._dict[_n._member];
		if (_node == null) {
			return {_0: (Go.str() : GoString), _1: (-9.223372036854776e+18 : GoFloat64)};
		};
		return {_0: _node._member, _1: _node._score};
	}
}
