package test.misc;
import utest.Assert;
import Entity;

class TestField extends utest.Test {
	
// 	public function testEmptySerialize() {
// 		var cadastre: Cadastre = Cadastre.square(10);
// 		var field: Field = Field.empty({x: 30, y: 30}, cadastre);
// 		var ser: String = Field.serialize();
// 		
// 	}

	public function testDeserialize(){
		var ser = "
		field_size: 100,100;
		cadastre: rect:10,10;
		;
		0,0:raider;
		5 ,5: keep:bob;
		4, 6: woodcutter
		;
		4 , 7: forest;
		12,15 : forest
		;9, 11 :farm;
		";
		var field = switch (Field.deserialize(ser)) {
			case Some(f): f;
			case None: 
				Assert.fail("Field not deserializable");
				return;
		};
		Assert.same(field.get(pos(0, 0)), Raider);
		Assert.same(field.get(pos(0, 1)), Empty);
		Assert.same(field.get(pos(5, 5)), Keep(new Player("bob")));
		Assert.same(field.get(pos(4, 6)), Woodcutter);
		Assert.same(field.get(pos(4, 7)), Forest);
		Assert.same(field.get(pos(12, 15)), Forest);
		Assert.same(field.get(pos(9, 11)), Farm);
		Assert.same(field.owner(pos(0,0)), Some(new Player("bob")));
		Assert.same(field.owner(pos(9,9)), Some(new Player("bob")));
		Assert.same(field.owner(pos(10,9)), None);
		Assert.same(field.owner(pos(10,10)), None);
		Assert.same(field.owner(pos(9,10)), None);
	}
}
