function Item(_name = "", _desc = "", _type = ItemType.Misc, _price = 0, _icon = undefined, _stacksize = global.max_stacksize, _stats = undefined) constructor {
	name = _name;						// Name of the item
	desc = _desc;						// Tooltip description
	type = _type;						// Type of item
	price = _price;						// Buy price, sell price is half rounded up
	icon = _icon;						// Icon display sprite
	stacksize = _stacksize;				// Max stacks for the same item
	// transfer_sound = _transfer_sound;// Moving items around the ui (on_pickup and on_putdown with pitch alteration)
	stats = _stats;						// For ItemMeleeWeapon, ItemRangedWeapon, ItemConsumable, ItemAmmunition, ItemArmor
	
	array_push(global.item_data, self); // Add the item to the item_data array
	
	#region Item Properties
	
	// Returns true if an item can stack
	function is_stackable() {
		return stacksize > 1;
	}
	
	// Returns the sell value of an item
	function get_sell_price() {
		return ceil(price / 2);	
	}
	
	#endregion
	
}

function ItemMeleeWeapon(_damage = 0, _stamina_cost = 0, _durability = 0, _crafting_recipe = undefined, _repair_recipe = undefined) constructor {
	damage = _damage;
	stamina_cost = _stamina_cost;
	durability = _durability;
	crafting_recipe = _crafting_recipe;
	repair_recipe = _repair_recipe;
	
	#region MeleeWeapon Properties
	
	// Returns true if a melee weapon can be crafted
	function is_craftable() {
		return crafting_recipe != undefined;
	}
	
	// Returns true if a melee weapon can be repaired
	function is_repairable() {
		return repair_recipe != undefined;	
	}
	
	#endregion
}

function ItemRangedWeapon(_damage = 0, _fire_rate = 0, _accuracy = 0, _crafting_recipe = undefined, _ammunition = undefined) constructor {
	damage = _damage;
	fire_rate = _fire_rate;
	accuracy = _accuracy;
	crafting_recipe = _crafting_recipe;
	ammunition = _ammunition;
	
	#region RangedWeapon Properties
	
	// Returns true if a ranged weapon can be crafted
	function is_craftable() {
		return crafting_recipe != undefined;
	}
	
	#endregion
}

function Recipe(_type = RecipeType.Crafting, _workbench_level = 0, _ingredients = []) constructor {
	type = _type;
	workbench_level = _workbench_level;
	ingredients = _ingredients;
}