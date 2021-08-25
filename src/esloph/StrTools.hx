package esloph;

using StringTools;

final class StrTools {
	
	public static function partition(str: String, delimiter: String): Array<String> {
		var idx = str.indexOf(delimiter);
		if (idx < 0) {
			return [str, ""];
		}
		return [str.substring(0, idx), str.substring(idx + delimiter.length)];
	}
	
	public static function partitionTrim(str: String, delimiter: String): Array<String> {
		var p = StrTools.partition(str, delimiter);
		return [p[0].trim(), p[1].trim()];
	}
}
