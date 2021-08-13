import Pos;

enum Action {
	Claim;
	Build(ent: Entity);
	Move(to: Pos);
	Attack(dir: Direction);
}

@:structInit final class Command {
	public final action: Action;
	public final pos: Pos;
}
