function Inventory(_slots = 8, _width = 2) constructor {
	slots = _slots;
	width = _width;
	
	// Height is determined by the width and number of slots
	height = slots / width;
	
	margin = 2;
	hotbar_spacing = 8;
	
	start_x = margin + global.tile_size + hotbar_spacing;
	start_y = margin;
	gui_width = start_x + global.tile_size * width + margin - 1;
	gui_height = start_y + global.tile_size * height + margin * (height - 1) - 1;
	
	hovered_cell = undefined;
	
	#region Inventory Properties
	
	function init_inventory() {
		
		// Initialize each index to undefined (no item)
		for (var _i = 0; _i < slots; _i++) {
			
			global.player_inventory[_i]	= undefined;
			
			// TODO Load inventory from save
		}
	}
	
	function get_cell_data(_cell) {
		if (_cell != undefined) {
			if (_cell < array_length(global.player_inventory) && _cell > 0) {
				return global.player_inventory[_cell];	
			}
		}
	}
	
	function draw_inventory() {
		
		// Get mouse coords on the gui layer
		var _mouse_gui_x = device_mouse_x_to_gui(0);
		var _mouse_gui_y = device_mouse_y_to_gui(0);

		for (var _row = 0; _row < height; _row++) {
			for (var _col = 0; _col < width; _col++) {
				
				// Get the index for the array
				var _index = _row * width + _col;
				
				// TODO GUI Scale
				var _x_offset = start_x;
				var _y_offset = start_y;
				
				var _xx = _col * (global.tile_size + margin) + _x_offset;
				var _yy = _row * (global.tile_size + margin) + _y_offset;
				
				// Check if there is an item
				if (global.player_inventory[_index] != undefined) {	
					
					var _item = global.player_inventory[_index];
					
					// Draw background
					draw_sprite_ext(spr_inventory_bg, 0, _xx, _yy, 1, 1, 0, c_white, 1);
					
					// Draw icon and amount
					_item.draw_inventory_item(_xx, _yy);
					
				} else {
					// Draw empty background
					draw_sprite_ext(spr_inventory_bg, 1, _xx, _yy, 1, 1, 0, c_white, 1);
				}
			}
		}
		
		if (hovered_cell != undefined) {
					
			// Highlight the cell
			var _row = hovered_cell div width;
			var _col = hovered_cell mod width;
			
			var _cell_x = start_x + _col * (global.tile_size + margin);
			var _cell_y = start_y + _row * (global.tile_size + margin);
			
			if (global.debug) {
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
				draw_text(_mouse_gui_x, _mouse_gui_y, string(_col) + string(":") + string(_row));
			}
		}
		
		
	}
	
	#endregion
}