/// @description States
EXIT_IF_FPS_NOT_SUPPORTED;
event_inherited();

switch(entity_state) {
	
	case ENTITY_STATE.IDLE:
		if (entity_inner_state == INNER_STATE.ENTER) {
			sprite_index = spr_zombie_idle;
			// Handle Idle State
			// sprite_index = spr_capsule_idle;
			reset_idle_cooldown();
			alarm[0] = idle_anim_cooldown;
			entity_inner_state = INNER_STATE.UPDATE;
			
		} else if (entity_inner_state == INNER_STATE.UPDATE) {
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
				change_state(ENEMY_STATE.CHASE);
			}

			// Transition to Jumping State if jumping
			/*
			if (key_jump || !on_ground) {
				entity_inner_state = INNER_STATE.ENTER;
			    entity_state = ENTITY_STATE.JUMP;
			}
			*/

			// Transition to Moving State if moving
		}
	    break;
		
	case ENEMY_STATE.CHASE:
		if (entity_inner_state = INNER_STATE.ENTER) {
			image_index = 0;
			image_speed = 0;
			alarm[0] = -1;
			entity_inner_state = INNER_STATE.UPDATE;
		} else if (entity_inner_state == INNER_STATE.UPDATE) {
			
			// Check if we should still chase
			check_vision_radius();
			
			// TODO Go towards last known position
			if (!player_is_in_vision_radius) {
				var _player = instance_find(obj_player, 0);
				//if (_player != noone) {
				//	last_known_target_position_x = _player.x;
				//	last_known_target_position_y = _player.y;
				//	last_known_target_position_reached = false;
				//}
				
				entity_inner_state = INNER_STATE.LEAVE;
			}
		} else if (entity_inner_state == INNER_STATE.LEAVE) {
			change_state(ENTITY_STATE.IDLE);
		}
		break;
		
	case ENEMY_STATE.WANDER:
		break;
}
#region Movement

// If our wander cooldown is triggered or if we are currently chasing than we need to move
if (entity_state == ENEMY_STATE.CHASE) {
	
	
	var _player = instance_find(obj_player, 0);
	
	// Get Direction 
	// Direction can be towards an enemy, towards a last known enemy position, towards a random wander spot
	// When a zombie is chasing an enemy, 
	var _dir = undefined;

	if (_player != noone) {
		moving_direction = rotation_angle;
	}// else if (!last_known_target_position_reached) {
	//	_dir = 	point_direction(x, y, last_known_target_position_x, last_known_target_position_y);
	//	// Change state
	//}
	
	// Apply Accel
	h_speed += lengthdir_x(accel, moving_direction) * DELTA;
	v_speed += lengthdir_y(accel, moving_direction) * DELTA;

	// Apply Decel
	//if (!player_is_in_vision_radius && distance_to_point(last_known_target_position[0], last_known_target_position[1]) <= max_speed) {
	//	if (h_speed > 0) h_speed -= decel; else if (h_speed < 0) h_speed += decel;
	//	if (v_speed > 0) v_speed -= decel; else if (v_speed < 0) v_speed += decel;
	//} 
	
} else {
	// Apply Decel
	if (!player_is_in_vision_radius) {
		if (h_speed > 0) h_speed -= decel; else if (h_speed < 0) h_speed += decel;
		if (v_speed > 0) v_speed -= decel; else if (v_speed < 0) v_speed += decel;
	} 
	
	// Stop If Low Speed
	if (abs(h_speed) < decel) h_speed = 0;
	if (abs(v_speed) < decel) v_speed = 0;
}

// Clamp Speed
var _speed = point_distance(0, 0, h_speed, v_speed);
if (_speed > max_speed) {
	h_speed = lengthdir_x(max_speed, moving_direction);
	v_speed = lengthdir_y(max_speed, moving_direction);
}

#endregion

scr_move_and_collide();