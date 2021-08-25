package esloph;

using esloph.StrTools;

final class StrTools{
	static final spacesLeft = ~/^[ \r\n\t]*/;
	static final spacesRight = ~/[ \r\n\t]*$/;
	
	
	public static function trim(str: String): String {
		return spacesRight.replace(spacesLeft.replace(str, ""), "");
	}
	
	public static function partition(str: String, delimiter: String): Array<String> {
		var idx = str.indexOf(delimiter);
		if (idx < 0) {
			return [str, ""];
		}
		return [str.substring(0, idx), str.substring(idx + delimiter.length)];
	}
	
	public static function partitionTrim(str: String, delimiter: String): Array<String> {
		var p = str.partition(delimiter);
		return [p[0].trim(), p[1].trim()];
	}
}
