// Detect player rotation and adjust target sway
if (instance_exists(obj_player)) {
	
	// Basic positioning
	lantern_rotation_angle = obj_player.rotation_angle;
	target_x = obj_player.x + lengthdir_x(lantern_x_offset, lantern_rotation_angle + 32);
	target_y = obj_player.y + lengthdir_y(lantern_y_offset, lantern_rotation_angle + 32);
}