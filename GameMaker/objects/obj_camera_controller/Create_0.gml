/// @description Camera Variables
camera_width = camera_get_view_width(view_camera[0]);
camera_height = camera_get_view_height(view_camera[0]);

follow = obj_player;

// Panning left to right only
target_x = x;
target_y = y;

// TODO might change
target_y_offset = sprite_get_height(obj_player.sprite_index) / 2;

min_view_x = 0 + camera_width / 2;
max_view_x = room_width - camera_width / 2;

min_view_y = 0 + camera_height / 2;
max_view_y = room_height - camera_height / 2;