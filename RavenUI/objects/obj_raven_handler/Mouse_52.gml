for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
	var _container = ds_list_find_value(global.raven_containers, _i);	
	_container.MovePriority(global.mouse_x_diff, global.mouse_y_diff);
}