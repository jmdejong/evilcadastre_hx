

@:expose
enum Item {
	Wood;
	Food;
	NoItem;
}

@:expose
enum Entity {
	Keep(owner: Player);
	Raider;
	Woodcutter;
	Farm;
	Forest;
	Empty;
	Stockpile(item: Item);
}
