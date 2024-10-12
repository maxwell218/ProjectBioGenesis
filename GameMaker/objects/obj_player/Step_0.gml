/// @description Inputs & States
EXIT_IF_FPS_NOT_SUPPORTED;

#region Get Inputs

key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));

key_jump = keyboard_check_pressed(vk_space);
key_jump_held = keyboard_check(vk_space);
key_aim_held = mouse_check_button(mb_right);
key_primary_attack = mouse_check_button_pressed(mb_left);

#endregion

#region Player States

#region Attacking
if (is_aiming) {
	if (image_index >= sprite_get_number(spr_player_aiming_pistol) - 1 && image_speed != 0) {		
		image_index = sprite_get_number(spr_player_aiming_pistol) - 1;
		image_speed = 0;	
		is_ready_to_fire = true;
	} 
} else {
	if (is_ready_to_fire) {
		is_ready_to_fire = false;
	}
	if (image_index <= 0.5) {
		image_index = 0;
		image_speed = 0;
		sprite_index = spr_player;
	}
}

if (key_aim_held && image_index == 0) {
	is_aiming = true
	sprite_index = spr_player_aiming_pistol;
	image_speed = 1;
} else if (!key_aim_held && image_index != 0) {
	is_aiming = false;
	image_speed = -1;
}

if (is_ready_to_fire && key_primary_attack) {
	var _inst = instance_create_layer(x + lengthdir_x(15, rotation_angle), y + lengthdir_y(15, rotation_angle), "Entities", obj_bullet);
	_inst.image_angle = rotation_angle;
}

#endregion

switch(entity_state) {
	case ENTITY_STATE.IDLE:
		if (entity_inner_state == INNER_STATE.ENTER) {
			
			// Handle Idle State
			// sprite_index = spr_capsule_idle;
			entity_inner_state = INNER_STATE.UPDATE;
			
		} else if (entity_inner_state == INNER_STATE.UPDATE) {
		
			// Transition to Jumping State if jumping
			/*
			if (key_jump || !on_ground) {
				entity_inner_state = INNER_STATE.ENTER;
			    entity_state = ENTITY_STATE.JUMP;
			}
			*/

			// Transition to Moving State if moving
			if ((key_left || key_right || key_up || key_down) || (h_speed != 0 || v_speed != 0)) {
				change_state(ENTITY_STATE.MOVING);
			} 
		}
        
	    break;

	case ENTITY_STATE.MOVING:
		if (entity_inner_state == INNER_STATE.ENTER) {
			
			// Handle Moving State
			// sprite_index = spr_capsule_run;	
			entity_inner_state = INNER_STATE.UPDATE;
			
		} else if (entity_inner_state == INNER_STATE.UPDATE) {
			
			/*
			if (alarm_array[ALARM_ARRAY.SOUND_STEP] == ALARM_INACTIVE) {
				alarm_array[ALARM_ARRAY.SOUND_STEP] = ALARM_STEPS.SOUND_STEP;	
			}
			*/
			
			// Transition to Jumping State if jumping
			/*
		    if (key_jump || !on_ground) {
				entity_inner_state = INNER_STATE.ENTER;
		        entity_state = ENTITY_STATE.JUMP;
		    }
			*/
        
		    // Transition to Idle State if not moving horizontally
			if ((!key_left && !key_right && !key_up && !key_down) && (h_speed == 0 && v_speed == 0)) {
				change_state(ENTITY_STATE.IDLE);
		    }
		}

	    break;

	case ENTITY_STATE.JUMP:
		if (entity_inner_state == INNER_STATE.ENTER) {
		    // Handle Jumping State
			// sprite_index = spr_capsule_air;
			image_speed = 0;
			entity_inner_state = INNER_STATE.UPDATE;
			
		} else if (entity_inner_state == INNER_STATE.UPDATE) {
	
			image_index = (v_speed < 0)? 0 : 2;
	
			if (v_speed > -2 && v_speed < 2) {
				image_index = 1;
			}

		    // Transition to Idle State if not jumping
		    if (on_ground) {
				change_state(ENTITY_STATE.IDLE);
		    }
		}

	    break;
	/*
	case ENTITY_STATE.HURT:
		if (entity_inner_state == INNER_STATE.ENTER) {
			sprite_index = spr_capsule_hurt;
			if (!audio_is_playing(snd_player_hurt) && global.sfx) {
				audio_play_sound(snd_player_hurt, 10, false);
			}
			alarm_array[ALARM_ARRAY.INVINCIBILITY] = ALARM_STEPS.INVINCIBILITY * invincibility_mult;
		
			if (entity_health <= 0) {
				part_particles_create(global.pt_system, x, bbox_top + sprite_get_height(sprite_index) / 2, global.pt_capsule, 25);
				instance_destroy();	
			} else {
				part_particles_create(global.pt_system, x, bbox_top + sprite_get_height(sprite_index) / 2, global.pt_capsule, 10);
			}
			
			entity_inner_state = INNER_STATE.UPDATE;
		} if (entity_inner_state == INNER_STATE.UPDATE) {
		
			if (on_ground) {
				entity_inner_state = INNER_STATE.ENTER;
			    entity_state = ENTITY_STATE.IDLE;
			} else {
				entity_inner_state = INNER_STATE.ENTER;
				entity_state = ENTITY_STATE.JUMP;
			}
		}
		
		break;
	*/
}
#endregion

#region Player Movement

// Calculate Input Axis
var _input_x = (key_right - key_left);
var _input_y = (key_down - key_up);

var _move_x = 0;
var _move_y = 0;

// Get Length
if (_input_x != 0 || _input_y != 0) {

    // Calculate Direction 
	var _dir = point_direction(0, 0, _input_x, _input_y);
	
	// Apply Accel
    h_speed += lengthdir_x(accel, _dir) * DELTA;
    v_speed += lengthdir_y(accel, _dir) * DELTA;
	
} 

// Apply Decel
if (_input_x == 0) {
	if (h_speed > 0) h_speed -= decel; else if (h_speed < 0) h_speed += decel;
}
	
if (_input_y == 0) {
	if (v_speed > 0) v_speed -= decel; else if (v_speed < 0) v_speed += decel;
}
	
// Stop If Low Speed
if (abs(h_speed) < decel) h_speed = 0;
if (abs(v_speed) < decel) v_speed = 0;


// Clamp Speed
var _speed = point_distance(0, 0, h_speed, v_speed);
if (_speed > max_speed) {
	var _dir = point_direction(0, 0, h_speed, v_speed);
	h_speed = lengthdir_x(max_speed, _dir) * DELTA;
	v_speed = lengthdir_y(max_speed, _dir) * DELTA;
}

#endregion

#region Collisions

scr_move_and_collide();

#endregion
