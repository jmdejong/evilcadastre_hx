package evil;


final class World {
	
// 	private final field: Field;
// 	
// 	public function new(field: Field) {
// 		this.field = field;
// 	}
	
	
// 	public function can_execute_command(command: Command): Bool {
// 		return false;
// 	}
	
	public update(field: Field, allCommands: Dict<Player, Command>): Field {
		return field.copy()
	}
}
