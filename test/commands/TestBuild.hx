package test.commands;
import utest.Assert;

class TestBuild extends utest.Test {


	var cadastre: Cadastre;
	var field: Field;
	var keepLocation: Pos;
	var turn: Turn;
	
	public function setup(){
	
		cadastre = Cadastre.square(10);
		field = Field.empty({x: 30, y: 30}, cadastre);
		keepLocation = cadastre.keepLocation({x: 11, y: 11});
		field.set(keepLocation, Entity.Keep(new Player("bob")));
		field.set({x: 11, y: 13}, Entity.Forest);
		field.set({x: 8, y: 13}, Entity.Forest);
		turn = new Turn();
	}
	
	public function testCanBuildWoodcutterNearForest() {
		var pos: Pos = {x: 11, y: 12};
		var command: Command = {action: Action.Build(Entity.Woodcutter), pos: pos};
		Assert.isTrue(turn.runCommand(field, command, new Player("bob")));
		Assert.equals(field.get(pos), Entity.Woodcutter);
	}
	
	public function testCantBuildWoodcutterAwayFromForest() {
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Action.Build(Entity.Woodcutter), pos: pos};
		Assert.isFalse(turn.runCommand(field, command, new Player("bob")));
		Assert.equals(field.get(pos), Entity.Empty);
	}
	
	public function testCantBuildWoodcutterOnTopOfForest() {
		var pos: Pos = {x: 11, y: 13};
		var command: Command = {action: Action.Build(Entity.Woodcutter), pos: pos};
		Assert.isFalse(turn.runCommand(field, command, new Player("bob")));
		Assert.equals(field.get(pos), Entity.Forest);
	}
	
	public function testCantBuildWoodcutterOutsidePlot() {
		var pos: Pos = {x: 9, y: 13};
		var command: Command = {action: Action.Build(Entity.Woodcutter), pos: pos};
		Assert.isFalse(turn.runCommand(field, command, new Player("bob")));
		Assert.equals(field.get(pos), Entity.Empty);
	}
}
