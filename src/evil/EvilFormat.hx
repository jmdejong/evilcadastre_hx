package evil;

@:structInit final class EvilFormat {
	public final headers: Dict<String, String>;
	public final items: Array<String>;
	
	public static function fromStr(s: String): EvilFormat {
		var headers: Dict<String, String> = Dict.empty();
		var lines: Array<String> = [];
		var readingBody = false;
		for (part in s.split(";")) {
			var l = part.trim();
			if (l == "") {
				readingBody = true;
			} else if (readingBody) {
				lines.push(l);
			} else {
				var header = l.partitionTrim(":");
				headers.set(header[0], header[1]);
			}
		};
		return {headers: headers, items: lines};
	}
	
	public function toStr(): String {
		return 
			[for (key in headers.keys()) key + ": " + headers.get(key).unwrap()].join(";\n")
			+ ";\n;\n"
			+ items.join(";\n")
			+ ";\n";
	}
	
}
