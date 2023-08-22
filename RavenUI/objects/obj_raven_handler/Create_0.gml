/// @description Handler init

#region mouse coordinate spaces
mouse_x_previous = device_mouse_x_to_gui(0);
mouse_y_previous = mouse_y;
global.mouse_x_diff = 0;
global.mouse_y_diff = 0;

#endregion

#region Selection
global.raven_occupied = false;
#endregion