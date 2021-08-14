
interface Error {
	public function msg(): String;
}

enum Result<S, E: Error> {
	Ok(value: S);
	Err(error: E);
}

function isOk<S, E: Error>(r: Result<S, E>): Bool {
	return switch (r){
		case Ok(v): true;
		case Err(e): false;
	}
}

function errMsg<S, E: Error>(r: Result<S, E>): String {
	return switch (r){
		case Ok(v): "";
		case Err(e): e.msg();
	}
}


enum Empty {
	__;
}
