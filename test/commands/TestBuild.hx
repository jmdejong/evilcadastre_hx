package test.commands;
import utest.Assert;
import Entity;

class TestBuild extends utest.Test {


	var cadastre: Cadastre;
	var field: Field;
	var keepLocation: Pos;
	var turn: Turn;
	var woodPile: Pos;
	var foodPile: Pos;
	var emptyPile: Pos;
	var player: Player;
	
	public function setup(){
	
		cadastre = Cadastre.square(10);
		field = Field.empty({x: 30, y: 30}, cadastre);
		keepLocation = cadastre.keepLocation({x: 11, y: 11});
		player = new Player("bob");
		field.set(keepLocation, Keep(player));
		field.set({x: 11, y: 13}, Forest);
		field.set({x: 8, y: 13}, Forest);
		woodPile = {x: 19, y: 10};
		field.set(woodPile, Stockpile(Wood));
		foodPile = {x: 19, y: 11};
		field.set(foodPile, Stockpile(Food));
		emptyPile = {x: 19, y: 12};
		field.set(emptyPile, Freepile);
		turn = new Turn();
	}
	
	public function testCanBuildWoodcutterNearForest() {
		var pos: Pos = {x: 11, y: 12};
		var command: Command = {action: Build(Woodcutter, []), pos: pos};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Woodcutter);
	}
	
	public function testCantBuildWoodcutterAwayFromForest() {
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Build(Woodcutter, []), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Empty);
	}
	
	public function testCantBuildWoodcutterOnTopOfForest() {
		var pos: Pos = {x: 11, y: 13};
		var command: Command = {action: Build(Woodcutter, []), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Forest);
	}
	
	public function testCantBuildWoodcutterOutsidePlot() {
		var pos: Pos = {x: 9, y: 13};
		var command: Command = {action: Build(Woodcutter, []), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Empty);
	}
	
	public function testCanBuildFarm() {
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Build(Farm, [woodPile]), pos: pos};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Farm);
		Assert.same(field.get(woodPile), Freepile);
	}
	
	public function testCantBuildFarmWithoutResources() {
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Build(Farm, []), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Empty);
	}
	
	public function testCantBuildFarmWithEmtpyResources() {
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Build(Farm, [emptyPile]), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Empty);
		Assert.same(field.get(emptyPile), Freepile);
	}
	
	public function testCantBuildFarmWithNonResource() {
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Build(Farm, [keepLocation]), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Empty);
		Assert.same(field.get(keepLocation), Keep(player));
	}
	
	public function testCantBuildFarmWithWrongResource() {
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Build(Farm, [foodPile]), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Empty);
		Assert.same(field.get(foodPile), Stockpile(Food));
	}
	
	public function testCantBuildFarmWithTooManyResources() {
		var woodPile2: Pos = {x: 19, y: 19};
		field.set(woodPile2, Stockpile(Wood));
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Build(Farm, [woodPile, woodPile2]), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Empty);
		Assert.same(field.get(woodPile), Stockpile(Wood));
		Assert.same(field.get(woodPile2), Stockpile(Wood));
	}
	
	public function testCantBuildFarmWithResourceInDifferentPlot() {
		var woodPile2: Pos = {x: 9, y: 19};
		field.set(woodPile2, Stockpile(Wood));
		field.set(cadastre.keepLocation(woodPile2), Keep(player));
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Build(Farm, [woodPile2]), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Empty);
		Assert.same(field.get(woodPile2), Stockpile(Wood));
	}
	
	public function testDontTakeResourcesWhenBuildingWrong() {
		var pos: Pos = {x: 11, y: 11};
		field.set(pos, Forest);
		var command: Command = {action: Build(Farm, [woodPile]), pos: pos};
		assertErr(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Forest);
		Assert.same(field.get(woodPile), Stockpile(Wood));
	}
	
	
	public function testCanBuildStockpile() {
		var pos: Pos = {x: 11, y: 11};
		var command: Command = {action: Build(Freepile, []), pos: pos};
		assertOk(turn.runCommand(field, command, player));
		Assert.same(field.get(pos), Freepile);
	}
}
