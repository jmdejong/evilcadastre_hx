


final class World {
	
	private final field: Field;
	
	public function new(field: Field) {
		this.field = field;
	}
	
	
	public function can_execute_command(command: Command): Bool {
		return false;
	}
}
