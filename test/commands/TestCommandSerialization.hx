package test.commands;
import utest.Assert;

class TestCommandSerialization extends utest.Test {
	
	
	
	public function testDeserialize() {
		var ser = ";
			2,3:build:farm#1,0#3,3;
			2,4:build: stockpile:wood#5,0#5,3;
			3,4:build: stockpile:food;
			2,5:move:9,5;
			2,6:attack:north;
			2,7: produce:8,2;
			2,8: remove;
		";
		var commands = Commands.fromStr(ser).unwrap();
		var expected: Commands = {commands: [
			{pos: pos(2, 3), action: Build(Farm, [pos(1,0), pos(3,3)])},
			{pos: pos(2, 4), action: Build(Stockpile(Wood), [pos(5,0), pos(5,3)])},
			{pos: pos(3, 4), action: Build(Stockpile(Food), [])},
			{pos: pos(2, 5), action: Move(pos(9, 5))},
			{pos: pos(2, 6), action: Attack(North)},
			{pos: pos(2, 7), action: Produce(pos(8,2))},
			{pos: pos(2, 8), action: Remove}
		]};
		Assert.same(commands, expected);
	}
	
	public function testReserialize() {
		var commands: Commands = {commands: [
			{pos: pos(2, 3), action: Build(Farm, [pos(1,0), pos(3,3)])},
			{pos: pos(2, 4), action: Build(Stockpile(Wood), [pos(5,0), pos(5,3)])},
			{pos: pos(3, 4), action: Build(Stockpile(Food), [])},
			{pos: pos(2, 5), action: Move(pos(9, 5))},
			{pos: pos(2, 6), action: Attack(North)},
			{pos: pos(2, 7), action: Produce(pos(8,2))},
			{pos: pos(2, 8), action: Remove}
		]};
		var ser = commands.toStr();
		var des = Commands.fromStr(ser).unwrap();
		Assert.same(commands, des);
	}
}
