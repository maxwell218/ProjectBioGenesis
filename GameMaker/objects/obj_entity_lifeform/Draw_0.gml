/// @description 

var _xx = x;
var _yy = y;

// Shadow
// TODO Make a shader based shadow
draw_sprite_ext(sprite_index, image_index, _xx + 1, _yy + 1, image_xscale, image_yscale, rotation_angle - 90, c_black, 0.5);

if (entity_state != ENTITY_STATE.DEAD) {
	draw_sprite_ext(spr_legs, legs_image_index, _xx, _yy, image_xscale, image_yscale, moving_angle - 90, c_black, 1);
}
