/// @description RavenGUI Update loop (core)


//determine x and y diff from last frame
//global.mouse_x_diff = global.canvas_mouse_x - mouse_x_previous;
//global.mouse_y_diff = global.canvas_mouse_y - mouse_y_previous;
global.mouse_x_diff = device_mouse_x_to_gui(0) - mouse_x_previous;
global.mouse_y_diff = device_mouse_y_to_gui(0) - mouse_y_previous;

//debug x and y diff
//show_debug_message(global.mouse_x_diff);
//show_debug_message(global.mouse_y_diff);


//store previous x and y
//mouse_x_previous = global.canvas_mouse_x;
//mouse_y_previous = global.canvas_mouse_y;
mouse_x_previous = device_mouse_x_to_gui(0);
mouse_y_previous = device_mouse_y_to_gui(0);

//reset cursor
//window_set_cursor(cr_default);

//#region zooming
//var _scroll = mouse_wheel_up() - mouse_wheel_down();
//if (_scroll != 0) {
//    var _origin_x = (device_mouse_x_to_gui(0) - canvas_offset_x) / canvas_zoom;
//    var _origin_y = (device_mouse_y_to_gui(0) - canvas_offset_y) / canvas_zoom;
//    CanvasZoom(_scroll * canvas_zoom_step, _origin_x, _origin_y);
//}
//#endregion
#region zooming
var _scroll = mouse_wheel_up() - mouse_wheel_down();
if (_scroll != 0) {
    var _origin_x = (device_mouse_x_to_gui(0) - canvas_offset_x) / canvas_zoom;
    var _origin_y = (device_mouse_y_to_gui(0) - canvas_offset_y) / canvas_zoom;
    CanvasZoom(_scroll * canvas_zoom_step, _origin_x, _origin_y);
}
#endregion

#region canvas matrix mouse tracking
global.canvas_mouse_x = (device_mouse_x_to_gui(0) - canvas_offset_x) / canvas_zoom;
global.canvas_mouse_y = (device_mouse_y_to_gui(0) - canvas_offset_y) / canvas_zoom;
#endregion


#region zoom indicator visibility
if (canvas_zoom != canvas_zoom_previous) {
    zoom_indicator_alpha = 1;
    zoom_indicator_timer = zoom_indicator_fade_delay;
}
canvas_zoom_previous = canvas_zoom;

if (zoom_indicator_timer > 0) {
    zoom_indicator_timer--;
} else {
    zoom_indicator_alpha = max(0, zoom_indicator_alpha - 0.02); // gentle fade
}
#endregion