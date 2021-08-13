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
		Assert.equals(field.owner({x: 11, y: 11}), None);
		Assert.equals(field.owner(keepLocation), None);
		Assert.equals(field.get(keepLocation), Entity.Empty);
		var command: Command = {action: Command.Action.Claim, pos: keepLocation};
		Assert.isTrue(turn.runCommand(field, command, new Player("bob")));
		Assert.isTrue(field.owner(keepLocation).equals(Some(new Player("bob"))));
		Assert.isTrue(field.owner({x: 11, y: 11}).equals(Some(new Player("bob"))));
		Assert.isTrue(field.get(keepLocation).equals(Entity.Keep(new Player("bob"))));
		Assert.equals(field.get({x: 11, y: 11}), Entity.Empty);
		Assert.equals(field.owner({x: 1, y: 1}), None);
		Assert.equals(field.get({x: 1, y: 1}), Entity.Empty);
	}
	
	public function testUnsuccessfulSecondClaim() {
		field.set(cadastre.keepLocation({x: 1, y: 1}), Entity.Keep(new Player("bob")));
		var command: Command = {action: Command.Action.Claim, pos: keepLocation};
		Assert.isFalse(turn.runCommand(field, command, new Player("bob")));
		Assert.equals(field.get(keepLocation), Entity.Empty);
		Assert.equals(field.owner({x: 11, y: 11}), None);
	}
	
	public function testSuccessfullFirstClaimWithOtherPlayerNearby() {
		field.set(cadastre.keepLocation({x: 1, y: 1}), Entity.Keep(new Player("alice")));
		var command: Command = {action: Command.Action.Claim, pos: keepLocation};
		Assert.isTrue(turn.runCommand(field, command, new Player("bob")));
		Assert.isTrue(field.owner(keepLocation).equals(Some(new Player("bob"))));
		Assert.isTrue(field.owner({x: 11, y: 11}).equals(Some(new Player("bob"))));
		Assert.isTrue(field.get(keepLocation).equals(Entity.Keep(new Player("bob"))));
		Assert.equals(field.get({x: 11, y: 11}), Entity.Empty);
		Assert.isTrue(field.owner({x: 1, y: 1}).equals(Some(new Player("alice"))));
		Assert.equals(field.get({x: 1, y: 1}), Entity.Empty);
	}
	
	public function testSuccessfullFirstClaimForClaimedLand() {
		field.set(cadastre.keepLocation(keepLocation), Entity.Keep(new Player("alice")));
		var command: Command = {action: Command.Action.Claim, pos: keepLocation};
		Assert.isFalse(turn.runCommand(field, command, new Player("bob")));
		Assert.isTrue(field.owner(keepLocation).equals(Some(new Player("alice"))));
		Assert.isTrue(field.owner({x: 11, y: 11}).equals(Some(new Player("alice"))));
		Assert.isTrue(field.get(keepLocation).equals(Entity.Keep(new Player("alice"))));
	}
}
