/// @description Initialize Lifeform Variables
enum ENTITY_STATE {
	IDLE,
	MOVING,
	ATTACK,
	HURT,
	JUMP,
	FALL,
	DEAD,
}

entity_health = 0;
entity_max_health = 0;
entity_damage_on_touch = 0;
entity_main_state = ENTITY_STATE.IDLE;
entity_inner_state = INNER_STATE.ENTER;

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
legs_animation_length = sprite_get_number(spr_legs);
legs_animation_speed = 1;
legs_image_index = 0;

#region Functions

function change_state(_new_state) {
	entity_inner_state = INNER_STATE.ENTER;
	entity_main_state = _new_state;
}

function animate_legs() {
	legs_image_index = (legs_image_index + legs_animation_speed * (max_speed + .2) / (game_get_speed(gamespeed_fps) / sprite_get_speed(spr_legs)) % legs_animation_length);
	if (legs_image_index >= legs_animation_length - 1) {
		legs_image_index = 0;	
	}
}

function is_moving() {
	if (h_speed != 0 || v_speed != 0)	{
		return true;
	}
	
	return false;
}

#endregion

























