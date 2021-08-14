

enum Item {
	Wood;
	Food;
	NoItem;
}


enum Entity {
	Keep(owner: Player);
	Raider;
	Woodcutter;
	Farm;
	Forest;
	Empty;
	Stockpile(item: Item);
}
