#region context menu drawing
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _w = 120;
var _h = 32;
var _padding = 8;

if (context_menu_open) {
    var _x = context_menu_x;
    var _y = context_menu_y;
    draw_set_font(fnt_dsansmono16);
    draw_set_halign(fa_left);
    
    if (!context_menu_confirming) {
        var _hover = point_in_rectangle(_mx, _my, _x, _y, _x + _w, _y + _h);
        draw_set_color(GUI_DARK_MENU);
        draw_rectangle(_x, _y, _x + _w, _y + _h, false);
        draw_set_color(GUI_DARK_OUTLINE);
        draw_rectangle(_x, _y, _x + _w, _y + _h, true);
        draw_set_color(_hover ? c_red : GUI_DARK_TEXT_DEFAULT);
        draw_text(_x + _padding, _y + _padding, "Delete");
    } else {
        var _hover_confirm = point_in_rectangle(_mx, _my, _x, _y, _x + _w, _y + _h);
        draw_set_color(_hover_confirm ? GUI_DARK_MENU_CLICK : GUI_DARK_MENU);
        draw_rectangle(_x, _y, _x + _w, _y + _h, false);
        draw_set_color(GUI_DARK_OUTLINE);
        draw_rectangle(_x, _y, _x + _w, _y + _h, true);
        draw_set_color(c_red);
        draw_text(_x + _padding, _y + _padding, "Confirm");
        
        var _hover_cancel = point_in_rectangle(_mx, _my, _x, _y + _h, _x + _w, _y + _h * 2);
        draw_set_color(_hover_cancel ? GUI_DARK_MENU_CLICK : GUI_DARK_MENU);
        draw_rectangle(_x, _y + _h, _x + _w, _y + _h * 2, false);
        draw_set_color(GUI_DARK_OUTLINE);
        draw_rectangle(_x, _y + _h, _x + _w, _y + _h * 2, true);
        draw_set_color(GUI_DARK_TEXT_DEFAULT);
        draw_text(_x + _padding, _y + _h + _padding, "Cancel");
    }
}

if (context_menu_canvas_open) {
    var _x = context_menu_x;
    var _y = context_menu_y;
    draw_set_font(fnt_dsansmono16);
    draw_set_halign(fa_left);
    
    var _hover = point_in_rectangle(_mx, _my, _x, _y, _x + _w, _y + _h);
    draw_set_color(GUI_DARK_MENU);
    draw_rectangle(_x, _y, _x + _w, _y + _h, false);
    draw_set_color(GUI_DARK_OUTLINE);
    draw_rectangle(_x, _y, _x + _w, _y + _h, true);
    draw_set_color(_hover ? GUI_DARK_TEXT_PRIMARY : GUI_DARK_TEXT_DEFAULT);
    draw_text(_x + _padding, _y + _padding, "Create Node");
}
#endregion