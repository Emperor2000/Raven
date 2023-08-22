// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DestroyRavenContainerById(_container_id){
	show_debug_message("container id: " + _container_id);
	if (global.raven_debug) show_debug_message("RAVENDEBUG: Attempting to destroy a container with id: " + string(_container_id));
	var _res = GetRavenContainerIndexById(_container_id);
	//obj_raven_init.raven_gui.DestroyContainer(_res, _container_id);
	//for (var i = 0; i < ds_list_size(global.raven_containers); i++) {
	//	var _container = ds_list_find_value(global.raven_containers, i);
	//	if (_container.container_id == _container_id) {
	//		ds_list_delete(global.raven_containers, i);
	//	}
	//}
	
	if (_res != -1 && _res != noone && _res != undefined) {
		ds_list_delete(global.raven_containers, _res);
	}
	
	if (_res == -1) {
		if (global.raven_debug) show_debug_message("RAVENDEBUG: Container with id: " + string(_container_id) + " Could not be found in global containers");	
	}
}