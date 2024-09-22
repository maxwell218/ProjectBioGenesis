/// @description Depth Sorting
depth = -y;

var _pd = point_direction(x, y, mouse_x, mouse_y);
var _dd = angle_difference(rotation_angle, _pd);

rotation_angle -= min(abs(_dd), rotation_speed) * sign(_dd) * DELTA;

if (rotation_angle >= 360 || rotation_angle <= -360) {
	rotation_angle = 0;	
}