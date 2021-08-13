
import Pos;
import Cadastre;




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
			case WoodCutter: "W";
			case Empty: ".";
		}
	}
}

class Main {
	static public function main(): Void {
		var player = new Player("Player1");
		var field = Field.empty({x: 30, y: 30}, Cadastre.square(5));
		field.set({x: 2, y: 2}, Keep(player));
		field.set({x: 2, y: 0}, Woodcutter);
		field.set({x: 12,y: 2}, Keep(player));
		field.set({x: 14,y: 4}, Raider);
		
		var out = AsciiRenderer.render(field);
		
		Sys.println(out);
	}
}
