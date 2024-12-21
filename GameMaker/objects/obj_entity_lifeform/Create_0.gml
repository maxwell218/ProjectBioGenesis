/// @description Initialize Lifeform Variables

entity_health = 0;
entity_max_health = 0;
entity_damage_on_touch = 0;

healthbar_height = 3;
healthbar_y_offset = 10;

moving_direction = 0;
moving_angle = 0;
h_speed = 0;
v_speed = 0;

// Animation
rotation_angle = 0;
rotation_speed = 10;

// Legs
has_legs = false;
legs_animation_length = sprite_get_number(spr_legs) - 1;
legs_animation_speed = 1;
legs_image_index = 0;

#region Functions

function animate_legs() {
	legs_image_index = (legs_image_index + legs_animation_speed * (max_speed + .2) / (game_get_speed(gamespeed_fps) / sprite_get_speed(spr_legs)) % legs_animation_length);
	if (legs_image_index >= legs_animation_length) {
		legs_image_index = 0;	
	}
}

function is_moving_fast() {
	if (abs(h_speed) >= .1 || abs(v_speed) >= .1) {
		return true;
	}
	
	return false;
}

function is_leg_cycle_complete() {
	if (legs_image_index <= 0.5 || (legs_image_index > 7.5 && legs_image_index < 8.5)) {
		return true;
	}
	
	return false;
}

function clamp_rotation(_rotation) {
	if (_rotation >= 360 || _rotation <= -360) {
		_rotation = 0;	
	}	
}

#endregion

























