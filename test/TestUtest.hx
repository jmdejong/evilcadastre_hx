
import utest.Assert;

class TestUtest extends utest.Test {
	
	public function testTrue() {
		Assert.equals(3, 3);
	}
	
	public function testFalse() {
		Assert.equals(1, 2);
	}
}
