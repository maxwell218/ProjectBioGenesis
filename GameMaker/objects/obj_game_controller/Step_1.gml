/// @description Delta Time

global.actual_delta = delta_time/1000000;
global.delta_multiplier = global.actual_delta/global.target_delta;
DELTA = global.delta_multiplier;

EXIT_IF_FPS_NOT_SUPPORTED;