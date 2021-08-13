

class Turn {
	
	var used: Set<Pos>;
	
	public function new() {
		used = Set.empty();
	}

	public function runCommand(field: Field, command: Command, player: Player): Bool {
		var pos = command.pos;
		if (used.has(pos)){
			return false;
		}
		var occupant: Entity = field.get(pos);
		return switch (command.action) {
			case Claim:
				var keepLocation = field.keepLocation(pos);
				if (field.get(keepLocation) == Entity.Empty && field.plotsOwned(player).length == 0) {
					field.set(keepLocation, Entity.Keep(player));
					used.add(keepLocation);
					true;
				} else {
					false;
				}
			case Build(entity):
				if (!field.ownedBy(pos, player) || occupant != Entity.Empty){
					return false;
				}
				switch (entity) {
					case Woodcutter if (field.hasNeighbour(pos, Entity.Forest)):
						field.set(pos, Entity.Woodcutter);
						used.add(pos);
						true;
					default:
						false;
				}
			case Move(to):
				if (!field.ownedBy(pos, player) 
						|| !field.keepLocation(to).equals(field.keepLocation(pos)) 
						|| field.get(to) != Entity.Empty
						|| used.has(to)) {
					return false;
				}
				switch (occupant) {
					case Raider:
						field.set(to, occupant);
						field.set(pos, Entity.Empty);
						used.add(pos);
						used.add(to);
						true;
					default:
						false;
				}
			default:
				false;
		}
	}

}
