/// @description Custom Alarm
EXIT_IF_FPS_NOT_SUPPORTED;

for (var _i = 0; _i < alarm_count; _i++) {
	
	// Reduce set timer
	if (alarm_array[_i] > 0) {
		alarm_array[_i] -= DELTA;
	}
	
	// Run alarm code
	else if (alarm_array[_i] <= 0 && alarm_array[_i] > ALARM_INACTIVE) {
		alarm_array[_i] = ALARM_INACTIVE;
		event_perform(ev_alarm, _i);
	}
}