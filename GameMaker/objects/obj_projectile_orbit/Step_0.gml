/// @description Orbital Motion

orbit_angle += orbit_speed;
if (orbit_angle >= 360) orbit_angle -= 360;

// Update position
if (instance_exists(obj_player)) {
	
	// Update center_x and center_y
	update_center_orbit();
	
	x = lengthdir_x(orbit_distance, orbit_angle) + center_x;
	y = lengthdir_y(orbit_distance, orbit_angle) + center_y;
} else {
	instance_destroy();	
}