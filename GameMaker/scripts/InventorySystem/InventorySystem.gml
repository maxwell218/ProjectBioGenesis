// Handles both the hotbar and the inventory
function InventorySystem() constructor {
	
	inventory = new Inventory();
	inventory.init_inventory();

	hotbar = new Hotbar();
	hotbar.init_hotbar();
	
	// TODO Remove item cheating
	inventory.add_item_to_inventory(global.item_data[5]);
	inventory.add_item_to_inventory(global.item_data[3]);
	
	#region InventorySystem Properties
	
	function handle_inventory_system() {
		// Get the hovered cell based on the mouse coord on the gui layer
		if (obj_player.main_state_manager.active_state == obj_player.search_state) {
			
			inventory.get_mouse_cell_coord();
		}
	}
	
	function draw_inventory_system() {
		// Draw the hotbar
		hotbar.draw_hotbar();
		
		// Draw the inventory if the player is searching
		if (obj_player.main_state_manager.active_state == obj_player.search_state) {
			inventory.draw_inventory();
			
		}	
	}
	
	#endregion
}