/// @description Draw Vision Radius
event_inherited();

if (global.debug) {
	draw_set_halign(fa_center);
	draw_set_alpha(0.1);
	
	draw_circle(x, y, vision_radius, false);
	draw_set_alpha(1);
	draw_text(x, y - 22, alarm[0]);
	draw_text(x, y - 48, image_index);
	
	draw_set_halign(fa_left);
}