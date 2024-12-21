event_inherited();

if (global.debug) {
	
	var _xx = scr_get_x_to_gui(x);
	var _yy = scr_get_y_to_gui(y);

	var _bbox_left = scr_get_x_to_gui(bbox_left);
	var _bbox_top = scr_get_y_to_gui(bbox_top);
	var _bbox_right = scr_get_x_to_gui(bbox_right);
	var _bbox_bottom = scr_get_y_to_gui(bbox_bottom);

	// Draw animation percent
	draw_set_halign(fa_left);
	// draw_text(_bbox_left, _yy + 32, "anim_perc: " + string(attack_1_lunge_percent));
}