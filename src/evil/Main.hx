package evil;


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
