// The inventory class takes care of both the hotbar and inventory of the player
function Inventory(_slots = 8, _width = 2) constructor {
	slots = _slots;
	width = _width;
	
	x = 0;
	y = 0;
	
	// height is determined by the width
	height = slots / width;
	
	#region Inventory Properties
	
	function init_inventory() {
		
		// Initialize each index to undefined (no item)
		for (var _i = 0; _i < slots; _i++) {
			
			global.player_inventory[_i]	= undefined;
			
			// TODO Load inventory from save
		}
	}
	
	function add_item_to_inventory() {
		
	}
	
	function draw_hotbar() {
		var _margin = 2;
		
		for (var _i = 0; _i < array_length(global.item_data); _i++) {
			
			// Draw background
			draw_sprite_ext(spr_inventory_icon, 0, x + _margin, y + (_margin * (_i + 1)) + (global.tile_size * _i), 1, 1, 0, c_white, 1);
		
			// Draw icon
			draw_sprite_ext(spr_inventory_icon, global.item_data[_i].icon_id, x + _margin, y + (_margin * (_i + 1)) + (global.tile_size * _i), 1, 1, 0, c_white, 1);
		
			// Draw selected
			draw_sprite(spr_inventory_icon, 1, x + _margin, y + _margin);
		}
	}
	
	function draw_inventory() {
		var _margin = 2;
		
		for (var _row = 0; _row < height; _row++) {
			for (var _col = 0; _col < width; _col++) {
				
				// Get the index for the array
				var _index = _row * width + _col;
				
				// TODO GUI Scale
				var _x_offset = _margin * 2 + global.tile_size;
				var _y_offset = _margin;
				var _xx = x + _col * (global.tile_size + _margin) + _x_offset;
				var _yy = y + _row * (global.tile_size + _margin) + _y_offset;
				
				// Draw background
				draw_sprite_ext(spr_inventory_icon, 0, _xx, _yy, 1, 1, 0, c_white, 1);
		
				// Check if there is an item
				if (global.player_inventory[_index] != undefined) {
					
					// Draw icon and amount
					global.player_inventory[_index].draw_inventory_item();
					
				}
				
			}
		}
	}
	
	#endregion
}