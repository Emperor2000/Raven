// Function to calculate distance between two points
function distance_between_points(_x0, _y0, _x1, _y1) {
    var _dx = _x1 - _x0;
    var _dy = _y1 - _y0;
    return sqrt(_dx * _dx + _dy * _dy);
}

// Function to draw a line between two points
function draw_line(_x0, _y0, _x1, _y1) {
    // Your implementation of draw_line function
}

// Function to draw a curved line between two points
function draw_curve(_x0, _y0, _x1, _y1, _line_color, _line_width) {
    // Calculate the number of segments based on desired smoothness and line length
    var _num_segments = round(distance_between_points(_x0, _y0, _x1, _y1) / 5);
  
    // Loop through each segment and draw a short line with slight bend
    for (var i = 0; i < _num_segments; i++) {
        var _progress = i / (_num_segments - 1);  // 0 to 1 for smooth transition
        var _bend_factor = _progress * (_progress - 0.5) * 5; // Adjust bend based on _progress (center point has least bend)
    
        var _x2 = lerp(_x0, _x1, _progress);
        var _y2 = lerp(_y0, _y1, _progress);
    
        var _offset_x = sign(_y1 - _y0) * _bend_factor;  // Adjust offset based on direction
        var _offset_y = -sign(_x1 - _x0) * _bend_factor;
    
        draw_line(_x2 + _offset_x, _y2 + _offset_y, _x2 - _offset_x, _y2 - _offset_y);
    }
}

function draw_sinus_curve(start_x, start_y, end_x, end_y, amplitude, frequency, color, thickness) {
	var delta_x = end_x - start_x;
	var delta_y = end_y - start_y;
	var distance = point_distance(start_x, start_y, end_x, end_y);
	var num_points = distance;

	for (var i = 0; i < num_points; i++) {
	    var t = i / num_points;
	    var _x = start_x + t * delta_x;
	    var _y = start_y + t * delta_y;
	    var t_mapped = map(t, 0, 1, 0, frequency * pi); // Smoothly increase frequency along the curve
	    var sine_offset = amplitude * sin(t_mapped);
	    draw_circle(_x, _y + sine_offset, thickness, true);
	}
}

// Helper function to map a value from one range to another
function map(value, start1, stop1, start2, stop2) {
    return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
}