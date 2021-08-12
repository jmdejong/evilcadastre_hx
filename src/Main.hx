
import Pos;
import Entity;




enum Action {
	Build(ent: Entity);
	Move(to: Pos);
	Attack(dir: Direction);
}

final class Command {
	final action: Action;
	final pos: Pos;
	public function new(action, pos){
		this.pos = pos;
		this.action = action;
	}
}


final class AsciiRenderer {
	
	public static function render(field: Field): String {
		var out = "";
		for (y in 0...field.size.y) {
			var line = "";
			for (x in 0...field.size.x) {
				line += drawEntity(field.get(pos(x, y)));
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
		var field = Field.empty(pos(30, 30), Cadastre.square(5));
		field.set(pos(2, 2), Keep(player));
		field.set(pos(2, 0), WoodCutter);
		field.set(pos(12,2), Keep(player));
		field.set(pos(14,4), Raider);
		
		var out = AsciiRenderer.render(field);
		
		Sys.println(out);
	}
}
