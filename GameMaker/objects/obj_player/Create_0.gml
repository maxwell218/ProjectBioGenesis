/// @description Initialize Player Variables
event_inherited();

entity_health = 10;
entity_max_health = 10;
entity_damage_on_touch = 0;
entity_state = ENTITY_STATE.IDLE;
entity_inner_state = INNER_STATE.ENTER;
has_legs = true;
holding_item = true;

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


max_speed_while_walking = 0.8;
max_speed_while_aiming = 0.5;
max_speed = max_speed_while_walking;
h_speed = 0;
v_speed = 0;

accel = .2;
decel = .05;

#endregion

#region Attack Variables

is_aiming = false;
is_ready_to_fire = false;

#endregion

#region Functions

// TODO Clean, find a better place
lantern = instance_create_layer(x, y, "Entities", obj_lantern);

#endregion