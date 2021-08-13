package test.util;
import utest.Assert;
import Entity;

class TestBase extends utest.Test {

	var p1: Player;
	var p2: Player;
	
	public function setup() {
		p1 = new Player("bob");
		p2 = new Player("bob");
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
	
// 	public function testEntityEquality(){
// 		Assert.equals(Entity.Keep(p1), Entity.Keep(p2));
// 	}
}
