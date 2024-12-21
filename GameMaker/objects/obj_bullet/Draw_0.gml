/// @description 

var _current_x = prev_x + lengthdir_x(1, image_angle);
var _current_y = prev_y + lengthdir_y(1, image_angle);

if (check) {
	// Repeat for each pixel in view
	repeat(view_get_wport(view_current)) {
		var _collision = collision_line(prev_x, prev_y, _current_x, _current_y, obj_enemy_parent, true, true);
		if (_collision != noone) {
			check = false;
			if (can_damage && _collision.main_state_manager.active_state != _collision.dead_state) {
				with (_collision) {
					// TODO Set damage properly
					entity_health -= 4;
				}
			} 
			
			if (_collision.main_state_manager.active_state == _collision.dead_state) {
				check = true;
			}
			
			if (!check) {
				break;	
			}
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
		_current_x = prev_x + lengthdir_x(1, image_angle);
		_current_y = prev_y + lengthdir_y(1, image_angle);
	}
}

draw_alpha -= fade_out_speed;

draw_set_alpha(draw_alpha);
draw_line(x, y, _current_x, _current_y);
draw_set_alpha(1);

if (draw_alpha <= 0) {
	instance_destroy();	
}