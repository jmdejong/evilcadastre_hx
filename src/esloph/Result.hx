package esloph;
import esloph.OptionTools;

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
	
	public static function unwrap<S, E: ResultError>(r: Result<S, E>): S {
		return switch (r) {
			case Ok(s): s;
			case Err(e):
				throw new UnwrapException('Unwrapping result with Err(${e.msg()})');
		}
	}
	
	macro public static function tryOk<T, E: ResultError>(e: ExprOf<Result<T, E>>){
		return macro 
			switch ($e) {
				case Ok(t): t;
				case Err(e): return Err(e);
			}
	}
}

enum Empty {
	__;
}
