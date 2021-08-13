


class Set<T> {
	
	var dict: Dict<T, Bool>;
	
	private inline function new(dict: Dict<T, Bool>){
		this.dict = dict;
	}
	
	public static inline function empty<T>(): Set<T> {
		return new Set(Dict.empty());
	}
	
	public inline function add(elem: T) {
		this.dict.set(elem, true);
	}
	
	public inline function has(elem: T): Bool {
		return this.dict.has(elem);
	}
	
	public inline function remove(elem: T): Bool {
		return this.dict.remove(elem);
	}
}
