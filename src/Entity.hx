
final class Player {
	public final name: String;
	
	public function new(name: String) {
		this.name = name;
	}
}


enum Entity {
	Keep(owner: Player);
	Raider;
	WoodCutter;
	Empty;
}
