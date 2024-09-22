function scr_move_and_collide() {
	
	// Check for horizontal collision
	if (place_meeting(x + h_speed * DELTA, y, obj_solid) && h_speed != 0) {
	
		var _one_pixel = sign(h_speed);
	
		while (!place_meeting(x + _one_pixel, y, obj_solid)) {
			x += _one_pixel;
		}
	
		h_speed = 0;
	}
	
	x += h_speed * DELTA;
	
	// Check for vertical collision
	if (place_meeting(x, y + v_speed * DELTA, obj_solid) && v_speed != 0) {
	
		var _one_pixel = sign(v_speed);
	
		while (!place_meeting(x, y + _one_pixel, obj_solid)) {
			y += _one_pixel;
		}
	
		v_speed = 0;
	}
	
	y += v_speed * DELTA;
}