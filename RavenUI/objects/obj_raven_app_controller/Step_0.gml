if (mouse_check_button_pressed(mb_right)) {
    show_debug_message("right click detected");
    show_debug_message("canvas_mouse_x: " + string(global.canvas_mouse_x));
    show_debug_message("canvas_mouse_y: " + string(global.canvas_mouse_y));
    show_debug_message("raven_containers count: " + string(ds_list_size(global.raven_containers)));
    
    var _hit_container = false;
    for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
        var _container = ds_list_find_value(global.raven_containers, _i);
        show_debug_message("container " + string(_i) + " lock:" + string(_container.lock) + " is_static:" + string(_container.is_static));
        show_debug_message("container bounds: " + string(_container.x0) + "," + string(_container.y0) + " to " + string(_container.x1) + "," + string(_container.y1));
        
        if (_container.lock || _container.is_static) continue;
        
        if (point_in_rectangle(
            global.canvas_mouse_x, global.canvas_mouse_y,
            _container.x0, _container.y0,
            _container.x1, _container.y1
        )) {
            show_debug_message("hit container " + string(_i));
            context_menu_open = true;
            context_menu_target = _container;
            context_menu_x = device_mouse_x_to_gui(0);
            context_menu_y = device_mouse_y_to_gui(0);
            _hit_container = true;
            break;
        }
    }
    
    if (!_hit_container) {
        show_debug_message("no container hit - opening canvas menu");
        context_menu_canvas_open = true;
        context_menu_x = device_mouse_x_to_gui(0);
        context_menu_y = device_mouse_y_to_gui(0);
    }
}
// Container context menu clicks
if (context_menu_open && mouse_check_button_pressed(mb_left)) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    if (!context_menu_confirming) {
        if (point_in_rectangle(_mx, _my, context_menu_x, context_menu_y, context_menu_x + 120, context_menu_y + 32)) {
            context_menu_confirming = true;
        } else {
            context_menu_open = false;
            context_menu_target = noone;
            context_menu_confirming = false;
        }
    } else {
        if (point_in_rectangle(_mx, _my, context_menu_x, context_menu_y, context_menu_x + 120, context_menu_y + 32)) {
            if (context_menu_target != noone) {
                RemoveContainerFromCanvas(context_menu_target);
            }
            context_menu_open = false;
            context_menu_target = noone;
            context_menu_confirming = false;
        }
        if (point_in_rectangle(_mx, _my, context_menu_x, context_menu_y + 32, context_menu_x + 120, context_menu_y + 64)) {
            context_menu_open = false;
            context_menu_target = noone;
            context_menu_confirming = false;
        }
    }
}

// Canvas context menu clicks
if (context_menu_canvas_open && mouse_check_button_pressed(mb_left)) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    if (point_in_rectangle(_mx, _my, context_menu_x, context_menu_y, context_menu_x + 120, context_menu_y + 32)) {
        SpawnNode(global.canvas_mouse_x, global.canvas_mouse_y);
    }
    context_menu_canvas_open = false;
}
#endregion