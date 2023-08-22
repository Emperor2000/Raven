/// @description RavenGUI Update loop (core)


//determine x and y diff from last frame
global.mouse_x_diff = device_mouse_x_to_gui(0) - mouse_x_previous;
global.mouse_y_diff = device_mouse_y_to_gui(0) - mouse_y_previous;

//debug x and y diff
//show_debug_message(global.mouse_x_diff);
//show_debug_message(global.mouse_y_diff);


//store previous x and y
mouse_x_previous = device_mouse_x_to_gui(0);
mouse_y_previous = device_mouse_y_to_gui(0);

//reset cursor
//window_set_cursor(cr_default);