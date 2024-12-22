/// @description Setup Items
enum ItemType {
	Misc,
	Ammo,
	Material,
	Tool,
	MeleeWeapon,
	RangedWeapon,
	Consumable,
	Armor,
};

enum RecipeType {
	Crafting,
	Repair,
};

// Item Data
// TODO use a ds_map so that we can get items by name if need be (crafting recipe, repair recipe, etc)
// OR have custom functions for looking up items in the item_data array here
global.item_data = [];

// Create items in a specific order
// Materials, Ammo, Misc, Tools
// Recipes
// Consumables
// Weapons
// Armor
#region Items & Recipes

	#region Melee Weapons

	new Item("Shovel", "", ItemType.MeleeWeapon, 100, undefined, 1,
		new ItemMeleeWeapon());

	#endregion
	
	#region Ranged Weapons

	new Item("Pistol", "", ItemType.RangedWeapon, 100, undefined, 1,
		new ItemRangedWeapon());

	#endregion

#endregion

#region Functions

// Returns the item struct of the given name
// If an item can't be found, returns undefined instead
function get_item_by_name(_name="") {
	for (var _i = 0; _i < array_length(global.item_data); _i++) {
		if (global.item_data[_i].name == _name) {
			return global.item_data[_i];
		}
	}
	
	return undefined
}

#endregion