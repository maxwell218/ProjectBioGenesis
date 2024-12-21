// Lantern position offsets
lantern_rotation_angle = 0;

target_x = x;
target_y = y;

function draw_held_object() {
	// Draw each part of the lantern with slight adjustments

	// Bottom part
	draw_sprite_ext(spr_lantern_light, 1, target_x, target_y, 1, 1, 0, c_white, 1);

	// Middle part 
	draw_sprite_ext(spr_lantern_top, 1, x, y, 1, 1, 0, c_white, 1);

	// Top part 
	// draw_sprite_ext(spr_lantern_top, 1, x, y, 1, 1, lantern_rotation_angle, c_white, 1);

}