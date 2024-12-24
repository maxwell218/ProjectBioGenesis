function Item(_name = "", _desc = "", _type = ItemType.Misc, _price = 0, _max_stacksize = global.max_stacksize, _stats = undefined) constructor {
	
	// Get the id from our index tracker
	// var _value = variable_struct_get(_index_struct, "icon_id");
	
	icon_id = obj_inventory_controller.get_index_value();	// Acts as an identifier and an image_index
	name = _name;											// Name of the item
	desc = _desc;											// Tooltip description
	type = _type;											// Type of item
	price = _price;											// Buy price, sell price is half rounded up
	max_stacksize = _max_stacksize;									// Max stacks for the same item
	// transfer_sound = _transfer_sound;					// Moving items around the ui (on_pickup and on_putdown with pitch alteration)
	stats = _stats;											// For ItemMeleeWeapon, ItemRangedWeapon, ItemConsumable, ItemAmmunition, ItemArmor
	
	array_push(global.item_data, self);						// Add the item to the item_data array
	obj_inventory_controller.increment_index_value();		// Increment the indexes
	
	#region Item Properties
	
	// Returns true if an item can stack
	function is_stackable() {
		return max_stacksize > 1;
	}
	
	// Returns the sell value of an item
	function get_sell_price() {
		return ceil(price / 2);	
	}
	
	#endregion
	
}

function ItemMeleeWeapon(_damage = 0, _stamina_cost = 0, _durability = 0, _repair_recipe = undefined, _crafting_recipe = undefined) constructor {
	damage = _damage;						// Damage
	stamina_cost = _stamina_cost;			// Stamina cost on attacking
	durability = _durability;				// Weapon durability
	repair_recipe = _repair_recipe;			// Array of Struct.Item
	crafting_recipe = _crafting_recipe;		// Array of Struct.Item
	
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

function ItemRangedWeapon(_damage = 0, _fire_rate = 0, _accuracy = 0, _ammunition = undefined, _crafting_recipe = undefined) constructor {
	damage = _damage;						// Damage
	fire_rate = _fire_rate;					// Rate of fire, higher values mean slower rate
	accuracy = _accuracy;					// Accuracy determines the min angle of the aiming cone, lower values mean more accurate
	ammunition = _ammunition;				// Struct.ItemAmmunition
	crafting_recipe = _crafting_recipe;		// Array of Struct.Item
	
	#region RangedWeapon Properties
	
	// Returns true if a ranged weapon can be crafted
	function is_craftable() {
		return crafting_recipe != undefined;
	}
	
	#endregion
}

function ItemAmmunition(_projectile_count = 1, _bullet_per_mag = 1) constructor {
	projectile_count = _projectile_count;	// Bullet/pellet fired each shot
	bullet_per_mag = _bullet_per_mag;		// Bullet count for 1 mag (1 of itself)
}

function Recipe(_type = RecipeType.Crafting, _workbench_level = 0, _ingredients = []) constructor {
	type = _type;							// Crafting or repair
	workbench_level = _workbench_level;		// Workbench level to unlock
	ingredients = _ingredients;				// Array of Struct.Item
}