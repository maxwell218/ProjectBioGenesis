// When an item is added to the inventory/hotbar, we create an inventory item
// Some items can be stacked, therefore the amount variable is going to be higher than 1, up to the global max stacksize
function InventoryItem(_item_data = undefined, _amount = 1) constructor {
	item_data = _item_data;		// Struct.Item
	amount = _amount;			// The amount of items, up to max stacksize
	
	#region InventoryItem Properties
	
	function draw_inventory_item() {
		// Draw icon
		draw_sprite_ext(spr_inventory_icon, item_data.icon_id, x + _margin, y + (_margin * (_i + 1)) + (global.tile_size * _i), 1, 1, 0, c_white, 1);
					
		// Draw amount
	}
	
	#endregion
}