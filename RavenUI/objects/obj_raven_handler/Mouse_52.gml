canvas_offset_x += global.mouse_x_diff * canvas_zoom;
canvas_offset_y += global.mouse_y_diff * canvas_zoom;

var _pan_x = global.mouse_x_diff / canvas_zoom;
var _pan_y = global.mouse_y_diff / canvas_zoom;

//for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
//    var _container = ds_list_find_value(global.raven_containers, _i);	
//    _container.MovePriority(_pan_x, _pan_y);
//}