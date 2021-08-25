package esloph.prelude;
import haxe.ds.Option;

//external
typedef Option<T> = haxe.ds.Option<T>;


typedef ResultError = esloph.Result.ResultError;
typedef Empty = esloph.Result.Empty;
typedef ResultTools = esloph.Result.ResultTools;
typedef Result<S, E: ResultError> = esloph.Result.Result<S, E>;
typedef OptionTool = esloph.OptionTools.OptionTools;
typedef UnwrapException = esloph.OptionTools.UnwrapException;
typedef Dict<K, V> = esloph.Dict.Dict<K, V>;
typedef Set<T> = esloph.Set.Set<T>;
typedef StrTools = esloph.StrTools.StrTools;
