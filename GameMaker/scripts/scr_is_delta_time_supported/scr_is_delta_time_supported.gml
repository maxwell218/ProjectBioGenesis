/// @description Simple helper script to check if delta time is outside of the supported values.  The idea is that if it's outside the supported values, we exit events before anything bad can happen.
/// @return {Bool} Whether the FPS is within the acceptable limits (true) or not (false).
function scr_is_delta_time_supported() {

	return global.actual_delta >= MIN_DELTA_TIME_SUPPORTED and global.actual_delta <= MAX_DELTA_TIME_SUPPORTED;
}