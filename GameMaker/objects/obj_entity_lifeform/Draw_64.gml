/// @description Draw Entity Info

// Draw healthbar
if (entity_health != entity_max_health) {
	var _left = floor(x - sprite_get_width(sprite_index) / 2 + .5);
	var _right = floor(x + sprite_get_width(sprite_index) / 2 + .5);
	var _top = floor(bbox_top - healthbar_height - healthbar_y_offset + .5);
	var _bottom = floor(bbox_top - healthbar_y_offset + .5);
	draw_healthbar(_left, _top, _right, _bottom, entity_health / entity_max_health * 100, c_black, c_red, c_lime, 0, true, false);
}