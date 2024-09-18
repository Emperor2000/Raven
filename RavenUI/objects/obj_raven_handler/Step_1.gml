/// @description Insert description here
// You can write your code in this editor
//reset mouse cursor
window_set_cursor(cr_default);


if (is_new_interactions_locked) {
	new_interactions_locked_duration_in_frames_remaining -= 1;
}

if (new_interactions_locked_duration_in_frames_remaining <= 0) {
	new_interactions_locked_duration_in_frames_remaining = 0;
	is_new_interactions_locked = false;
}