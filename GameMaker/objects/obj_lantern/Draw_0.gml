// Draw each part of the lantern with slight adjustments

// Bottom part
draw_sprite_ext(spr_lantern_bottom, 1, x, y, 1, 1, lantern_rotation_angle, c_white, 1);

// Middle part (slight additional sway for depth effect)
draw_sprite_ext(spr_lantern_light, 1, x, y, 1, 1, lantern_rotation_angle, c_white, 1);

// Top part (less sway for realism)
draw_sprite_ext(spr_lantern_top, 1, x, y, 1, 1, lantern_rotation_angle, c_white, 1);

if (global.debug) {
	draw_text(x, y, lantern_rotation_angle);	
}