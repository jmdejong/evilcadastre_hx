package test.commands;
import utest.Assert;
import Entity;

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
		field.set(keepLocation, Keep(player));
		from = {x: 11, y: 13};
		field.set(from, Raider);
		turn = new Turn();
	}
	
	public function testCanMoveRaiderToEmptyPlace() {
		var to: Pos = {x: 18, y: 12};
		var command: Command = {action: Action.Move(to), pos: from};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(from), Empty);
		Assert.same(field.get(to), Raider);
	}
	
	public function testCantMoveRaiderToKeep() {
		var to: Pos = keepLocation;
		var command: Command = {action: Action.Move(to), pos: from};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(from), Raider);
		Assert.same(field.get(to), Keep(player));
	}
	
	public function testCantMoveRaiderOusidePlot() {
		var to: Pos = {x: 0, y: 0};
		var command: Command = {action: Action.Move(to), pos: from};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(from), Raider);
		Assert.same(field.get(to), Empty);
	}
	
	public function testCantMoveSomeoneElsesRaider() {
		var to: Pos = {x: 12, y: 12};
		var command: Command = {action: Action.Move(to), pos: from};
		assertErr(turn.runCommand(field, command, new Player("alice")));
		Assert.same(field.get(from), Raider);
		Assert.same(field.get(to), Empty);
	}
	
	public function testCantStealSomeoneElsesRaider() {
		var to: Pos = {x: 12, y: 2};
		field.set(field.keepLocation(to), Keep(new Player("alice")));
		var command: Command = {action: Action.Move(to), pos: from};
		assertErr(turn.runCommand(field, command, new Player("alice")));
		Assert.same(field.get(from), Raider);
		Assert.same(field.get(to), Empty);
	}
	public function testCanMoveTwoRaiders() {
		var to: Pos = {x: 18, y: 12};
		var from2: Pos = {x: 16, y: 16};
		var to2: Pos = {x: 16, y: 17};
		field.set(from2, Raider);
		var command: Command = {action: Action.Move(to), pos: from};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(from), Empty);
		Assert.same(field.get(to), Raider);
		var command: Command = {action: Action.Move(to2), pos: from2};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(from2), Empty);
		Assert.same(field.get(to2), Raider);
	}
	public function testCanMoveToJustFreedPlace(){
		var to: Pos = {x: 18, y: 12};
		var from2: Pos = {x: 16, y: 16};
		var to2: Pos = from;
		field.set(from2, Raider);
		var command: Command = {action: Action.Move(to), pos: from};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(from), Empty);
		Assert.same(field.get(to), Raider);
		var command: Command = {action: Action.Move(to2), pos: from2};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(from2), Empty);
		Assert.same(field.get(to2), Raider);
	}
	public function testCantMoveRaiderTwice() {
		var to: Pos = {x: 18, y: 12};
		var from2: Pos = to;
		var to2: Pos = {x: 16, y: 17};
		var command: Command = {action: Action.Move(to), pos: from};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(from), Empty);
		Assert.same(field.get(to), Raider);
		var command: Command = {action: Action.Move(to2), pos: from2};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(from2), Raider);
		Assert.same(field.get(to2), Empty);
	}
}
