

@:expose
enum abstract Item(String) {
	var Wood = "wood";
	var Food = "food";
}

@:expose
enum Entity_ {
	Keep(owner: Player);
	Raider;
	Woodcutter;
	Farm;
	Forest;
	Empty;
	Stockpile(item: Item);
	Freepile;
}

@:expose
abstract Entity(Entity_) from Entity_ to Entity_ {
	inline function new(e: Entity_) {
		this = e;
	}
	
	public function raider(): Entity {
		return Raider;
	}
	
	public function keep(player: Player): Entity {
		return Keep(player);
	}
	
	public function str(): String {
		return switch (this) {
			case Keep(owner): 'keep$$$owner';
			case Raider | Woodcutter | Farm | Forest:
				this.getName().toLowerCase();
			case Freepile: "stockpile";
			case Stockpile(item): 'stockpile$$$item';
			case Empty: "_";
		}
	}
	
	public static function fromStr(str: String): Option<Entity> {
		var parts = str.split("$");
		if (parts.length == 0) return None;
		return Some(switch (parts[0]) {
			case "raider": Raider;
			case "woodcutter": Woodcutter;
			case "farm": Farm;
			default:
				return None;
		});
	}
	
	
	@:op(A == B)
	public function eq(rhs: Entity) {
		return this.equals(rhs);
	}
	@:op(A != B)
	public function neq(rhs: Entity) {
		return !(this == rhs);
	}
}
