package github_com.kr.text;

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
	// Package text provides rudimentary functions for manipulating text in
	// paragraphs.
**/
private var __go2hxdoc__package:Bool;

private var _nl:Slice<GoUInt8> = (new Slice<GoUInt8>(0, 0, ("\n".code : GoUInt8)) : Slice<GoUInt8>);
private var _sp:Slice<GoUInt8> = (new Slice<GoUInt8>(0, 0, (" ".code : GoUInt8)) : Slice<GoUInt8>);
private final _defaultPenalty:GoUnTypedFloat = (100000 : GoUnTypedFloat);

/**
	// Writer indents each line of its input.
**/
@:structInit @:using(github_com.kr.text.Text.T_indentWriter_static_extension) private class T_indentWriter {
	public var _w:stdgo.io.Io.Writer = (null : stdgo.io.Io.Writer);
	public var _bol:Bool = false;
	public var _pre:Slice<Slice<GoUInt8>> = (null : Slice<Slice<GoUInt8>>);
	public var _sel:GoInt = 0;
	public var _off:GoInt = 0;

	public function new(?_w:stdgo.io.Io.Writer, ?_bol:Bool, ?_pre:Slice<Slice<GoUInt8>>, ?_sel:GoInt, ?_off:GoInt) {
		if (_w != null)
			this._w = _w;
		if (_bol != null)
			this._bol = _bol;
		if (_pre != null)
			this._pre = _pre;
		if (_sel != null)
			this._sel = _sel;
		if (_off != null)
			this._off = _off;
	}

	public function __underlying__():AnyInterface
		return Go.toInterface(this);

	public function __copy__() {
		return new T_indentWriter(_w, _bol, _pre, _sel, _off);
	}
}

/**
	// Indent inserts prefix at the beginning of each non-empty line of s. The
	// end-of-line marker is NL.
**/
function indent(_s:GoString, _prefix:GoString):GoString {
	return (indentBytes((_s : Slice<GoByte>), (_prefix : Slice<GoByte>)) : GoString);
}

/**
	// IndentBytes inserts prefix at the beginning of each non-empty line of b.
	// The end-of-line marker is NL.
**/
function indentBytes(_b:Slice<GoByte>, _prefix:Slice<GoByte>):Slice<GoByte> {
	var _res:Slice<GoByte> = (null : Slice<GoUInt8>);
	var _bol:Bool = true;
	for (_0 => _c in _b) {
		if (_bol && (_c != ("\n".code : GoUInt8))) {
			_res = (_res.__append__(..._prefix.__toArray__()));
		};
		_res = (_res.__append__(_c));
		_bol = _c == ("\n".code : GoUInt8);
	};
	return _res;
}

/**
	// NewIndentWriter makes a new write filter that indents the input
	// lines. Each line is prefixed in order with the corresponding
	// element of pre. If there are more lines than elements, the last
	// element of pre is repeated for each subsequent line.
**/
function newIndentWriter(_w:stdgo.io.Io.Writer, _pre:haxe.Rest<Slice<GoByte>>):stdgo.io.Io.Writer {
	var _pre = new Slice<Slice<GoByte>>(0, 0, ..._pre);
	return Go.asInterface(({_w: _w, _pre: _pre, _bol: true} : T_indentWriter));
}

/**
	// Wrap wraps s into a paragraph of lines of length lim, with minimal
	// raggedness.
**/
function wrap(_s:GoString, _lim:GoInt):GoString {
	return (wrapBytes((_s : Slice<GoByte>), _lim) : GoString);
}

/**
	// WrapBytes wraps b into a paragraph of lines of length lim, with minimal
	// raggedness.
**/
function wrapBytes(_b:Slice<GoByte>, _lim:GoInt):Slice<GoByte> {
	var _words = stdgo.bytes.Bytes.split(stdgo.bytes.Bytes.replace(stdgo.bytes.Bytes.trimSpace(_b), _nl, _sp, (-1 : GoInt)), _sp);
	var _lines:Slice<Slice<GoByte>> = (null : Slice<Slice<GoUInt8>>);
	for (_0 => _line in wrapWords(_words, (1 : GoInt), _lim, (100000 : GoInt))) {
		_lines = (_lines.__append__(stdgo.bytes.Bytes.join(_line, _sp)));
	};
	return stdgo.bytes.Bytes.join(_lines, _nl);
}

