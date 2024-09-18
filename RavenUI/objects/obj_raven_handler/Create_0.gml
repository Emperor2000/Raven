/// @description Handler init

#region mouse coordinate spaces
mouse_x_previous = device_mouse_x_to_gui(0);
mouse_y_previous = mouse_y;
global.mouse_x_diff = 0;
global.mouse_y_diff = 0;

#endregion

#region Selection
global.raven_occupied = false;
#endregion


#region Keyboard Check limiting.
global.keyboard_check_counters = ds_map_create();
global.keyboard_lock_duration = 5;
#endregion


//node map
global.node_map = ds_map_create();


//Disable multiple actions at the same time.
is_new_interactions_locked = false;
new_interactions_locked_duration_in_frames_remaining = 0;

function lock_new_interactions(_duration) {
	is_new_interactions_locked = true;
	new_interactions_locked_duration_in_frames_remaining = 3;
}
