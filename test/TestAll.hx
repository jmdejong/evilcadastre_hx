import utest.Runner;
import utest.ui.Report;

class TestAll {
	public static function main() {
		
		var runner = new Runner();
		runner.addCases(test.util);
		runner.addCases(test.commands);
		Report.create(runner);
		runner.run();
// 		utest.UTest.run([
// 			new TestUtest(),
// 			new TestDict()
// 		]);
	}
}
