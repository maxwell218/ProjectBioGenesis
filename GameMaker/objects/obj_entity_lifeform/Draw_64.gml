var _xx = scr_get_x_to_gui(x);
var _yy = scr_get_y_to_gui(y);

var _bbox_left = scr_get_x_to_gui(bbox_left);
var _bbox_top = scr_get_y_to_gui(bbox_top);
var _bbox_right = scr_get_x_to_gui(bbox_right);
var _bbox_bottom = scr_get_y_to_gui(bbox_bottom);

if (global.debug) {
	
	// Draw collision box
	draw_set_alpha(0.5);
	draw_rectangle_color(_bbox_left, _bbox_top, _bbox_right, _bbox_bottom, c_blue, c_blue, c_blue, c_blue, false);
	draw_set_alpha(1);
	
	// Draw feelers
	// draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_blue, c_blue, c_blue, c_blue, false);
	
	// Draw current entity state
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	var _state = scr_get_state_string(entity_state);
	draw_text(_bbox_left, _yy - healthbar_height - healthbar_y_offset - string_height(_state), _state);
	
	// var _hurt_alarm = alarm_array[0];
	// draw_text(x, y - sprite_get_height(sprite_index) - string_height(_hurt_alarm) - 15, _hurt_alarm);
	// var _regen_alarm = alarm_array[ALARM_ARRAY.REGEN];
	// draw_text(x, y - sprite_get_height(sprite_index) - string_height(_regen_alarm) - 15, _regen_alarm);
	
	// Draw speed and position
	draw_set_halign(fa_left);
	draw_text(_bbox_left, _yy, "hspd: " + string(h_speed));
	draw_text(_bbox_left, _yy + 16, "vspd: " + string(v_speed));
	
	// draw_text(bbox_left, y + 32, x);
	// draw_text(bbox_left, y + 48, y);
	// draw_text(bbox_left, y + 64, rotation_angle);
	// draw_text(bbox_left, y + 32, image_angle);
	//draw_text(_bbox_left, _yy + 32, moving_direction);
	draw_text(_bbox_left, _yy + 32, legs_image_index);
	// draw_text(bbox_left, y + 48, percent);
	// draw_text(bbox_left, y + 64, position);
}

// Draw healthbar
if (entity_health != entity_max_health && entity_state != ENTITY_STATE.DEAD) {
	var _left = floor(_xx - 16 / 2 + .5);
	var _right = floor(_xx + 16 / 2 + .5);
	var _top = floor(_yy - healthbar_height - healthbar_y_offset + .5);
	var _bottom = floor(_yy - healthbar_y_offset + .5);
	
	draw_healthbar(_left, _top, _right, _bottom, entity_health / entity_max_health * 100, c_black, c_red, c_lime, 0, true, false);
}