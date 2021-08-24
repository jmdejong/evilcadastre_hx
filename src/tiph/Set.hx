package tiph;

import tiph.Result;

final class Set<T> {
	
	var dict: Dict<T, Empty>;
	
	private inline function new(dict: Dict<T, Empty>){
		this.dict = dict;
	}
	
	public static inline function empty<T>(): Set<T> {
		return new Set(Dict.empty());
	}
	
	public static function from<T>(i: Iterable<T>): Set<T> {
		var s: Set<T> = new Set(Dict.empty());
		for (item in i){
			s.add(item);
		}
		return s;
	}
	
	public inline function add(elem: T) {
		this.dict.set(elem, __);
	}
	
	public inline function has(elem: T): Bool {
		return this.dict.has(elem);
	}
	
	public inline function remove(elem: T): Bool {
		return this.dict.remove(elem);
	}
	
	public inline function copy(): Set<T> {
		return new Set(dict.copy());
	}
	
	public inline function isEmpty(): Bool {
		return dict.isEmpty();
	}
}
