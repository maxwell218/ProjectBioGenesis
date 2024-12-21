other.entity_health -= damage;
with(obj_camera_controller) {
	screen_shake(other.hit_force);
}