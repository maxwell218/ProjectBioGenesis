/// @description 
/*
EXIT_IF_FPS_NOT_SUPPORTED;

var _temp_x = x + x_frac;		// Add the fraction back to your position
x_frac = _temp_x % 1;				// Get the new fraction
var _x_int = _temp_x - x_frac;    // Get the rounded position
_temp_x = _x_int;					// Use that rounded position to place your object


if (!place_meeting(x, y + sign(v_speed) * DELTA, obj_solid)) {
	y += y_frac;				// Add the fraction back to your position
	y_frac = y % 1;				// Get the new fraction
	var _y_int = y - y_frac;	// Get the rounded position
	y = _y_int;					// Use that rounded position to place your object
}