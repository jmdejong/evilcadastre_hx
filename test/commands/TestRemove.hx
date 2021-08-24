

package test.commands;
import utest.Assert;

class TestRemove extends utest.Test {
	
	var cadastre: Cadastre;
	var field: Field;
	var turn: Turn;
	var pile: Pos;
	var farm: Pos;
	var forest: Pos;
	var player: Player;
	
	public function setup(){
		player = new Player("bob");
		cadastre = Cadastre.square(10);
		field = Field.empty({x: 30, y: 30}, cadastre);
		field.setOwner({x: 11, y: 11}, player);
		pile = {x: 10, y: 10};
		field.set(pile, Freepile);
		forest = {x: 12, y: 11};
		field.set(forest, Forest);
		field.set({x: 12, y: 12}, Woodcutter);
		farm = {x: 18, y: 11};
		field.set(farm, Farm);
		turn = new Turn();
	}
	
	public function testCanRemoveFarm() {
		var command: Command = {action: Remove, pos: farm};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(farm), Empty);
	}
	
	public function testCantRemoveForest() {
		var command: Command = {action: Remove, pos: forest};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(forest), Forest);
	}
	public function testCantRemoveKeep() {
		var command: Command = {action: Remove, pos: field.keepLocation(farm)};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(field.keepLocation(farm)), Keep(player));
	}
}
