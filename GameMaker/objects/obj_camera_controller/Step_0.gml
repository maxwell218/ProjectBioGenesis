/// @description Follow Player

if (instance_exists(follow)) {
	if (follow != noone) {
		target_x = floor(follow.x + .5);	
		target_y = floor(follow.y - target_y_offset + .5);
	}
}

// Ease in effect
// TODO Tweak/Find right values
x += (target_x - x) / 25;
y += (target_y - y) / 25;

x = clamp(x, min_view_x, max_view_x);
y = clamp(y, min_view_y, max_view_y);

camera_set_view_pos(view_camera[0], x - (camera_width * .5), y - (camera_height * .5));