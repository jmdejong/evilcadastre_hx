package evil;


interface CadastreShapes {
	public function keepLocation(p: Pos): Pos;
	
	public function keeps(size: Pos): Array<Pos>;
	
	public function toStr(): String;
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
	
	
	public function toStr(): String {
		return "rect: " + plot_size.toStr();
	}
}

@:forward(keepLocation, keeps, toStr)
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
	
	public static function fromStr(str: String): Option<Cadastre> {
		return switch (str.partitionTrim(":")){
			case ["rect", size]:
				Pos.fromStr(size).map(s -> Cadastre.rectangle(s));
			case _:
				None;
		}
	}
}
