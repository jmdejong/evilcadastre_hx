package test.util;
import utest.Assert;
import Entity;

class TestBase extends utest.Test {

	var p1: Player;
	var p2: Player;
	var k1: Entity;
	var k2: Entity;
	
	public function setup() {
		p1 = new Player("bob");
		p2 = new Player("bob");
		k1 = Keep(p1);
		k2 = Keep(p2);
	}
	
	public function testPlayerEquality() {
		Assert.equals(p1, p2);
	}
	
	public function testOptionEquality(){
		Assert.isTrue(Some(p1).equals(Some(p2)));
	}
	
	public function testEnumOptionEquality(){
		Assert.isTrue(Some(Keep(p1)).equals(Some(Keep(p2))));
	}
	
	public function testEntityEquality(){
		Assert.same(Keep(p1), Keep(p2));
		Assert.isTrue(Keep(p1).equals(Keep(p2)));
		Assert.isTrue(k1 == k2);
// 		Assert.equals(k1, k2);
	}
}
