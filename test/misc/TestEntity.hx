package test.misc;
import utest.Assert;

class TestEntity extends utest.Test {
	
	public function testReserialization() {
		var entities: Array<Entity> = [
			Raider,
			Woodcutter,
			Farm,
			Forest,
			Keep(new Player("bob")),
			Keep(new Player("alice")),
			Freepile,
			Stockpile(Wood),
			Stockpile(Food),
			Empty
		];
		
		for (entity in entities) {
			var ser: String = entity.toStr();
			var deser: Option<Entity> = Entity.fromStr(ser);
			Assert.same(Some(entity), deser);
		}
	}
}
