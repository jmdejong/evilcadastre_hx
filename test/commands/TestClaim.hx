package test.commands;
import utest.Assert;

class TestClaim extends utest.Test {
	
	var cadastre: Cadastre;
	var field: Field;
	var keepLocation: Pos;
	var turn: Turn;
	
	public function setup(){
	
		cadastre = Cadastre.square(10);
		field = Field.empty({x: 30, y: 30}, cadastre);
		keepLocation = cadastre.keepLocation({x: 11, y: 11});
		turn = new Turn();
	}
	
	public function testSuccessfullFirstClaim() {
		Assert.same(field.owner({x: 11, y: 11}), None);
		Assert.same(field.owner(keepLocation), None);
		Assert.same(field.get(keepLocation), Empty);
		var command: Command = {action: Action.Claim, pos: keepLocation};
		assertOk(turn.runCommand(field, command, new Player("bob")));
		Assert.same(field.owner(keepLocation), Some(new Player("bob")));
		Assert.same(field.owner({x: 11, y: 11}), Some(new Player("bob")));
		Assert.same(field.get(keepLocation), Keep(new Player("bob")));
		Assert.same(field.get({x: 11, y: 11}), Empty);
		Assert.same(field.owner({x: 1, y: 1}), None);
		Assert.same(field.get({x: 1, y: 1}), Empty);
	}
	
	public function testUnsuccessfulSecondClaim() {
		field.set(cadastre.keepLocation({x: 1, y: 1}), Keep(new Player("bob")));
		var command: Command = {action: Action.Claim, pos: keepLocation};
		assertErr(turn.runCommand(field, command, new Player("bob")));
		Assert.same(field.get(keepLocation), Empty);
		Assert.same(field.owner({x: 11, y: 11}), None);
	}
	
	public function testSuccessfullFirstClaimWithOtherPlayerNearby() {
		field.set(cadastre.keepLocation({x: 1, y: 1}), Keep(new Player("alice")));
		var command: Command = {action: Action.Claim, pos: keepLocation};
		assertOk(turn.runCommand(field, command, new Player("bob")));
		Assert.same(field.owner(keepLocation), Some(new Player("bob")));
		Assert.same(field.owner({x: 11, y: 11}), Some(new Player("bob")));
		Assert.same(field.get(keepLocation), Keep(new Player("bob")));
		Assert.same(field.get({x: 11, y: 11}), Empty);
		Assert.same(field.owner({x: 1, y: 1}), Some(new Player("alice")));
		Assert.same(field.get({x: 1, y: 1}), Empty);
	}
	
	public function testSuccessfullFirstClaimForClaimedLand() {
		field.set(cadastre.keepLocation(keepLocation), Keep(new Player("alice")));
		var command: Command = {action: Action.Claim, pos: keepLocation};
		assertErr(turn.runCommand(field, command, new Player("bob")));
		Assert.same(field.owner(keepLocation), Some(new Player("alice")));
		Assert.same(field.owner({x: 11, y: 11}), Some(new Player("alice")));
		Assert.same(field.get(keepLocation), Keep(new Player("alice")));
	}
}
