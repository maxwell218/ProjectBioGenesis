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

key_inventory = keyboard_check_pressed(vk_tab);

#endregion

#region Player States
main_state_manager.run_state();
equipment_state_manager.run_state();
#endregion

#region Player Movement

var _input_x = 0;
var _input_y = 0;

// Calculate Input Axis
// Simulate no input when player is searching
if (main_state_manager.active_state != search_state) {
	_input_x = (key_right - key_left);
	_input_y = (key_down - key_up);
}

// Get Length
if (_input_x != 0 || _input_y != 0) {

    // Calculate Direction 
	moving_direction = point_direction(0, 0, _input_x, _input_y);
	
	// Apply Accel
    h_speed += lengthdir_x(accel, moving_direction) * DELTA;
    v_speed += lengthdir_y(accel, moving_direction) * DELTA;
	
} 

// Apply Decel
if (_input_x == 0) {
	if (h_speed > 0) h_speed -= decel; else if (h_speed < 0) h_speed += decel * DELTA;
}
	
if (_input_y == 0) {
	if (v_speed > 0) v_speed -= decel; else if (v_speed < 0) v_speed += decel * DELTA;
}
	
// Stop If Low Speed
if (abs(h_speed) < decel) h_speed = 0;
if (abs(v_speed) < decel) v_speed = 0;


// Clamp Speed
var _speed = point_distance(0, 0, h_speed, v_speed);
if (_speed > max_speed) {
	moving_direction = point_direction(0, 0, h_speed, v_speed);
	h_speed = lengthdir_x(max_speed, moving_direction);
	v_speed = lengthdir_y(max_speed, moving_direction);
}

#endregion

#region Collisions

scr_move_and_collide();

#endregion
