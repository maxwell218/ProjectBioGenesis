/// @description Setup Items
enum ItemType {
	Material,
	Misc,
	Ammunition,
	Tool,
	Consumable,
	LightSource,
	MeleeWeapon,
	RangedWeapon,
	Armor,
};

enum RecipeType {
	Crafting,
	Repair,
};

// TODO When reading items from saves, get the id from the enum in case we added new items in a new version of the game
//enum ItemId {
	
//	// Consumables
//	Bandage = 2,
	
//	// Light Sources
//	LanternLit = 3,
//	Lantern = 4,
	
//	// Ammunition
//	PistolMag = 5,
//	ShotgunShell = 6,
	
//	// Ranged Weapons
//	Pistol = 7,
//	Shotgun = 8,
	
//	// Melee Weapons
//	Shovel = 9,
//}

// Item Data
global.item_data = [];			// Array of Struct.Item
global.player_inventory = [];	// Array of Struct.Item
global.player_hotbar = [];		// Array of Struct.Item
index = { icon_id: 2 };			// Used as an image_index tracker for spr_inventory_icon

#region Functions

// Returns the Struct.Item of the given name
// If an item can't be found, returns undefined instead
function get_item_data_by_name(_name="") {
	for (var _i = 0; _i < array_length(global.item_data); _i++) {
		if (global.item_data[_i].name == _name) {
			return global.item_data[_i];
		}
	}
	
	return undefined
}

// Returns the current index's icon_id value
function get_index_value() {
	var _value = variable_struct_get(index, "icon_id");
	return _value;	
}

// Increments the current index's icon_id value
function increment_index_value() {
	index.icon_id++;
}

#endregion

// We create items in a specific order, based on spr_inventory_icon
// Each time an item is created, the index declared above gets assigned to the item and is then incremented for the next item
// This can create problems if new items are created between game versions, since save files won't support the new ids stored in them

// General order:
// Materials, Misc, Tools
// Recipes
// Ammunition
// Consumables
// Light Sources
// Weapons
// Armor
#region Items & Recipes

	#region Consumables
	
	new Item("Bandage", "", ItemType.Consumable, 40, 3);
	
	#endregion

	#region Light Sources
	
	new Item("Lantern Lit", "", ItemType.LightSource, 100, 1);
	new Item("Lantern", "", ItemType.LightSource, 100, 1);
	
	#endregion

	#region Ammunition
	
	new Item("Pistol Mag", "", ItemType.Ammunition, 100, 2,
		new ItemAmmunition(1, 7));
		
	new Item("Shotgun Shell", "", ItemType.Ammunition, 80, global.max_stacksize,
		new ItemAmmunition(3, 1));
		
	#endregion
	
	#region Ranged Weapons

	new Item("Pistol", "", ItemType.RangedWeapon, 100, 1,
		new ItemRangedWeapon(3, 60, 45, get_item_data_by_name("Pistol Mag")));
		
	new Item("Shotgun", "", ItemType.RangedWeapon, 200, 1,
		new ItemRangedWeapon(3, 120, 75, get_item_data_by_name("Shotgun Shell")));

	#endregion
	
	#region Melee Weapons

	new Item("Shovel", "", ItemType.MeleeWeapon, 100, 1,
		new ItemMeleeWeapon(4, 4, 40));

	#endregion

#endregion

inventory = new Inventory();
inventory.init_inventory();

struct_remove(index, "icon_id");
delete index;