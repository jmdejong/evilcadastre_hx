package eloph;


import haxe.ds.Option;
import haxe.Serializer;
import haxe.Unserializer;
import haxe.ds.StringMap;


final class Dict<K, V> {
	var map: StringMap<V>;
	
	private inline function new(map: StringMap<V>){
		this.map = map;
	}
	
	public inline static function empty<K, V>(): Dict<K, V> {
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
		map.set(Serializer.run(key), val);
	}
	
	public inline function has(key: K): Bool {
		return map.exists(Serializer.run(key));
	}
	
	public inline function remove(key: K): Bool {
		return map.remove(Serializer.run(key));
	}
	
	public inline function copy(): Dict<K, V> {
		return new Dict(map.copy());
	}
	
	public function keys(): Array<K> {
		return [for (key in this.map.keys()) Unserializer.run(key)];
	}
	
	public function isEmpty(): Bool {
		return !map.iterator().hasNext();
	}
}
