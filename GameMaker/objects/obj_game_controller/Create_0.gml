/// @description Initializing Game Controller

randomize();

#region Game Variables

// Debug & Version
// First number for huge changes
// Second new changes for the same version number
// Third number for hotfixes
version_number = "v0.0.1";
global.debug = false;

// Resizes the application surface to fit within theglo view port
display_set_gui_size(view_wport[0], view_hport[0]);
// surface_resize(application_surface, view_wport[0], view_hport[0]);

#endregion

room_goto(rm_test);

#region Game Rules

global.max_stacksize = 10;
global.tile_size = 16;
global.gui_scale = 3;

#endregion

#region Delta Time

game_set_speed(144, gamespeed_fps);
global.target_framerate = 60;
global.target_delta = 1/global.target_framerate;
global.actual_delta = delta_time/1000000;
global.delta_multiplier = global.actual_delta/global.target_delta;

#endregion

#region Macros

#macro DELTA global.delta_multiplier
#macro ALARM_INACTIVE -100
#macro MIN_DELTA_TIME_SUPPORTED (1 / 144)
#macro MAX_DELTA_TIME_SUPPORTED (1 / 30)
#macro EXIT_IF_FPS_NOT_SUPPORTED if (scr_is_delta_time_supported() == false) { exit }

#endregion