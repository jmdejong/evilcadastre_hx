package test.misc;
import utest.Assert;

class TestUtest extends utest.Test {
	
	public function testTrue() {
		Assert.equals(3, 3);
	}
	
	public function testEquality(){
		Assert.isTrue(Some(true).equals(Some(true)));
		Assert.isFalse(Some(true).equals(Some(false)));
		Assert.equals(true, true);
		Assert.notEquals(false, true);
		Assert.isTrue(Type.enumEq(Some(true), Some(true)));
		Assert.isFalse(Type.enumEq(Some(true), Some(false)));
		Assert.notEquals(Some(true), Some(false));
		Assert.notEquals(Some(true), Some(true)); // this equality is not by value
		Assert.same(Some(true), Some(true));
	}
	
	public function testStringEquality() {
		var a: String = "hello";
		var b: String = "hello";
		Assert.equals(a, b);
	}
	
}
