package evil;

@:structInit final class ParseError implements ResultError {
	public final error: String;
	
	public function msg(): String {
		return error;
	}
	
// 	macro public static function tryParseSome<T>(e: ExprOf<Option<T>>, msg: ExprOf<String>){
// 		return macro 
// 			switch ($e) {
// 				case Some(t): t;
// 				case None: return Err(msg);
// 			}
// 	}
}

function parseErr(msg: String): ParseError {
	return {error: msg};
}
