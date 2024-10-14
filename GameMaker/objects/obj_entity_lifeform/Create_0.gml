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
entity_state = ENTITY_STATE.IDLE;
entity_inner_state = INNER_STATE.ENTER;

healthbar_height = 3;
healthbar_y_offset = 5;
h_speed = 0;
v_speed = 0;

// x_frac = 0;
// y_frac = 0;

// Animation
rotation_angle = 0;
rotation_speed = 10;

function change_state(_new_state) {
	entity_inner_state = INNER_STATE.ENTER;
	entity_state = _new_state;
}


























