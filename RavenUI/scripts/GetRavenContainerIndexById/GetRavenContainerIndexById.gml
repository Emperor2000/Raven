/// @Description returns a container struct instance by id by searching it in the global container list, otherwise returns -1
function GetRavenContainerIndexById(_container_id){
	//if global.raven_containers is not undefined and not noone
	if (global.raven_containers != undefined && global.raven_containers != noone) {
		//Loop over all container instances, and return the first instance that has a matching id
		for (var i = 0; i < ds_list_size(global.raven_containers); i++) {
			//get current
			var _container = ds_list_find_value(global.raven_containers, i) {
				if (_container.container_id == _container_id) return i;
			}
		}
	}
	return -1;
}