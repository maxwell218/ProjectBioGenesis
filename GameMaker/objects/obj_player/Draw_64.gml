event_inherited();

var _xx = scr_get_x_to_gui(x);
var _yy = scr_get_y_to_gui(y);

var _bbox_left = scr_get_x_to_gui(bbox_left);
var _bbox_top = scr_get_y_to_gui(bbox_top);
var _bbox_right = scr_get_x_to_gui(bbox_right);
var _bbox_bottom = scr_get_y_to_gui(bbox_bottom);

if (global.debug) {
	draw_set_halign(fa_center);
	var _state = equipment_state_manager.get_active_state_string();
	draw_text(_bbox_left, _yy - healthbar_height - healthbar_y_offset - (string_height(_state) * 1.6), _state);
}