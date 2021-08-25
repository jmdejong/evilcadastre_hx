import utest.Assert;



function assertOk<E: ResultError>(v: Result<Empty, E>) {
	Assert.same(Ok(__), v, true, v.errMsg());
}
function assertErr<E: ResultError>(v: Result<Empty, E>) {
	Assert.isFalse(v.isOk(), "expected Err(...)");
}
