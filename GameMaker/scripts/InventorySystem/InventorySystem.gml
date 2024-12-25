// Handles the hotbar, the inventory and any opened container
function InventorySystem() constructor {
	
	inventory = new Inventory(global.player_inventory);
	inventory.init_inventory();

	hotbar = new Hotbar(global.player_hotbar);
	hotbar.init_hotbar();
	
	pickup_item = undefined;
	slot_hover_index = false;
	
	#region InventorySystem Properties
	
	function get_mouse_cell_slot(_ui) {
		
		// Get mouse coords on the gui layer
		var _mouse_gui_x = device_mouse_x_to_gui(0);
		var _mouse_gui_y = device_mouse_y_to_gui(0);
		
		#region Mouse Slot
		
		var _start_x = _ui.start_x;
		var _start_y = _ui.start_y;
		
		// Adjust mouse position relative to the grid
		var _relative_x = _mouse_gui_x - _start_x;
		var _relative_y = _mouse_gui_y - _start_y;

		// Calculate the row and column the mouse is hovering over
		var _col = floor(_relative_x / (global.tile_size + _ui.margin));
		var _row = floor(_relative_y / (global.tile_size + _ui.margin));
		
		// Check if the row and column are within bounds
		if (_col >= 0 && _col < _ui.width && _row >= 0 && _row < _ui.height) {
		    
			// Highlight the cell
		    var _cell_x = _start_x + _col * (global.tile_size + _ui.margin);
		    var _cell_y = _start_y + _row * (global.tile_size + _ui.margin);
			
			
			// Check if the mouse is inside the actual cell, excluding the margin
		    if (_mouse_gui_x >= _cell_x && _mouse_gui_x < _cell_x + global.tile_size &&
		        _mouse_gui_y >= _cell_y && _mouse_gui_y < _cell_y + global.tile_size) {
				
				var _index = _row * _ui.width + _col;
				
				// Highlight the cell
				_ui.hovered_cell = _index;
				return _ui.hovered_cell;
		    } 
		} 
		
		#endregion
		
		_ui.hovered_cell = undefined;
		return _ui.hovered_cell;
	}
	
	function handle_inventory_system() {
		
		// Returns undefined if we are not hovering the hotbar's slots
		handle_ui_mouse_click(hotbar)
		
		// Get the hovered cell based on the mouse coord on the gui layer
		if (obj_player.main_state_manager.active_state == obj_player.search_state) {
			
			// Returns undefined if we are not hovering the inventory's slots
			handle_ui_mouse_click(inventory);
			
		} else {
			// Since we can close the inventory without first unsetting the cell, we need to reset the cell just in case
			if (inventory.hovered_cell != undefined) {
				inventory.hovered_cell = undefined;
			}
		}
	}
	
	function handle_ui_mouse_click(_ui) {
		// Returns undefined if we are not hovering the ui's slots
		slot_hover_index = get_mouse_cell_slot(_ui);
		
		if (mouse_check_button_pressed(mb_left) && _ui.is_hover()) {
			mouse_clear(mb_left);
			
			if (slot_hover_index != undefined) {
				if (pickup_item == undefined) {
					pickup_item = _ui.array[slot_hover_index];
					_ui.array[slot_hover_index] = undefined;
				} else {
					add_item_to_array(pickup_item, _ui.array, slot_hover_index);
				}
			}
		}
	}
	
	// Can be called both by clicking an empty slot and shift clicking from a container or another ui element (hotbar)
	function add_item_to_array(_item_data, _array, _slot_index = undefined) {
		
		// Result keeps track of any remaining _item_data with an amount > 0
		// If result is undefined, then we succesfully merged/transfered the _item_data
		var _result = undefined;
		
		// Handle specific slot selected
		if (_slot_index != undefined) {
			var _slot_item = _array[_slot_index];
			
			if (_slot_item != undefined) {
				// Check if the current slot item corresponds to the item we are trying to add
				if (_slot_item.item_data.icon_id == _item_data.item_data.icon_id && _slot_item.item_data.is_stackable()) {
				
					_result = handle_merging_logic(_item_data, _array[_slot_index]);
			
					// If we result in no item left, return
					if (_result == undefined) {
						pickup_item = undefined;
						return;	
					}
				}
			}
			// We either failed to merge, or the item is overflow
			// Initialise the switch
			var _temp_item = _array[_slot_index];
			_array[_slot_index] = pickup_item;
				
			pickup_item = _temp_item;
			return;
			
		} 
		
		// If we don't have a specific slot, loop through the existing items to try and stack them
		for (var _i = 0; _i < array_length(_array); _i++) {
			
			// Our current slot item
			var _slot_item = _array[_i];
			
			if (_slot_item != undefined) {
				
				// Check if the current slot item corresponds to the item we are trying to add
				if (_slot_item.item_data.icon_id == _item_data.item_data.icon_id && _slot_item.item_data.is_stackable()) {
					
					// Attempt to merge the items and handle the result
		            _result = handle_merging_logic(_item_data, _slot_item);
            
		            // If merging is complete (_result is undefined), exit early
		            if (_result == undefined) {
		                return;    
		            }
            
		            // Begin checking subsequent slots for further stacking opportunities
		            var _n = _i + 1; // Start at the next slot
		            var _next_slot_item = _array[_n];
            
		            // Continue looping through the inventory until conditions are met
		            while (_n < array_length(_array) && _result != undefined && _next_slot_item != undefined) {
		                // Ensure the next slot is valid before proceeding
		                if (_array[_n] != undefined) {
		                    _next_slot_item = _array[_n];
		                }
                
		                // Check if the next slot matches the item being added and is stackable
		                if (_next_slot_item.item_data.icon_id == _item_data.item_data.icon_id && _next_slot_item.item_data.is_stackable()) {
		                    // Attempt to merge the items in the next slot
		                    _result = handle_merging_logic(_item_data, _next_slot_item);
                    
		                    // Exit if merging is complete (_result is undefined)
		                    if (_result == undefined) {
		                        return;    
		                    }
		                }
                
		                // Move to the next slot
		                _n++;
		            }
				}
			}
		}
		
		
		
		// Loop through empty slots
		for (var _i = 0; _i < array_length(_array); _i++) {
			// Our current slot item
			var _slot_item = _array[_i];
				
			if (_slot_item == undefined) {
				_array[_i] = _item_data;
				return;
			}
		}
		
		
		show_debug_message("failed with " + string(_item_data.item_data.name) + " and amount: " + string(_item_data.amount));
	}
	
	function handle_merging_logic(_item_data, _slot_data) {

		// If they are the same item, check their max_stacksize
		var _max_stacksize = _slot_data.item_data.max_stacksize
					
		// Check if there is room for stacking
		if (_slot_data.amount < _max_stacksize && _item_data.amount < _max_stacksize) {
						
			// Calulate remainder of _item_data.amount
			if (_slot_data.amount + _item_data.amount > _max_stacksize) {
					
				// Get the total amount if we merged them
				var _total_amount = _slot_data.amount + _item_data.amount;
							
				// Substract the stacksize to the total amount, giving us the remainder
				var _overflow = _total_amount - _max_stacksize;
							
				// Set each item's new amount
				_slot_data.amount = _max_stacksize;
				_item_data.amount = _overflow;
						
				// Item data still exists but we didn't add the remainder stack to another slot
				return _item_data;
			} 
			// If we don't exceed the stacksize, merge them on the slot and delete the extra item
			else {
				_slot_data.amount = _slot_data.amount + _item_data.amount;
				_item_data = undefined;
							
				// No more checks needed here, we can return
				return undefined;
			}
		} 
		// No room for stacking
		else {
			return _item_data;
		}
	}
	
	function draw_inventory_system() {
		
		// Get mouse coords on the gui layer
		var _mouse_gui_x = device_mouse_x_to_gui(0);
		var _mouse_gui_y = device_mouse_y_to_gui(0);
		
		// Draw the hotbar
		hotbar.draw_hotbar();
		
		// Draw the inventory if the player is searching
		if (obj_player.main_state_manager.active_state == obj_player.search_state) {
			inventory.draw_inventory();
				
		}
		
		// Draw pickup item and amount
		if (pickup_item != undefined) {
			pickup_item.draw_inventory_item(_mouse_gui_x - global.tile_size / 2, _mouse_gui_y - global.tile_size / 2);
		}
		
		// TODO Tooltip
		//if (slot_hover_index != undefined && global.debug) {
		//	draw_rectangle(_mouse_gui_x, _mouse_gui_y, _mouse_gui_x + 20, _mouse_gui_y + 20, false);
		//}
	}
	
	#endregion
}