function Hotbar() constructor {
	slots = 3;
	selected_slot = 0;
	
	margin = 2;
	hotbar_x = margin;
	hotbar_y = margin;
	
	#region Hotbar Properties
	
	function init_hotbar() {
		for (var _i = 0; _i < slots; _i++) {
			global.player_hotbar[_i] = undefined;
		}
	}
	
	function draw_hotbar() {
		
		for (var _i = 0; _i < array_length(global.player_hotbar); _i++) {
			
			var _xx = hotbar_x;
			var _yy = hotbar_y + (margin * _i) + (global.tile_size * _i);

			// Draw icon
			if (global.player_hotbar[_i] != undefined) {
				
				// Draw background
				draw_sprite_ext(spr_inventory_bg, 0, _xx, _yy, 1, 1, 0, c_white, 1);
				
				// Draw icon and amount
				global.player_hotbar[_i].draw_inventory_item(_xx, _yy);
				// draw_sprite_ext(spr_inventory_icon, global.player_hotbar[_i].icon_id, x + _margin, y + (_margin * (_i + 1)) + (global.tile_size * _i), 1, 1, 0, c_white, 1);
				
			} else {
				// Draw empty background
				draw_sprite_ext(spr_inventory_bg, 1, _xx, _yy, 1, 1, 0, c_white, 1);
			}
			
			if (_i == selected_slot) {
				// Draw selected
				draw_sprite(spr_inventory_selected, 1, hotbar_x, hotbar_y);
			}
			
		}
	}
	
	#endregion
}