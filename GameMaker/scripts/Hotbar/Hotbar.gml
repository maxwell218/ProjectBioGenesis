function Hotbar() constructor {
	slots = 4;
	selected_slot = 0;
	
	margin = 2;
	width = 1;
	height = slots / width;
	
	start_x = margin;
	start_y = margin;
	
	gui_width = global.tile_size * width - 1;
	gui_height = global.tile_size * height + margin * (height - 1) - 1;
	
	hovered_cell = undefined;
	
	#region Hotbar Properties
	
	function init_hotbar() {
		for (var _i = 0; _i < slots; _i++) {
			global.player_hotbar[_i] = undefined;
		}
	}
	
	// Returns true if we are hovering inside the hotbar area
	function is_hover() {
		// Get mouse coords on the gui layer
		var _mouse_gui_x = device_mouse_x_to_gui(0);
		var _mouse_gui_y = device_mouse_y_to_gui(0);
		
		return point_in_rectangle(_mouse_gui_x, _mouse_gui_y, start_x, start_y, start_x + gui_width, start_y + gui_height);
	}
	
	function draw_hotbar() {
		draw_rectangle(start_x, start_y, start_x + gui_width, start_y + gui_height, false);
		
		for (var _i = 0; _i < array_length(global.player_hotbar); _i++) {
			
			var _xx = start_x;
			var _yy = start_y + (margin * _i) + (global.tile_size * _i);

			if (global.player_hotbar[_i] != undefined) {
				
				var _item = global.player_hotbar[_i];
				
				// Draw background
				draw_sprite_ext(spr_inventory_bg, 0, _xx, _yy, 1, 1, 0, c_white, 1);
					
				// Draw icon and amount
				_item.draw_inventory_item(_xx, _yy);
				
				// draw_sprite_ext(spr_inventory_icon, global.player_hotbar[_i].icon_id, x + _margin, y + (_margin * (_i + 1)) + (global.tile_size * _i), 1, 1, 0, c_white, 1);
				
			} else {
				// Draw empty background
				draw_sprite_ext(spr_inventory_bg, 1, _xx, _yy, 1, 1, 0, c_white, 1);
			}
			
			if (selected_slot == _i) {
				// Draw selected
				draw_sprite(spr_inventory_selected, 1, start_x, start_y);
			}
			
			if (hovered_cell == _i) {
				// Highlight the cell
				var _cell_x = start_x;
				var _cell_y = start_y + _i * (global.tile_size + margin);
				// draw_rectangle(_cell_x, _cell_y, _cell_x + global.tile_size - 1, _cell_y + global.tile_size - 1, false);
			}
		}
	}
	
	#endregion
}