package tiph;

using tiph.StrUtils;

final class StrUtils{
	static final spacesLeft = ~/^[ \r\n\t]*/;
	static final spacesRight = ~/[ \r\n\t]*$/;
	
	
	public static function trim(str: String): String {
		return spacesRight.replace(spacesLeft.replace(str, ""), "");
	}
	
	public static function partition(str: String, delimiter: String): PartitionedString {
		var idx = str.indexOf(delimiter);
		if (idx < 0) {
			return new PartitionedString(str, "", false);
		}
		return new PartitionedString(str.substring(0, idx), str.substring(idx + delimiter.length), true);
	}
	
	public static function partitionTrim(str: String, delimiter: String): Array<String> {
		var p = str.partition(delimiter);
		return [p.before.trim(), p.after.trim()];
	}
}

class PartitionedString {

	public final before: String;
	public final after: String;
	public final hasMatched: Bool;

	public inline function new(before: String, after: String, hasMatched) {
		this.before = before;
		this.after = after;
		this.hasMatched = hasMatched;
	}
}
