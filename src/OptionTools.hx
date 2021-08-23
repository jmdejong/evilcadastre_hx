

class UnwrapException extends haxe.Exception {}

final class OptionTools {

	public static function map<S, T>(x: Option<S>, f: S -> T): Option<T> {
		return switch (x) {
			case Some(s): Some(f(s));
			case None: None;
		}
	}
	
	public static function andThen<S, T>(x: Option<S>, f: S -> Option<T>): Option<T> {
		return switch (x) {
			case Some(s): f(s);
			case None: None;
		}
	}
	
	public static function unwrap<T>(x: Option<T>): T {
		return switch (x) {
			case Some(s): s;
			case None:
				throw new UnwrapException("Unwrapping option with None value");
		}
	}
}
