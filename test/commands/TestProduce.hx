package test.commands;
import utest.Assert;
import Entity;

class TestProduce extends utest.Test {
	
	var cadastre: Cadastre;
	var field: Field;
	var turn: Turn;
	var pile: Pos;
	var pile2: Pos;
	var farm: Pos;
	var forest: Pos;
	var player: Player;
	
	public function setup(){
		player = new Player("bob");
		cadastre = Cadastre.square(10);
		field = Field.empty({x: 30, y: 30}, cadastre);
		field.setOwner({x: 11, y: 11}, player);
		pile = {x: 10, y: 10};
		field.set(pile, Stockpile(NoItem));
		pile2 = {x: 10, y: 11};
		field.set(pile2, Stockpile(NoItem));
		forest = {x: 12, y: 11};
		field.set(forest, Forest);
		field.set({x: 12, y: 12}, Woodcutter);
		farm = {x: 18, y: 11};
		field.set(farm, Farm);
		turn = new Turn();
	}
	
	public function testCanProduceWood() {
		var command: Command = {action: Produce(pile), pos: forest};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(pile), Stockpile(Wood));
	}
	
	public function testCanProduceFood() {
		var command: Command = {action: Produce(pile), pos: farm};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(pile), Stockpile(Food));
	}
	
	public function testCantProduceWoodWithoutWoodcutter() {
		var forest2: Pos = {x: 15, y: 11};
		field.set(forest2, Forest);
		var command: Command = {action: Produce(pile), pos: forest2};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pile), Stockpile(NoItem));
	}
	
	public function testCantProduceFoodForSameFarmTwice() {
		var command: Command = {action: Produce(pile), pos: farm};
		assertOk(turn.runCommand(field, command, player));
		var command2: Command = {action: Produce(pile2), pos: farm};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pile2), Stockpile(NoItem));
	}
	
	
	public function testCantProduceWoodWithWoodcutterOutsidePlot() {
		var forest2: Pos = {x: 10, y: 15};
		field.set(forest2, Forest);
		var woodcutter: Pos = {x: 9, y: 15};
		field.set(woodcutter, Woodcutter);
		field.setOwner(woodcutter, player);
		var command: Command = {action: Produce(pile), pos: forest2};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pile), Stockpile(NoItem));
	}
}
