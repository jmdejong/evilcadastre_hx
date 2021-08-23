

class Utils {

	macro public static function tryOption<T>(e: ExprOf<Option<T>>){
		return macro 
			switch ($e) {
				case Some(t): t;
				case None: return None;
			}
		
	}

}
