/// @description Depth Sorting
depth = -y;

if (has_legs && is_moving()) { 
	animate_legs();
} 

var _angle = angle_difference(moving_angle, moving_direction);
moving_angle -= min(abs(_angle), rotation_speed) * sign(_angle);

if (moving_angle >= 360 || moving_angle <= -360) {
	moving_angle = 0;	
}