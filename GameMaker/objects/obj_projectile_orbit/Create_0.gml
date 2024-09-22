/// @description Initialize Projectile Stats
follow = obj_player;

orbit_distance = 32;	// Orbit distance
orbit_angle = 0;		// Current orbital angle
orbit_speed = 2;		// Orbital speed

center_x = 0;			// Orbital center x
center_y = 0;			// Orbital center y

// Offset to the center of our follow object
center_offset_y = sprite_get_height(obj_player.sprite_index) / 2;

#region Method Functions

function update_center_orbit() {
	center_x = obj_player.x;				
	center_y = obj_player.y - center_offset_y;
}

#endregion