import Entity;
using StrUtils;
using OptionTools;
using Utils;


final class Field {
	public final size: Pos;
	public final cadastre: Cadastre;
	var tiles: Dict<Pos, Entity>;
	
	function new(size: Pos, cadastre: Cadastre, tiles: Dict<Pos, Entity>) {
		this.size = size;
		this.cadastre = cadastre;
		this.tiles = tiles;
	}
	
	public static function empty(size, cadastre){
		return new Field(size, cadastre, Dict.empty());
	}
	
	public function get(pos: Pos): Entity {
		return this.tiles.getOr(pos, Empty);
	}
	
	public function keepLocation(pos: Pos): Pos {
		return this.cadastre.keepLocation(pos);
	}
	
	public function owner(pos: Pos): Option<Player> {
		return switch (this.get(this.cadastre.keepLocation(pos))){
			case Keep(owner): Some(owner);
			default: None;
		}
	}
	
	public function claim(pos: Pos, player: Player) {
		this.set(this.cadastre.keepLocation(pos), Keep(player));
	}
	
	public function set(pos: Pos, entity: Entity){
		this.tiles.set(pos, entity);
	}
	
	public function copy(): Field {
		return new Field(size, cadastre, tiles.copy());
	}
	
	public function plotsOwned(player: Player): Array<Pos> {
		return [
			for (pos in cadastre.keeps(size)) 
				if (owner(pos).equals(Some(player))) 
					pos
		];
	}
	
	public function hasNeighbour(pos: Pos, ent: Entity): Bool {
		return [for (p in pos.neighbours())
			if (this.get(p).equals(ent))
				true
		].length != 0;
	}
	
	public function paysCost(pos: Pos, cost: Set<Item>, resources: Iterable<Pos>): Bool {
		var keepLocation: Pos = cadastre.keepLocation(pos);
		for (resourcePos in resources) {
			if (!keepLocation.equals(cadastre.keepLocation(resourcePos))) {
				return false;
			}
			switch (this.get(resourcePos)) {
				case Stockpile(item):
					if (!cost.remove(item)) {
						return false;
					}
				default:
					return false;
			}
		}
		return cost.isEmpty();
	}
	
	public function setOwner(pos: Pos, player: Player) {
		set(cadastre.keepLocation(pos), Keep(player));
	}
	
	public function serialize() {
		return "";
	}
	
	public static function deserialize(ser: String): Option<Field> {
		var headers: Dict<String, String> = Dict.empty();
		var lines: Array<String> = [];
		var readingBody = false;
		for (part in ser.split(";")) {
			var l = part.trim();
			if (l == "") {
				readingBody = true;
			} else if (readingBody) {
				lines.push(l);
			} else {
				var header = l.partitionTrim(":");
				headers.set(header[0], header[1]);
			}
		};
		var fieldSize: Pos = headers.get("field_size").andThen(Pos.fromStr).tryOption();
		var cadastre: Cadastre = headers.get("cadastre").andThen(Cadastre.fromStr).tryOption();
		var entities: Dict<Pos, Entity> = Dict.empty();
		for (line in lines){
			var p = line.partitionTrim(":");
			var pos: Pos = Pos.fromStr(p[0]).tryOption();
			var ent: Entity = Entity.fromStr(p[1]).tryOption();
			entities.set(pos, ent);
		}
		return Some(new Field(fieldSize, cadastre, entities));
	}
}
