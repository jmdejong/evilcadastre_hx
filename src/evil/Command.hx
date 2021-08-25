package evil;
import evil.Pos;
import evil.ParseError;

enum Action {
	Claim;
	Build(ent: Entity, resources: Array<Pos>);
	Move(to: Pos);
	Attack(dir: Direction);
	Produce(stockpile: Pos);
	Remove;
}

@:structInit final class Command {
	public final action: Action;
	public final pos: Pos;
	
	public static function fromStr(s: String): Option<Command> {
		var p = s.partitionTrim(":");
		var pos = Pos.fromStr(p[0]).trySome();
		var q = p[1].partitionTrim(":");
		var arg = q[1];
		var action = switch (q[0]) {
			case "build":
				var args = arg.partitionTrim("#");
				Build(
					Entity.fromStr(args[0]).trySome(),
					if (args[1].contains("#")) {
						[for (pos in args[1].split("#")) Pos.fromStr(pos).trySome()];
					} else if (args[1].trim() != ""){
						[Pos.fromStr(args[1]).trySome()];
					} else {
						[];
					}
				);
			case "move": Move(Pos.fromStr(arg).trySome());
			case "attack": Attack(DirectionTools.fromStr(arg).trySome());
			case "produce": Produce(Pos.fromStr(arg).trySome());
			case "remove": Remove;
			case _: return None;
		}
		return Some({pos: pos, action: action});
	}
	public function toStr(): String {
		var p = pos.toStr();
		var a = switch (action) {
			case Claim: "claim";
			case Build(ent, resources):
				"build:" + ent.toStr() + "#" + [for (resource in resources) resource.toStr()].join("#");
			case Move(to):
				"move:" + to.toStr();
			case Attack(dir):
				"attack:" + DirectionTools.toStr(dir);
			case Produce(stockpile):
				"produce:" + stockpile.toStr();
			case Remove: "remove";
		}
		return '$p: $a';
	}
}

@:structInit final class Commands {
	
	public final commands: Array<Command>;
	
	public static function fromStr(s: String): Result<Commands, ParseError> {
		var ef = EvilFormat.fromStr(s);
		return Ok({commands: 
			[for (item in ef.items) Command.fromStr(item).toResult(parseErr('failed parsing $item')).tryOk()]
		});
	}
	
	public function toStr(): String {
		var ef: EvilFormat = {
			headers: Dict.empty(),
			items: [for (command in commands) command.toStr()]
		};
		return ef.toStr();
	}
}
