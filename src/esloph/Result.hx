package esloph;


interface ResultError {
	public function msg(): String;
}

enum Result<S, E: ResultError> {
	Ok(value: S);
	Err(error: E);
}


final class ResultTools {
	public static function isOk<S, E: ResultError>(r: Result<S, E>): Bool {
		return switch (r){
			case Ok(v): true;
			case Err(e): false;
		}
	}

	public static function errMsg<S, E: ResultError>(r: Result<S, E>): String {
		return switch (r){
			case Ok(v): "";
			case Err(e): e.msg();
		}
	}
}

enum Empty {
	__;
}
