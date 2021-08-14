import utest.Assert;




function assertOk<E: Error>(v: Result<Empty, E>) {
	Assert.same(Ok(__), v, true, errMsg(v));
}
function assertErr<E: Error>(v: Result<Empty, E>) {
	Assert.isFalse(isOk(v), "expected Err(...)");
}