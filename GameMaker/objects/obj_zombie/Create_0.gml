/// @description 
event_inherited();

// Vision & Attack Variables
player_is_in_vision_radius = false;
vision_radius = 110;
vision_cone_angle = 135;
attack_cone_angle = 80;
attack_1_distance_trigger = 8;
attack_1_lunge_curve = animcurve_get_channel(ac_zombie_lunge, "curve1");
attack_1_lunge_percent = 0;
attack_1_damage = 2;
has_attacked = false;
max_speed_while_chasing = .7;
max_speed_while_lunging = .9;

// Animation Variables
idle_anim_cooldown = round(random_range(120, 420));	
has_legs = true;

#region Movement Variables

max_speed = .7;
rotation_angle = random_range(0, 360);	// Rotation of the sprite
rotation_speed = 5;						// Speed of the rotation
moving_direction = 0;					// Direction of movement
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
				if (point_in_angle(x, y, _player.x, _player.y, vision_cone_angle, rotation_angle)) {
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
				if (point_in_angle(x, y, _player.x, _player.y, attack_cone_angle, rotation_angle)) {
					return true;
				}
			}
		}	
		
		return false;
}

function rotate_towards_player() {
	if (instance_exists(obj_player)) {
		var _player = instance_find(obj_player, 0);
		var _pd = point_direction(x, y, _player.x, _player.y);
		var _dd = angle_difference(rotation_angle, _pd);

		rotation_angle -= min(abs(_dd), rotation_speed * DELTA) * sign(_dd);

		clamp_rotation(rotation_angle);
		
		moving_direction = rotation_angle;
	}
}

#endregion

#region States
main_state_manager = new StateManager();

scr_zombie_states();
	
main_state_manager.init_state(idle_state);

#endregion