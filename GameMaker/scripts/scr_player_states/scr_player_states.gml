function scr_player_states() {

// States
idle_state = new State();
moving_state = new State();
search_state = new State();

nothing_state = new State();
aiming_state = new State();
reloading_state = new State();
	
// Main States
#region Idle State
	
idle_state.start = function () {
	// sprite_index = spr_player_idle;
}

idle_state.run = function() {
	// Transition to moving state if moving
	if ((key_left || key_right || key_up || key_down) || (h_speed != 0 || v_speed != 0)) {
		main_state_manager.change_state(moving_state);
	} 
	
	// Transition to search state
	if (key_inventory) {
		main_state_manager.change_state(search_state);	
	}
}

idle_state.stop = function() {
	
}
	
idle_state.to_string = function() {
	return "idle";	
}
#endregion
	
#region Moving State

moving_state.start = function () {
		
}

moving_state.run = function() {
	// Transition to idle state if not moving
	if ((!key_left && !key_right && !key_up && !key_down) && (h_speed == 0 && v_speed == 0)) {
		main_state_manager.change_state(idle_state);
	}
	
	// Transition to search state
	if (key_inventory) {
		main_state_manager.change_state(search_state);	
	}
}

moving_state.stop = function() {
	
}
	
moving_state.to_string = function() {
	return "moving";	
}
#endregion

#region Search State
	
search_state.start = function () {
	// sprite_index = spr_player_idle;
}

search_state.run = function() {

	// Transition to idle state
	if (key_inventory) {
		main_state_manager.change_state(idle_state);	
	}
}

search_state.stop = function() {
	
}
	
search_state.to_string = function() {
	return "searching";	
}
#endregion
	
// Equipement States
#region Nothing State

nothing_state.start = function () {
	max_speed = max_speed_while_walking;
	image_speed = 0;
	image_index = 0;
}

nothing_state.run = function() {
	
	// Transition to aiming state
	if (key_aim_held && image_index <= 0) {
		equipment_state_manager.change_state(aiming_state);
		return;
	}

}

nothing_state.stop = function() {
	image_index = 0;
	image_speed = 0;
}
	
nothing_state.to_string = function() {
	return "nothing";	
}

#endregion

#region Aiming State
	
aiming_state.start = function () {
	
	max_speed = max_speed_while_aiming;
	sprite_index = spr_player_aiming_pistol;
	image_speed = 1;
}

aiming_state.run = function() {
	
	// Start exit aiming state condition
	if (!key_aim_held) {
		
		if (image_index <= 0.5) {
			equipment_state_manager.change_state(nothing_state);
			return;
		}
		
		if (image_speed != -1) {
			image_speed = -1;
		}
	} else {
		
		if (image_index < sprite_get_number(spr_player_aiming_pistol) - 1 && image_speed != 1) {
			image_speed = 1;	
		}
		
		if (image_index >= sprite_get_number(spr_player_aiming_pistol) - 1 && image_speed != 0) {
			image_speed = 0;
		} 
	}

	
	// Attack
	if (image_index >= sprite_get_number(spr_player_aiming_pistol) - 1 && key_primary_attack) {
		
		// Bullet trace
		var _inst = instance_create_layer(x + lengthdir_x(15, rotation_angle), y + lengthdir_y(15, rotation_angle), "Entities", obj_bullet);
		_inst.image_angle = rotation_angle;
	
		// Screen shake
		with (obj_camera_controller) {
			var _force = 10;
			screen_shake(_force);	
		}
	}
}

aiming_state.stop = function() {

}
	
aiming_state.to_string = function() {
	return "aiming";	
}
	
#endregion

}