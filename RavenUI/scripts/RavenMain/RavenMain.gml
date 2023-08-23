function RavenMain() constructor {
	menu = noone;
	active_page = noone;
	pages = ds_list_create();
	items = noone;
	global.raven_containers = ds_list_create();
	
	//Binds a menu to RavenMain
	function SetMenu(_raven_menu) {
		menu = _raven_menu;
	}
	
	//Retrieve all items from Raven Menu
	function GetItems() {
		if (menu != noone) {
			items = menu.GetItems()	
		}
	}
	
	function PushReferences() {
		show_debug_message("RAVENDEBUG: Container count: " + string(ds_list_size(global.raven_containers)));
		for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
		var _container = ds_list_find_value(global.raven_containers, _i);
		show_debug_message("retrieved container instance");
		show_debug_message("container's data: " + _container.container_id);
		_container.UpdateItemContainers();
		show_debug_message("Pushed references for container");
		}
	}
	
	function AddContainer(_raven_container) {
		//ds_list_add(containers, _raven_container);
		RegisterRavenContainer(_raven_container);
	}
	
	function Update() {
		//update menu
		GetItems();
		if (menu != noone) menu.Update();
		
		//update items
		for (var _i = 0; _i < ds_list_size(items); _i++) {
			var _item = ds_list_find_value(items, _i).Update();
		}
		
		//update container
		for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
			ds_list_find_value(global.raven_containers, _i).Update();
		}
	}
	
	
	function Render() {
		//ds_list_find_value(global.raven_containers, 1).Render();
		//show_debug_message("Amount of items"+string(ds_list_size(ds_list_find_value(global.raven_containers, 0).items)));
		//show_debug_message("And this is your shit code not working: ");
		//ds_list_find_value(global.raven_containers, 0).Render();
		//return;
		
		//we will first render our containers.
		//render container
		for (var _i = 0; _i < ds_list_size(global.raven_containers); _i++) {
			ds_list_find_value(global.raven_containers, _i).Render();
		}
		
		//render items
		items = GetItems();
		
		//render menu
		if (menu != noone) menu.Render();
	}
}