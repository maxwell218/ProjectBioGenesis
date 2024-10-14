function point_in_angle(_origin_x, _origin_y, _point_x, _point_y, _vision_angle_width, _vision_angle_dir) {
	var _dir = point_direction(_origin_x, _origin_y, _point_x, _point_y);
	var _diff = angle_difference(_dir, _vision_angle_dir);
	
	if (abs(_diff) <= _vision_angle_width / 2) {
		return true;
	}
	
	return false;
}