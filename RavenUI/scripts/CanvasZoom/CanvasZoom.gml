function CanvasZoom(_amount, _origin_x, _origin_y) {
    var _old_zoom = canvas_zoom;
    canvas_zoom = clamp(canvas_zoom + _amount, canvas_zoom_min, canvas_zoom_max);
    if (canvas_zoom == _old_zoom) exit;

    canvas_offset_x = device_mouse_x_to_gui(0) - _origin_x * canvas_zoom;
    canvas_offset_y = device_mouse_y_to_gui(0) - _origin_y * canvas_zoom;
}
//function CanvasZoom(_amount, _origin_x, _origin_y) {
//    var _old_zoom = canvas_zoom;
//    canvas_zoom = clamp(canvas_zoom + _amount, canvas_zoom_min, canvas_zoom_max);
//    if (canvas_zoom == _old_zoom) exit;

//    // Adjust offset so the canvas-space origin stays fixed on screen
//    canvas_offset_x = (canvas_offset_x - _origin_x * canvas_zoom) + _origin_x * canvas_zoom;
//    canvas_offset_y = (canvas_offset_y - _origin_y * canvas_zoom) + _origin_y * canvas_zoom;
    
//    // Recalculate offset to pin the origin point
//    //canvas_offset_x += _origin_x * (_old_zoom - canvas_zoom);
//    //canvas_offset_y += _origin_y * (_old_zoom - canvas_zoom);
//	canvas_offset_x += global.mouse_x_diff;
//	canvas_offset_y += global.mouse_y_diff;
//}