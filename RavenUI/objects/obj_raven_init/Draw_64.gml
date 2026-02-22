//raven_gui.Render();

// Render static containers at normal scale (background)
for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
    var _container = ds_list_find_value(global.raven_containers, _i);
    if (!_container.is_static) continue;
    _container.Render();
}

// Render menu bar at normal scale
raven_gui.menu.Render();

// Apply zoom + pan matrix for canvas nodes
var _matrix = matrix_build(
    global.handler.canvas_offset_x, global.handler.canvas_offset_y, 0,
    0, 0, 0,
    global.handler.canvas_zoom, global.handler.canvas_zoom, 1
);
matrix_set(matrix_world, _matrix);

// Render non-static containers through the matrix
for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
    var _container = ds_list_find_value(global.raven_containers, _i);
    if (_container.is_static) continue;
    _container.Render();
}

// Reset matrix
matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));


// Zoom level indicator
if (global.handler.zoom_indicator_alpha > 0) {
    var _zoom_percent = "Zoom: " + string(round(global.handler.canvas_zoom * 100)) + "%";
    draw_set_font(fnt_dsansmono16);
    draw_set_halign(fa_right);
    draw_set_alpha(global.handler.zoom_indicator_alpha);
    draw_set_color(GUI_DARK_TEXT_OPTIONAL);
    draw_text(window_get_width() - 100, 100, _zoom_percent);
    draw_set_halign(fa_left);
    draw_set_alpha(1);
}