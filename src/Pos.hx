

enum Direction {North; East; South; West;}

@:structInit final class Pos {
	public final x: Int;
	public final y: Int;
	
	public function add(p: Pos): Pos {
		return {x: this.x + p.x, y: this.y + p.y};
	}
	public function mult(p: Pos): Pos {
		return {x: this.x * p.x, y: this.y * p.y};
	}
	public function div(p: Pos): Pos {
		return {x: Std.int(this.x / p.x), y: Std.int(this.y / p.y)};
	}
	public function equals(p: Pos): Bool {
		return x == p.x && y == p.y;
	}
	
	public function moved(dir: Direction): Pos {
		return switch (dir) {
			case North:
				{x: this.x, y: this.y - 1}
			case South:
				{x: this.x, y: this.y + 1}
			case East:
				{x: this.x + 1, y: this.y}
			case West:
				{x: this.x - 1, y: this.y}
		};
	}
	
	public function neighbours(): Array<Pos> {
		return [
			{x: this.x, y: this.y - 1},
			{x: this.x, y: this.y + 1},
			{x: this.x + 1, y: this.y},
			{x: this.x - 1, y: this.y},
		];
	}
}



