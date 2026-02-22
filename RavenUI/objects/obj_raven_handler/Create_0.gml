/// @description Handler init

#region mouse coordinate spaces
mouse_x_previous = global.canvas_mouse_x;
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

#region zooming 
canvas_zoom = 1.0;
canvas_zoom_min = 0.25;
canvas_zoom_max = 4.0;
canvas_zoom_step = 0.1;
canvas_offset_x = 0;
canvas_offset_y = 0;
#endregion

#region zoom indicator
zoom_indicator_alpha = 1;
zoom_indicator_fade_delay = 120;
zoom_indicator_timer = zoom_indicator_fade_delay;
canvas_zoom_previous = -1;

#endregion

function canvas_mouse_x() {
    return (global.canvas_mouse_x - canvas_offset_x) / canvas_zoom;
}
function canvas_mouse_y() {
    return (global.canvas_mouse_y - canvas_offset_y) / canvas_zoom;
}