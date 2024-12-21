// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_custom_alarm() {
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
}