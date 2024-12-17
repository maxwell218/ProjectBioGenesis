/// @description Depth Sorting
// depth = -y;

// TODO Animate legs until leg is out of frame, not based on movement
if (entity_main_state != ENTITY_STATE.DEAD) {
	if (has_legs && (is_moving() || (legs_image_index != 0 && floor(legs_image_index + .5) != 8))) { 
		animate_legs();
	} 
}

var _angle = angle_difference(moving_angle, moving_direction);
moving_angle -= min(abs(_angle), rotation_speed) * sign(_angle);

if (moving_angle >= 360 || moving_angle <= -360) {
	moving_angle = 0;	
}