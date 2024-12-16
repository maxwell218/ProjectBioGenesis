function scr_get_x_to_gui(_xx) {
	return _xx - camera_get_view_x(view_camera[0]);
}

function scr_get_y_to_gui(_yy) {
	return _yy - camera_get_view_y(view_camera[0]);
}