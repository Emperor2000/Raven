/// @Description Registers a container to the list of raven containers
function RegisterRavenContainer(_container_to_register){
	ds_list_add(global.raven_containers, _container_to_register);

}