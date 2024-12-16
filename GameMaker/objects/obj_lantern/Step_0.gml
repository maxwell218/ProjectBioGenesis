// Detect player rotation and adjust target sway
if (instance_exists(obj_player)) {
	
	// Basic positioning
	lantern_rotation_angle = obj_player.rotation_angle;
	x = obj_player.x + lengthdir_x(8, lantern_rotation_angle + 32);
	y = obj_player.y + lengthdir_y(8, lantern_rotation_angle + 32);
	
}