/**
	// WrapWords is the low-level line-breaking algorithm, useful if you need more
	// control over the details of the text wrapping process. For most uses, either
	// Wrap or WrapBytes will be sufficient and more convenient.
	//
	// WrapWords splits a list of words into lines with minimal "raggedness",
	// treating each byte as one unit, accounting for spc units between adjacent
	// words on each line, and attempting to limit lines to lim units. Raggedness
	// is the total error over all lines, where error is the square of the
	// difference of the length of the line and lim. Too-long lines (which only
	// happen when a single word is longer than lim units) have pen penalty units
	// added to the error.
**/
function wrapWords(_words:Slice<Slice<GoByte>>, _spc:GoInt, _lim:GoInt, _pen:GoInt):Slice<Slice<Slice<GoByte>>> {
	var _n:GoInt = (_words.length);
	var _length = new Slice<Slice<GoInt>>((_n : GoInt).toBasic(), 0, ...[for (i in 0...(_n : GoInt).toBasic()) (null : Slice<GoInt>)]);
	{
		var _i:GoInt = (0 : GoInt);
		Go.cfor(_i < _n, _i++, {
			_length[_i] = new Slice<GoInt>((_n : GoInt).toBasic(), 0, ...[for (i in 0...(_n : GoInt).toBasic()) (0 : GoInt)]);
			_length[_i][_i] = (_words[_i].length);
			{
				var _j:GoInt = _i + (1 : GoInt);
				Go.cfor(_j < _n, _j++, {
					_length[_i][_j] = (_length[_i][_j - (1 : GoInt)] + _spc) + (_words[_j].length);
				});
			};
		});
	};
	var _nbrk = new Slice<GoInt>((_n : GoInt).toBasic(), 0, ...[for (i in 0...(_n : GoInt).toBasic()) (0 : GoInt)]);
	var _cost = new Slice<GoInt>((_n : GoInt).toBasic(), 0, ...[for (i in 0...(_n : GoInt).toBasic()) (0 : GoInt)]);
	for (_i => _ in _cost) {
		_cost[_i] = (2147483647 : GoInt);
	};
	{
		var _i:GoInt = _n - (1 : GoInt);
		Go.cfor(_i >= (0 : GoInt), _i--, {
			if ((_length[_i][_n - (1 : GoInt)] <= _lim) || (_i == (_n - (1 : GoInt)))) {
				_cost[_i] = (0 : GoInt);
				_nbrk[_i] = _n;
			} else {
				{
					var _j:GoInt = _i + (1 : GoInt);
					Go.cfor(_j < _n, _j++, {
						var _d:GoInt = _lim - _length[_i][_j - (1 : GoInt)];
						var _c:GoInt = (_d * _d) + _cost[_j];
						if (_length[_i][_j - (1 : GoInt)] > _lim) {
							_c = _c + (_pen);
						};
						if (_c < _cost[_i]) {
							_cost[_i] = _c;
							_nbrk[_i] = _j;
						};
					});
				};
			};
		});
	};
	var _lines:Slice<Slice<Slice<GoByte>>> = (null : Slice<Slice<Slice<GoUInt8>>>);
	var _i:GoInt = (0 : GoInt);
	while (_i < _n) {
		_lines = (_lines.__append__((_words.__slice__(_i, _nbrk[_i]) : Slice<Slice<GoUInt8>>)));
		_i = _nbrk[_i];
	};
	return _lines;
}

private class T_indentWriter_asInterface {
	/**
		// The only errors returned are from the underlying indentWriter.
	**/
	@:keep
	public function write(_p:Slice<GoByte>):{var _0:GoInt; var _1:Error;}
		return __self__.write(_p);

	public function new(?__self__) {
		if (__self__ != null)
			this.__self__ = __self__;
	}

	public function __underlying__()
		return Go.toInterface(__self__);

	var __self__:T_indentWriter;
}

@:keep private class T_indentWriter_static_extension {
	/**
		// The only errors returned are from the underlying indentWriter.
	**/
	@:keep
	static public function write(_w:Ref<T_indentWriter>, _p:Slice<GoByte>):{var _0:GoInt; var _1:Error;} {
		var _n:GoInt = (0 : GoInt), _err:Error = (null : stdgo.Error);
		for (_0 => _c in _p) {
			if (_w._bol) {
				var _i:GoInt = (0 : GoInt);
				{
					var __tmp__ = _w._w.write((_w._pre[_w._sel].__slice__(_w._off) : Slice<GoUInt8>));
					_i = __tmp__._0;
					_err = __tmp__._1;
				};
				_w._off = _w._off + (_i);
				if (_err != null) {
					return {_0: _n, _1: _err};
				};
			};
			{
				var __tmp__ = _w._w.write((new Slice<GoUInt8>(0, 0, _c) : Slice<GoUInt8>));
				_err = __tmp__._1;
			};
			if (_err != null) {
				return {_0: _n, _1: _err};
			};
			_n++;
			_w._bol = _c == ("\n".code : GoUInt8);
			if (_w._bol) {
				_w._off = (0 : GoInt);
				if (_w._sel < (_w._pre.length - (1 : GoInt))) {
					_w._sel++;
				};
			};
		};
		return {_0: _n, _1: (null : stdgo.Error)};
	}
}
