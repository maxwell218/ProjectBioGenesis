/// @description 
event_inherited();

if (player_is_in_vision_radius) {
	if (instance_exists(obj_player)) {
		with (obj_player) {
			var _pd = point_direction(other.x, other.y, x, y);
			var _dd = angle_difference(other.rotation_angle, _pd);

			other.rotation_angle -= min(abs(_dd), other.rotation_speed) * sign(_dd) * DELTA;

			if (other.rotation_angle >= 360 || other.rotation_angle <= -360) {
				other.rotation_angle = 0;	
			}
		}
	}
}


























