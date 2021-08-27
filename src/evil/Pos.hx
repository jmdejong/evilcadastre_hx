package evil;


enum Direction {North; East; South; West;}

final class DirectionTools {
	public static function fromStr(str: String): Option<Direction> {
		return switch (str.trim()) {
			case "north": Some(North);
			case "south": Some(South);
			case "east": Some(East);
			case "west": Some(West);
			case _: None;
		};
	}
	
	public static function toStr(dir: Direction): String {
		return switch (dir) {
			case North: "north";
			case South: "south";
			case East: "east";
			case West: "west";
		}
	}
}

@:structInit final class Pos {
	public final x: Int;
	public final y: Int;
	
	public function add(p: Pos): Pos {
		return {x: x + p.x, y: y + p.y};
	}
	public function mult(p: Pos): Pos {
		return {x: x * p.x, y: y * p.y};
	}
	public function div(p: Pos): Pos {
		return {x: Std.int(x / p.x), y: Std.int(y / p.y)};
	}
	public function equals(p: Pos): Bool {
		return x == p.x && y == p.y;
	}
	
	public function moved(dir: Direction): Pos {
		return switch (dir) {
			case North:
				{x: x, y: y - 1}
			case South:
				{x: x, y: y + 1}
			case East:
				{x: x + 1, y: y}
			case West:
				{x: x - 1, y: y}
		};
	}
	
	public function neighbours(): Array<Pos> {
		return [
			{x: x, y: y - 1},
			{x: x, y: y + 1},
			{x: x + 1, y: y},
			{x: x - 1, y: y},
		];
	}
	
	@:nullSafety(Off)
	public static function fromStr(str: String): Option<Pos> {
		var values: Array<Null<Int>> = str.partitionTrim(",").map(Std.parseInt);
		if (values.length != 2 || values.contains(null)){
			return None;
		}
		return Some(pos(values[0], values[1]));
	}
	
	public function toStr(): String {
		return '$x,$y';
	}
}

inline function pos(x: Int, y: Int): Pos {
	return {x: x, y: y};
}



