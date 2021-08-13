package test.util;
import utest.Assert;

class TestDict extends utest.Test {
	
	public function testDict() {
		var d: Dict<Pos, Bool> = Dict.empty();
		Assert.equals(d.get({x: 3, y: 3}), None);
		d.set({x: 3, y: 3}, true);
		Assert.same(d.get({x: 3, y: 3}), Some(true));
		Assert.equals(d.get({x: 3, y: 2}), None);
		Assert.isTrue(d.getOr({x: 3, y: 3}, false));
		Assert.isFalse(d.getOr({x: 2, y: 3}, false));
	}
}
