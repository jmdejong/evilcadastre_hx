

interface CadastreShapes {
	public function keepLocation(p: Pos): Pos;
	
	public function keeps(size: Pos): Array<Pos>;
}


private final class RectanglePlots implements CadastreShapes {
	
	private final plot_size: Pos;
	
	public function new(plot_size: Pos){
		this.plot_size = plot_size;
	}
	
	public function keepLocation(p: Pos): Pos {
		return p
			.div(this.plot_size)
			.mult(this.plot_size)
			.add(this.plot_size.div({x: 2, y: 2}));
	}
	
	public function keeps(size: Pos): Array<Pos> {
		var nplots = size.div(plot_size);
		return [
			for (x in 0...nplots.x)
				for (y in 0...nplots.y)
					keepLocation(plot_size.mult({x: x, y: y}))
		];
	}
}

@:forward(keepLocation, keeps)
abstract Cadastre(CadastreShapes) to CadastreShapes {
	inline public function new(shapes: CadastreShapes) {
		this = shapes;
	}
	
	public static function rectangle(size: Pos): Cadastre {
		return new Cadastre(new RectanglePlots(size));
	}
	public static function square(size: Int): Cadastre {
		return new Cadastre(new RectanglePlots({x: size, y: size}));
	}
}
