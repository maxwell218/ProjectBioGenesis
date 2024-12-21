/// @description 
if (entity_health <= 0 && main_state_manager.active_state != dead_state) {
	main_state_manager.change_state(dead_state);
}



























