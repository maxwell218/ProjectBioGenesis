/// @description 
event_inherited();

// Vision Variables
player_is_in_vision_radius = false;
vision_radius = 110;
vision_cone_angle = 135;
attack_cone_angle = 70;

// Animation Variables
image_speed = 0;
idle_anim_cooldown = round(random_range(120, 420));	
has_legs = true;

#region Movement Variables

max_speed = .7;
rotation_speed = 3;
moving_direction = 0;
h_speed = 0;
v_speed = 0;

accel = .2;
decel = .1;

#endregion

#region Functions

function reset_idle_cooldown() {
	idle_anim_cooldown = round(random_range(120, 420));	
}

function player_entered_vision_radius() {
	if (!player_is_in_vision_radius) {
		// Check if within radius
		var _player = instance_find(obj_player, 0);
		if (_player != noone) {
			if (point_in_circle(_player.x, _player.y, x, y, vision_radius)) {
				if (point_in_angle(x, y, _player.x, _player.y, vision_cone_angle, moving_angle)) {
					player_is_in_vision_radius = true;
				}
			}
		}
	}
}

function player_left_vision_radius() {
	if (player_is_in_vision_radius) {
		// Check if outside radius
		var _player = instance_find(obj_player, 0);
		if (_player != noone) {
			if (!point_in_circle(_player.x, _player.y, x, y, vision_radius)) {
				player_is_in_vision_radius = false;
			}
		}
	}
}

function check_vision_radius() {
	player_entered_vision_radius();
	player_left_vision_radius();
}
	
function player_is_in_attack_cone() {
	var _player = instance_find(obj_player, 0);
		if (_player != noone) {
			if (point_in_circle(_player.x, _player.y, x, y, vision_radius)) {
				if (point_in_angle(x, y, _player.x, _player.y, attack_cone_angle, moving_angle)) {
					return true;
				}
			}
		}	
		
		return false;
}

#endregion