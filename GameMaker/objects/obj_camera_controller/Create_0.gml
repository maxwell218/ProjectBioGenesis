/// @description Camera Variables
camera_width = camera_get_view_width(view_camera[0]);
camera_height = camera_get_view_height(view_camera[0]);

follow = obj_player;
shake = false;

target_x = x;
target_y = y;

// TODO might change
target_y_offset = sprite_get_height(spr_player_idle) / 2;

min_view_x = 0 + camera_width / 2;
max_view_x = room_width - camera_width / 2;

min_view_y = 0 + camera_height / 2;
max_view_y = room_height - camera_height / 2;

// Custom alarms using delta time
alarm_count = 1;
for (var _i = 0; _i < alarm_count; _i++) {
	alarm_array[_i] = ALARM_INACTIVE;	
}

function screen_shake(_force) {
	shake = true;
	alarm_array[0] = _force;
}