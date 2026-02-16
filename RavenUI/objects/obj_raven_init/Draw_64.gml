//raven_gui.Render();

// 1. Render static containers at normal scale (background)
for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
    var _container = ds_list_find_value(global.raven_containers, _i);
    if (!_container.is_static) continue;
    _container.Render();
}

// 2. Render menu bar at normal scale
raven_gui.menu.Render();

// 3. Apply zoom + pan matrix for canvas nodes
var _matrix = matrix_build(
    global.handler.canvas_offset_x, global.handler.canvas_offset_y, 0,
    0, 0, 0,
    global.handler.canvas_zoom, global.handler.canvas_zoom, 1
);
matrix_set(matrix_world, _matrix);

// 4. Render non-static containers through the matrix
for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
    var _container = ds_list_find_value(global.raven_containers, _i);
    if (_container.is_static) continue;
    _container.Render();
}

// 5. Reset matrix
matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));