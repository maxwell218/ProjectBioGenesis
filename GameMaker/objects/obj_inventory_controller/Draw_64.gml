/// @description Draw Inventory & Hotbar

if (instance_exists(obj_player)) {
	
	// Draw the hotbar
	inventory.draw_hotbar();

	if (obj_player.main_state_manager.active_state == obj_player.search_state) {
		inventory.draw_inventory();
	}
}

// draw_text(x, y, "helop");
// Draw