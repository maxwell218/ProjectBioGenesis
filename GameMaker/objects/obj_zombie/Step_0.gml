/// @description 
event_inherited();
EXIT_IF_FPS_NOT_SUPPORTED

switch(entity_state) {
	case ENTITY_STATE.IDLE:
		if (entity_inner_state == INNER_STATE.ENTER) {
			
			// Handle Idle State
			// sprite_index = spr_capsule_idle;
			entity_inner_state = INNER_STATE.UPDATE;
			
		} else if (entity_inner_state == INNER_STATE.UPDATE) {
			if (image_index == sprite_get_number(spr_zombie_idle) - 1) {
				image_speed = 0;
				image_index = 0;
				alarm[0] = idle_anim_cooldown;
			} else if (!alarm[0] && image_speed == 0) {
				show_debug_message("scream for " + string(id));
				image_speed = 1;
			}
			
		
			// Transition to Jumping State if jumping
			/*
			if (key_jump || !on_ground) {
				entity_inner_state = INNER_STATE.ENTER;
			    entity_state = ENTITY_STATE.JUMP;
			}
			*/

			// Transition to Moving State if moving
		}
        
	    break;
}