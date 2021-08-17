
@:expose
final class AsciiRenderer {
	
	public static function render(field: Field): String {
		var out = "";
		for (y in 0...field.size.y) {
			var line = "";
			for (x in 0...field.size.x) {
				line += drawEntity(field.get({x: x, y: y}));
			}
			if (y != 0){
				out += "\n";
			}
			out += line;
		}
		return out;
	}
	
	static function drawEntity(ent: Entity): String {
		return switch (ent) {
			case Keep(_): "@";
			case Raider: "R";
			case Woodcutter: "W";
			case Empty: ".";
			case Farm: "F";
			case Forest: "%";
			case Freepile: "_";
			case Stockpile(Wood): "=";
			case Stockpile(Food): "8";
		}
	}
}
