import Entity;

class UpdateError implements ResultError {
	final message: String;
	public function new(message: String) {
		this.message = message;
	}
	
	public function msg(): String {
		return this.message;
	}
}

private inline function err(msg: String): Result<Empty, UpdateError> {
	return Err(new UpdateError(msg));
}

final class Turn {
	
	var used: Set<Pos>;
	
	public function new() {
		used = Set.empty();
	}

	public function runCommand(field: Field, command: Command, player: Player): Result<Empty, UpdateError> {
		var pos = command.pos;
		if (used.has(pos)){
			return err("Position has been used already");
		}
		var occupant: Entity = field.get(pos);
		var keepLocation = field.keepLocation(pos);
		
		if (command.action != Claim && !field.owner(pos).equals(Some(player))) {
			return err("Can't perform actions on entity outside your plots (except claim)");
		}
		return switch (command.action) {
			case Claim:
				if (field.owner(pos) != None) {
					err("Keep location not empty");
				} else if (field.plotsOwned(player).length != 0) {
					err("Claim can only be used when player doesn't have any plot");
				} else {
					field.claim(pos, player);
// 					used.add(keepLocation);
					Ok(__);
				}
			case Build(entity, resources):
				if (occupant != Empty){
					return err("Can only build on empty positions");
				}
				switch (entity) {
					case Woodcutter:
						if (!field.hasNeighbour(pos, Forest)) {
							return err("Woodcutter must be built next to forest");
						}
						field.set(pos, Woodcutter);
					case Farm:
						var cost = Set.from([Wood]);
						if (!field.paysCost(pos, cost, resources)){
							return err("Building resources must exactly match building costs");
						}
						field.set(pos, Farm);
					case Freepile:
						field.set(pos, entity);
						Ok(__);
					default:
						return err("Can't build entity type");
				}
				used.add(pos);
				for (pile in resources) {
					field.set(pile, Freepile);
				}
				Ok(__);
			case Move(to):
				if (!field.keepLocation(to).equals(keepLocation)) {
					return err("Can't move to another plot");
				}
				if (field.get(to) != Empty) {
					return err("Destination is not empty");
				}
				switch (occupant) {
					case Raider:
						field.set(to, occupant);
						field.set(pos, Empty);
						used.add(to);
						Ok(__);
					default:
						err("Can't build entity type");
				}
			case Produce(pile):
				if (!field.keepLocation(pile).equals(keepLocation)) {
					return err("Can't move producted items to another plot");
				}
				if (!field.get(pile).equals(Freepile)) {
					return err("Produced items must be stored in an empty stockpile");
				}
				switch (occupant) {
					case Farm:
						field.set(pile, Stockpile(Food));
						Ok(__);
					case Forest:
						if (
								[for (n in pos.neighbours())
									if (keepLocation.equals(field.keepLocation(n)) && field.get(n).equals(Woodcutter))
										n
								].length == 0) {
							return err("A woodcutter in the same plot is required to cut wood");
						}
						field.set(pile, Stockpile(Wood));
						Ok(__);
					default:
						err("Not a production building");
				}
			case Remove:
				switch (occupant) {
					case Farm | Woodcutter | Raider | Stockpile(_):
						field.set(pos, Empty);
						Ok(__);
					default:
						err("Cant remove entity");
				}
			case Attack(dir):
				err("Attacking is not implemented yet");
		}
	}

}
