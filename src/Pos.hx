
final class Pos {
	public final x: Int;
	public final y: Int;
	
	public function new(x: Int, y: Int){
		this.x = x;
		this.y = y;
	}
	public function add(p: Pos): Pos {
		return new Pos(this.x + p.x, this.y + p.y);
	}
	public function mult(p: Pos): Pos{
		return new Pos(this.x * p.x, this.y * p.y);
	}
	public function div(p: Pos): Pos{
		return new Pos(Std.int(this.x / p.x), Std.int(this.y / p.y));
	}
}


function pos(x, y){
	return new Pos(x, y);
}

enum Direction {North; East; South; West;}
