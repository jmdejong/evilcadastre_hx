
import Entity;

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
	
	
	public function owner(pos: Pos): Option<Player> {
		return switch (this.get(this.cadastre.keep_location(pos))){
			case Keep(owner): Some(owner);
			default: None;
		}
	}
	
	public function set(pos: Pos, entity: Entity){
		this.tiles.set(pos, entity);
	}
	
	public function copy(): Field {
		return new Field(size, cadastre, tiles.copy());
	}
	
}
