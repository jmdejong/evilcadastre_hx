import Pos;

enum Action {
	Claim;
	Build(ent: Entity, resources: Array<Pos>);
	Move(to: Pos);
	Attack(dir: Direction);
	Produce(stockpile: Pos);
}

@:structInit final class Command {
	public final action: Action;
	public final pos: Pos;
}
