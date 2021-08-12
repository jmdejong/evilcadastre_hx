

interface CadastreShapes {
	public function keep_location(p: Pos): Pos;
}

final class Cadastre {
	
	private final shapes: CadastreShapes;
	
	function new(shapes: CadastreShapes) {
		this.shapes = shapes;
	}
	
	public static function square(size: Int){
		return Cadastre.rectangular(new Pos(size, size));
	}
	
	public static function rectangular(size: Pos){
		return new Cadastre(new RectanglePlots(size));
	}
	
	
	public function keep_location(p: Pos): Pos {
		return this.shapes.keep_location(p);
	}
}

private final class RectanglePlots implements CadastreShapes {
	
	private final plot_size: Pos;
	
	public function new(plot_size: Pos){
		this.plot_size = plot_size;
	}
	
	public function keep_location(p: Pos): Pos {
		return p
			.div(this.plot_size)
			.mult(this.plot_size)
			.add(this.plot_size.div(new Pos(2,2)));
	}
}
