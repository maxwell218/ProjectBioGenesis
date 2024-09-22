/// @description 

var _current_x = prev_x + lengthdir_x(3, image_angle);
var _current_y = prev_y + lengthdir_y(3, image_angle);

if (check) {
	repeat(300) {
		var _collision = collision_line(prev_x, prev_y, _current_x, _current_y, obj_enemy, true, true);
		if (_collision != noone) {
			check = false;
			if (can_damage) {
				instance_destroy(_collision);	
			}
			can_damage = false;
		}
		
		_collision = collision_line(prev_x, prev_y, _current_x, _current_y, obj_solid, true, true);
		if (_collision != noone) {
			check = false;
			can_damage = false;
			if (!check) {
				break;	
			}
		}
		
		prev_x = _current_x;
		prev_y = _current_y;
		_current_x = prev_x + lengthdir_x(3, image_angle);
		_current_y = prev_y + lengthdir_y(3, image_angle);
	}
}

draw_alpha -= 0.1;

draw_set_alpha(draw_alpha);
draw_line(x, y, _current_x, _current_y);
draw_set_alpha(1);

if (draw_alpha <= 0) {
	instance_destroy();	
}


























