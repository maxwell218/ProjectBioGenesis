// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_zombie_states() {
	idle_state = new State();
	chase_state = new State();
	attack_state = new State();
	dead_state = new State();

	#region Idle State
	
	idle_state.start = function () {
		reset_idle_cooldown();
		sprite_index = spr_zombie_idle;
		image_speed = 0;
		image_index = 0;
		alarm[0] = idle_anim_cooldown;
	}

	idle_state.run = function() {
		if (image_index >= sprite_get_number(spr_zombie_idle) - 1) {
			image_speed = 0;
			image_index = 0;
			alarm[0] = idle_anim_cooldown;
		} else if (!alarm[0] && image_speed == 0) {
			image_speed = 1;
		}
			
		check_vision_radius();
			
		if (player_is_in_vision_radius) {
			// Transition to Chase State if enemy lifeform is spotted
			main_state_manager.change_state(chase_state);
		}
	}

	idle_state.stop = function() {
	
	}
	
	idle_state.to_string = function() {
		return "idle";	
	}
	#endregion
	
	#region Chase State

	chase_state.start = function () {
		image_index = 0;
		image_speed = 0;
		sprite_index = spr_zombie_idle;
		alarm[0] = -1;
		max_speed = max_speed_while_chasing;
	}

	chase_state.run = function() {
		// Check if we should still chase
		check_vision_radius();
			
		var _distance = distance_to_object(obj_player);
			
		// TODO Go towards last known position
		if (!player_is_in_vision_radius) {
			var _player = instance_find(obj_player, 0);
			//if (_player != noone) {
			//	last_known_target_position_x = _player.x;
			//	last_known_target_position_y = _player.y;
			//	last_known_target_position_reached = false;
			//}
				
			main_state_manager.change_state(idle_state);
				
		} else if (_distance <= attack_1_distance_trigger && player_is_in_attack_cone()) {
			 // Check for cooldown
			main_state_manager.change_state(attack_state);
			
			// Otherwise halt but rotate
				
		} else {
				
			var _player = instance_find(obj_player, 0);
	
			// Get Direction 
			// Direction can be towards an enemy, towards a last known enemy position, towards a random wander spot
			// When a zombie is chasing an enemy, 
			var _dir = undefined;

			if (_player != noone) {
				rotate_towards_player();
			}// else if (!last_known_target_position_reached) {
			//	_dir = 	point_direction(x, y, last_known_target_position_x, last_known_target_position_y);
			//	// Change state
			//}
				
			// Apply Accel
			h_speed += lengthdir_x(accel, moving_direction) * DELTA;
			v_speed += lengthdir_y(accel, moving_direction) * DELTA;	
		}
	}

	chase_state.stop = function() {
	
	}
	
	chase_state.to_string = function() {
		return "chase";	
	}
	#endregion
	
	#region Attack State
	
	attack_state.start = function () {
		sprite_index = spr_zombie_attack_1;
		image_index = 0;
		image_speed = 1;
		h_speed = 0;
		v_speed = 0;
		max_speed = max_speed_while_lunging;
	}

	attack_state.run = function() {
		// Check if we should still chase
		// check_vision_radius();
		attack_1_lunge_percent += 1/global.target_framerate * DELTA;
		
		// TODO Testing hitbox
		//if (global.debug || true) {
		//	if (image_index > sprite_get_number(spr_zombie_attack_1) - 4) {
		//		h_speed = 0;
		//		v_speed = 0;
		//		image_speed = 0;
		//		if (!has_attacked) {
					
		//			// Get lengthdir offset
		//			var _x_offset = lengthdir_x(4, rotation_angle);
		//			var _y_offset = lengthdir_y(4, rotation_angle);
		//			var _hitbox = instance_create_layer(x + _x_offset, y + _y_offset, "Collisions", obj_zombie_attack_1_hitbox);
		//			_hitbox.image_angle	= rotation_angle - 90;
		//			has_attacked = true;
		//		}
		//		return;
		//	}
		//}
		
		// Exit condition
		if (attack_1_lunge_percent > 1) {
			main_state_manager.change_state(chase_state);
		} 
		
		if (image_index > sprite_get_number(spr_zombie_attack_1) - 4) {
			if (!has_attacked) {
				// Get lengthdir offset
				var _x_offset = lengthdir_x(3, rotation_angle);
				var _y_offset = lengthdir_y(3, rotation_angle);
				var _hitbox = instance_create_layer(x + _x_offset, y + _y_offset, "Collisions", obj_zombie_attack_1_hitbox);
				_hitbox.image_angle	= rotation_angle - 90;
				has_attacked = true;
			}
		}
		
		// Keep rotating in the early state of attacking
		if (attack_1_lunge_percent < 0.25) {
			rotate_towards_player();
		}
		
		// Stop animating if we reached the end of the attack animation
		if (image_index > sprite_get_number(spr_zombie_attack_1) - 1) {
			image_speed = 0;
		} 
		
		var _position_in_anim_curve = animcurve_channel_evaluate(attack_1_lunge_curve, attack_1_lunge_percent * DELTA);
		//if (image_index > sprite_get_number(spr_zombie_attack_1) - 1) {
		//	main_state_manager.change_state(chase_state);
		//} 
		
		// Apply Accel
		h_speed += lengthdir_x(accel, moving_direction) * DELTA;
		v_speed += lengthdir_y(accel, moving_direction) * DELTA;
		
		h_speed *= _position_in_anim_curve;
		v_speed *= _position_in_anim_curve;
	}

	attack_state.stop = function() {
		attack_1_lunge_percent = 0;
		has_attacked = false;
	}
	
	attack_state.to_string = function() {
		return "attack";	
	}
	#endregion
	
	#region Dead State
	
	dead_state.start = function () {
		sprite_index = spr_zombie_death_1;
		image_index = 0;
		image_speed = 1;
	}

	dead_state.run = function() {
		if (image_index > sprite_get_number(spr_zombie_death_1) - 1) {
			image_speed = 0;
		} 
	}

	dead_state.stop = function() {
	
	}
	
	dead_state.to_string = function() {
		return "dead";	
	}
	#endregion
}