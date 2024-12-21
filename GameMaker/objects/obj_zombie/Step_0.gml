/// @description States
EXIT_IF_FPS_NOT_SUPPORTED;
event_inherited();

main_state_manager.run_state();

#region Movement

if (main_state_manager.active_state != chase_state && main_state_manager.active_state != attack_state) {
	// Apply Decel
	if (h_speed > 0) h_speed -= decel; else if (h_speed < 0) h_speed += decel * DELTA;
	if (v_speed > 0) v_speed -= decel; else if (v_speed < 0) v_speed += decel * DELTA;

	
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