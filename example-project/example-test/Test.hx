// Example haxe programme using generated modules inside a Haxelib
package;

import go2hxdoc_example.*;

class Test {
	static function main() {
		final ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
		trace(github_com.kr.text.Text.wrap(ipsum, 42)); // outputs above text wrapped
		trace(golang_org.x.example.stringutil.Stringutil.reverse("界世 ,olleH")); // Hello, 世界
		trace(github_com.arriqaaq.zset.Zset.skiplist_MAXLEVEL); // 32
	}
}
