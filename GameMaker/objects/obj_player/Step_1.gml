/// @description 
event_inherited();

var _look_dir = point_direction(x, y, mouse_x, mouse_y);
var _angle = angle_difference(rotation_angle, _look_dir);

rotation_angle -= min(abs(_angle), rotation_speed * DELTA) * sign(_angle);

// TODO Break perfect sprites and weird angles
rotation_angle = floor(rotation_angle + 2);

if (rotation_angle >= 360 || rotation_angle <= -360) {
	rotation_angle = 0;	
}























