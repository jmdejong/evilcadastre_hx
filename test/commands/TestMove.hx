package test.commands;
import utest.Assert;

class TestMove extends utest.Test {


	var cadastre: Cadastre;
	var field: Field;
	var keepLocation: Pos;
	var turn: Turn;
	var player: Player;
	var from: Pos;
	
	public function setup(){
	
		cadastre = Cadastre.square(10);
		field = Field.empty({x: 30, y: 30}, cadastre);
		keepLocation = cadastre.keepLocation({x: 11, y: 11});
		player = new Player("bob");
		field.set(keepLocation, Entity.Keep(player));
		from = {x: 11, y: 13};
		field.set(from, Entity.Raider);
		turn = new Turn();
	}
	
	public function testCanMoveRaiderToEmptyPlace() {
		var to: Pos = {x: 18, y: 12};
		var command: Command = {action: Action.Move(to), pos: from};
		Assert.isTrue(turn.runCommand(field, command, player));
		Assert.equals(field.get(from), Entity.Empty);
		Assert.equals(field.get(to), Entity.Raider);
	}
	
	public function testCantMoveRaiderToKeep() {
		var to: Pos = keepLocation;
		var command: Command = {action: Action.Move(to), pos: from};
		Assert.isFalse(turn.runCommand(field, command, player));
		Assert.equals(field.get(from), Entity.Raider);
		Assert.isTrue(field.get(to).equals(Entity.Keep(player)));
	}
	
	public function testCantMoveRaiderOusidePlot() {
		var to: Pos = {x: 0, y: 0};
		var command: Command = {action: Action.Move(to), pos: from};
		Assert.isFalse(turn.runCommand(field, command, player));
		Assert.equals(field.get(from), Entity.Raider);
		Assert.equals(field.get(to), Entity.Empty);
	}
	
	public function testCantMoveSomeoneElsesRaider() {
		var to: Pos = {x: 12, y: 12};
		var command: Command = {action: Action.Move(to), pos: from};
		Assert.isFalse(turn.runCommand(field, command, new Player("alice")));
		Assert.equals(field.get(from), Entity.Raider);
		Assert.equals(field.get(to), Entity.Empty);
	}
	
	public function testCantStealSomeoneElsesRaider() {
		var to: Pos = {x: 12, y: 2};
		field.set(field.keepLocation(to), Entity.Keep(new Player("alice")));
		var command: Command = {action: Action.Move(to), pos: from};
		Assert.isFalse(turn.runCommand(field, command, new Player("alice")));
		Assert.equals(field.get(from), Entity.Raider);
		Assert.equals(field.get(to), Entity.Empty);
	}
	public function testCanMoveTwoRaiders() {
		var to: Pos = {x: 18, y: 12};
		var from2: Pos = {x: 16, y: 16};
		var to2: Pos = {x: 16, y: 17};
		field.set(from2, Entity.Raider);
		var command: Command = {action: Action.Move(to), pos: from};
		Assert.isTrue(turn.runCommand(field, command, player));
		Assert.equals(field.get(from), Entity.Empty);
		Assert.equals(field.get(to), Entity.Raider);
		var command: Command = {action: Action.Move(to2), pos: from2};
		Assert.isTrue(turn.runCommand(field, command, player));
		Assert.equals(field.get(from2), Entity.Empty);
		Assert.equals(field.get(to2), Entity.Raider);
	}
	public function testCantMoveToJustFreedPlace(){
		var to: Pos = {x: 18, y: 12};
		var from2: Pos = {x: 16, y: 16};
		var to2: Pos = from;
		field.set(from2, Entity.Raider);
		var command: Command = {action: Action.Move(to), pos: from};
		Assert.isTrue(turn.runCommand(field, command, player));
		Assert.equals(field.get(from), Entity.Empty);
		Assert.equals(field.get(to), Entity.Raider);
		var command: Command = {action: Action.Move(to2), pos: from2};
		Assert.isFalse(turn.runCommand(field, command, player));
		Assert.equals(field.get(from2), Entity.Raider);
		Assert.equals(field.get(to2), Entity.Empty);
	}
	public function testCantMoveRaiderTwice() {
		var to: Pos = {x: 18, y: 12};
		var from2: Pos = to;
		var to2: Pos = {x: 16, y: 17};
		var command: Command = {action: Action.Move(to), pos: from};
		Assert.isTrue(turn.runCommand(field, command, player));
		Assert.equals(field.get(from), Entity.Empty);
		Assert.equals(field.get(to), Entity.Raider);
		var command: Command = {action: Action.Move(to2), pos: from2};
		Assert.isFalse(turn.runCommand(field, command, player));
		Assert.equals(field.get(from2), Entity.Raider);
		Assert.equals(field.get(to2), Entity.Empty);
	}
}
