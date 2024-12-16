/// @description 
event_inherited();

// Torso and leg rotation
if (player_is_in_vision_radius && (entity_state != ENTITY_STATE.ATTACK && entity_state != ENTITY_STATE.DEAD)) {
	if (instance_exists(obj_player)) {
		with (obj_player) {
			var _pd = point_direction(other.x, other.y, x, y);
			var _dd = angle_difference(other.rotation_angle, _pd);

			other.rotation_angle -= min(abs(_dd), other.rotation_speed * DELTA) * sign(_dd);
			other.moving_angle = other.rotation_angle;

			if (other.rotation_angle >= 360 || other.rotation_angle <= -360) {
				other.rotation_angle = 0;
			}
		}
	}
}


























