

import haxe.ds.Option;
import haxe.Serializer;
import haxe.ds.StringMap;


class Dict<K, V> {
	var map: StringMap<V>;
	
	function new(map: StringMap<V>){
		this.map = map;
	}
	
	public static function empty() {
		return new Dict(new StringMap());
	}
	
	public function get(key: K): Option<V> {
		var keyStr = Serializer.run(key);
		return if (!map.exists(keyStr)){
			None;
		} else {
			Some(map.get(keyStr));
		};
	}
	
	public function getOr(key: K, def: V): V {
		return switch(get(key)) {
			case Some(val): val;
			case None: def;
		};
	}
	
	public function set(key: K, val: V) {
		var keyStr = Serializer.run(key);
		map.set(keyStr, val);
	}
	
	public function copy(): Dict<K, V>{
		return new Dict(map.copy());
	}
}
