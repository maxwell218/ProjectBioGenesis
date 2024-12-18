/// @description States
EXIT_IF_FPS_NOT_SUPPORTED;
event_inherited();

switch(entity_main_state) {
	
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
			    entity_main_state = ENTITY_STATE.JUMP;
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
			max_speed = 0.7;
		} else if (entity_inner_state == INNER_STATE.UPDATE) {
			
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
				
				entity_inner_state = INNER_STATE.LEAVE;
				// TODO Check angle if towards player aswell
			} else if (_distance <= 7 && player_is_in_attack_cone()) {
				change_state(ENTITY_STATE.ATTACK);	
			} else {
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
			}
		} else if (entity_inner_state == INNER_STATE.LEAVE) {
			change_state(ENTITY_STATE.IDLE);
		}
		break;
	case ENTITY_STATE.ATTACK:
		if (entity_inner_state == INNER_STATE.ENTER) {
			sprite_index = spr_zombie_attack_1;
			image_index = 0;
			image_speed = 1;
			entity_inner_state = INNER_STATE.UPDATE;
			max_speed = 0.5;
		} else if (entity_inner_state == INNER_STATE.UPDATE) {
			
			// Check if we should still chase
			check_vision_radius();
			
			if (image_index >= sprite_get_number(spr_zombie_attack_1)) {
				entity_inner_state = INNER_STATE.LEAVE;
			} 
		} else if (entity_inner_state == INNER_STATE.LEAVE) {
			change_state(ENEMY_STATE.CHASE);
			image_index = 0;
		}
	case ENEMY_STATE.WANDER:
		break;
	case ENTITY_STATE.DEAD:
		if (entity_inner_state == INNER_STATE.ENTER) {
			
			show_debug_message("Death");
			sprite_index = spr_zombie_death_1;
			image_index = 0;
			image_speed = 1;
			entity_inner_state = INNER_STATE.UPDATE;
			
		} else if (entity_inner_state == INNER_STATE.UPDATE) {
			
			if (image_index >= sprite_get_number(spr_zombie_death_1)) {
				image_speed = 0;
			} 
		}
		break;
}
#region Movement

if (entity_main_state != ENEMY_STATE.CHASE) {
	// Apply Decel
	if (h_speed > 0) h_speed -= decel; else if (h_speed < 0) h_speed += decel;
	if (v_speed > 0) v_speed -= decel; else if (v_speed < 0) v_speed += decel;

	
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