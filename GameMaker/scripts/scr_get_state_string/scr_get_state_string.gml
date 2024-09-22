function scr_get_state_string(_state) {
	
	switch(_state) {
		case ENTITY_STATE.MOVING:
			return "moving"
		case ENTITY_STATE.JUMP:
			return "jump"
		case ENTITY_STATE.IDLE:
			return "idle"
		case ENTITY_STATE.HURT:
			return "hurt"
		default:
			return "unknown";
	}
	
}