package tiph;

interface ResultError {
	public function msg(): String;
}

enum Result_<S, E: ResultError> {
	Ok(value: S);
	Err(error: E);
}

abstract Result<S, E: ResultError>(Result_<S, E>) from Result_<S, E> {
	public function isOk(): Bool {
		return switch (this){
			case Ok(v): true;
			case Err(e): false;
		}
	}

	public function errMsg(): String {
		return switch (this){
			case Ok(v): "";
			case Err(e): e.msg();
		}
	}
}

/*
function isOk<S, E: ResultError>(r: Result<S, E>): Bool {
	return switch (r){
		case Ok(v): true;
		case Err(e): false;
	}
}

function errMsg<S, E: ResultError>(r: Result<S, E>): String {
	return switch (r){
		case Ok(v): "";
		case Err(e): e.msg();
	}
}*/

enum Empty {
	__;
}
