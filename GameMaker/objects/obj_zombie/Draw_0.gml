/// @description Draw Vision Radius
event_inherited();

if (global.debug) {
	draw_set_halign(fa_center);
	draw_set_alpha(0.1);
	
	// Draw Vision Radius
	draw_circle(x, y, vision_radius, false);
	draw_set_alpha(1);
	draw_text(x, y - 22, alarm[0]);
	
	// Draw Next Wander Coordinates
	// draw_text(x, y - 56, string(last_known_target_position_x) + ", " + string(last_known_target_position_y));
	
	// Draw Vision Cone
	draw_line(x, y, 
		x + lengthdir_x(vision_radius, rotation_angle - vision_cone_angle/2), 
		y + lengthdir_y(vision_radius, rotation_angle - vision_cone_angle/2));
		draw_line(x, y, 
		x + lengthdir_x(vision_radius, rotation_angle + vision_cone_angle/2), 
		y + lengthdir_y(vision_radius, rotation_angle + vision_cone_angle/2));
	
	draw_set_halign(fa_left);
}