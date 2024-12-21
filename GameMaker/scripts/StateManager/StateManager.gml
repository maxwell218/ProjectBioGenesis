// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function StateManager() constructor {
	active_state = new State();
	
	function run_state() {
		active_state.run();	
	}

	function change_state(_state) {
		active_state.stop();
		active_state = _state;
		active_state.start();
	}

	function init_state(_state) {
		active_state = _state;
		active_state.start();
	}

	function get_active_state_string() {
		return active_state.to_string();
	}
}

