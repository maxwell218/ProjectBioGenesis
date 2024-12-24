function Inventory(_slots = 8, _width = 2) constructor {
	slots = _slots;
	width = _width;
	
	pickup_item = undefined;
	
	// Height is determined by the width and number of slots
	height = slots / width;
	
	margin = 2;
	hotbar_spacing = 8;
	inventory_x = margin + global.tile_size + hotbar_spacing;
	inventory_y = margin;
	
	hovered_cell = undefined;
	
	#region Inventory Properties
	
	function init_inventory() {
		
		// Initialize each index to undefined (no item)
		for (var _i = 0; _i < slots; _i++) {
			
			global.player_inventory[_i]	= undefined;
			
			// TODO Load inventory from save
		}
	}
	
	function get_mouse_cell_coord() {
		
		// Get mouse coords on the gui layer
		var _mouse_gui_x = device_mouse_x_to_gui(0);
		var _mouse_gui_y = device_mouse_y_to_gui(0);
		
		// Cell starting position
		var _start_x = inventory_x;
		var _start_y = inventory_y;
		
		// Adjust mouse position relative to the grid
		var _relative_x = _mouse_gui_x - _start_x;
		var _relative_y = _mouse_gui_y - _start_y;

		// Calculate the row and column the mouse is hovering over
		var _col = floor(_relative_x / (global.tile_size + margin));
		var _row = floor(_relative_y / (global.tile_size + margin));
		
		// Check if the row and column are within bounds
		if (_col >= 0 && _col < width && _row >= 0 && _row < height) {
		    
			// Highlight the cell
		    var _cell_x = _start_x + _col * (global.tile_size + margin);
		    var _cell_y = _start_y + _row * (global.tile_size + margin);
			
			
			// Check if the mouse is inside the actual cell, excluding the margin
		    if (_mouse_gui_x >= _cell_x && _mouse_gui_x < _cell_x + global.tile_size &&
		        _mouse_gui_y >= _cell_y && _mouse_gui_y < _cell_y + global.tile_size) {
					
				var _index = _row * width + _col;
				
				// Highlight the cell
				hovered_cell = _index;
				return;
		    } 
		} 
		
		hovered_cell = undefined;
	}
	
	function add_item_to_inventory(_item_data) {
			
		for (var _i = 0; _i < array_length(global.player_inventory); _i++) {
			// Find first undefined cell
			if (global.player_inventory[_i] == undefined) {
				// TODO Get rid of hard coded amount value;
				global.player_inventory[_i] = new InventoryItem(_item_data, 1);
				return;
			}
				
			// Existing stack of the same item
				// If the stack fits (add amount, delete pickup item)
				// If the stack doesn't fit (transfer and keep overflow)
			// Different item, we switch it with the pickup item
		}
	}
	
	function draw_inventory() {
		
		// Cell starting position
		var _start_x = inventory_x;
		var _start_y = inventory_y;
		
		for (var _row = 0; _row < height; _row++) {
			for (var _col = 0; _col < width; _col++) {
				
				// Get the index for the array
				var _index = _row * width + _col;
				
				// TODO GUI Scale
				var _x_offset = inventory_x;
				var _y_offset = inventory_y;
				var _xx = _col * (global.tile_size + margin) + _x_offset;
				var _yy = _row * (global.tile_size + margin) + _y_offset;
				
				
				
				// Check if there is an item
				if (global.player_inventory[_index] != undefined) {
					
					// Draw background
					draw_sprite_ext(spr_inventory_bg, 0, _xx, _yy, 1, 1, 0, c_white, 1);
					
					// Draw icon and amount
					global.player_inventory[_index].draw_inventory_item(_xx, _yy);
					
				} else {
					// Draw empty background
					draw_sprite_ext(spr_inventory_bg, 1, _xx, _yy, 1, 1, 0, c_white, 1);
				}
			}
		}
		
		// Draw on top of the inventory
		for (var _row = 0; _row < height; _row++) {
			for (var _col = 0; _col < width; _col++) {
				
				// Get the index for the array
				var _index = _row * width + _col;
				
				if (_index == hovered_cell) {
					
					// Highlight the cell
					var _cell_x = _start_x + _col * (global.tile_size + margin);
					var _cell_y = _start_y + _row * (global.tile_size + margin);
					draw_rectangle(_cell_x, _cell_y, _cell_x + global.tile_size - 1, _cell_y + global.tile_size - 1, false);
					
					// Perform actions for the hovered cell
					draw_text(mouse_x, mouse_y, string(_col) + string(":") + string(_row));
				}
			}	
		}
	}
	
	#endregion
}