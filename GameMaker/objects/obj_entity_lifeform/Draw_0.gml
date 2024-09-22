/// @description 

var _xx = floor(x + .5);
var _yy = floor(y + .5);

draw_sprite_ext(sprite_index, image_index, _xx, _yy, image_xscale, image_yscale, rotation_angle - 90, c_white, 1);

if (global.debug) {
	
	// Draw collision box
	draw_set_alpha(0.5);
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_blue, c_blue, c_blue, c_blue, false);
	draw_set_alpha(1);
	
	// Draw current entity state
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	var _state = scr_get_state_string(entity_state);
	draw_text(x, bbox_top - healthbar_height - healthbar_y_offset - string_height(_state), _state);
	
	// var _hurt_alarm = alarm_array[0];
	// draw_text(x, y - sprite_get_height(sprite_index) - string_height(_hurt_alarm) - 15, _hurt_alarm);
	// var _regen_alarm = alarm_array[ALARM_ARRAY.REGEN];
	// draw_text(x, y - sprite_get_height(sprite_index) - string_height(_regen_alarm) - 15, _regen_alarm);
	
	// Draw speed and position
	draw_set_halign(fa_left);
	draw_text(bbox_left, y, "hspd: " + string(h_speed));
	draw_text(bbox_left, y + 16, "vspd: " + string(v_speed));
	
	draw_text(bbox_left, y + 32, x);
	draw_text(bbox_left, y + 48, y);
	draw_text(bbox_left, y + 64, rotation_angle);
	// draw_text(bbox_left, y + 32, image_angle);
	// draw_text(bbox_left, y + 48, percent);
	// draw_text(bbox_left, y + 64, position);
}