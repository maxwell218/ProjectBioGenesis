/// @description Depth Sorting
// depth = -y;

// Animate legs until out of frame, based on movement
if (entity_health > 0) {
	if ((has_legs && is_moving_fast()) || !is_leg_cycle_complete()) { 
		animate_legs();
	} 
}

var _angle = angle_difference(moving_angle, moving_direction);
moving_angle -= min(abs(_angle), rotation_speed) * sign(_angle);

clamp_rotation(moving_angle);