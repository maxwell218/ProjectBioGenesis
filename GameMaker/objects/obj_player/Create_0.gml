/// @description Initialize Player Variables
event_inherited();

#region Entity Variables

entity_health = 10;
entity_max_health = 10;
entity_damage_on_touch = 0;

rotation_speed = 8;

has_legs = true;

#endregion

#region Inputs

key_left = 0;
key_right = 0;
key_up = 0;
key_down = 0;
key_jump = 0;
key_jump_held = 0;
key_aim_held = 0;
key_primary_attack = 0;
key_inventory = 0;

#endregion

#region Movement Variables

max_speed_while_walking = 0.75;
max_speed_while_aiming = 0.5;
max_speed = max_speed_while_walking;
h_speed = 0;
v_speed = 0;

accel = .2;
decel = .05;

#endregion

#region States

// State Managers
main_state_manager = new StateManager();
equipment_state_manager = new StateManager();

scr_player_states();

main_state_manager.init_state(idle_state);
equipment_state_manager.init_state(nothing_state);

#endregion

#region Functions

// TODO Clean, find a better place
// lantern = instance_create_layer(x, y, "Entities", obj_lantern);

#endregion