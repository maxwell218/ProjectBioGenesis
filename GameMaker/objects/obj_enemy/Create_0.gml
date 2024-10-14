/// @description General Enemy Variables
event_inherited();

entity_health = 10;
entity_max_health = 10;
entity_damage_on_touch = 0;
entity_state = ENTITY_STATE.IDLE;
entity_inner_state = INNER_STATE.ENTER;

enum ENEMY_STATE {
	WANDER = 30,
	CHASE = 31,
	FLEE = 32,
}