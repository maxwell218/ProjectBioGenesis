// When an item is added to the inventory/hotbar, we create an inventory item
// Some items can be stacked, therefore the amount variable is going to be higher than 1, up to the global max stacksize
function InventoryItem(_item_data = undefined, _amount = 1) constructor {
	item_data = _item_data;		// Struct.Item
	amount = _amount;			// The amount of items, up to max stacksize
	
	#region InventoryItem Properties
	
	function draw_inventory_item(_xx, _yy) {
		// Draw icon
		draw_sprite_ext(spr_inventory_icon, item_data.icon_id, _xx, _yy, 1, 1, 0, c_white, 1);
					
		// Draw amount
		if (item_data.is_stackable()) {
						
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
						
			// Draw amount
			var _amount_string = string(amount);
			var _string_width = string_width(_amount_string);
			var _string_height = string_height(_amount_string);
			draw_text_ext_transformed(_xx + global.tile_size - 1, _yy + global.tile_size + 3, _amount_string, _string_height, _string_width, 1, 1, 0);
		}
	}
	
	#endregion
}