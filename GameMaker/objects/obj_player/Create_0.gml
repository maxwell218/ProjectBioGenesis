/// @description Initialize Player Variables
event_inherited();

entity_health = 10;
entity_max_health = 10;
entity_damage_on_touch = 0;
entity_state = ENTITY_STATE.IDLE;
entity_inner_state = INNER_STATE.ENTER;

#region Inputs

key_left = 0;
key_right = 0;
key_up = 0;
key_down = 0;
key_jump = 0;
key_jump_held = 0;
key_aim_held = 0;
key_primary_attack = 0;

#endregion

#region Movement Variables

is_aiming = false;
is_ready_to_fire = false;
max_speed = 1;
h_speed = 0;
v_speed = 0;

accel = .2;
decel = .1;

#endregion

#region Functions

#endregion