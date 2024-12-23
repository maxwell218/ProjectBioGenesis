if (global.debug) {
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	// draw_text(0, 0, room_get_name(room));

	if (instance_exists(obj_player)) {
		// draw_text(0, 16, obj_player.entity_health);	
	}

	draw_set_halign(fa_right);
	draw_set_valign(fa_top);
	
	draw_text(camera_get_view_width(view_camera[0]), 0, "delta: " + string(DELTA));
	draw_text(camera_get_view_width(view_camera[0]), 16, "fps: " + string(fps));
}