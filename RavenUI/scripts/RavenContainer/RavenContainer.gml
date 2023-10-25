//TODO: there might be a small memory leak in containers, items or menus, please make sure you are deleting your ds_lists.

function RavenContainer(_x0, _y0, _x1, _y1, _scaling, _outline, _render_mode = GUI_RENDER_MODE.VLIST, _outline_size = 1, _color_override = undefined) constructor{
	container_id = CreateRavenGUID();
	active = false;
	menu = noone;
	x0 = _x0 * global.interface_scale;
	y0 = _y0 * global.interface_scale;
	x1 = _x1 * global.interface_scale;
	y1 = _y1 * global.interface_scale;
	x0_previous = x0;
	y0_previous = y0;
	x1_previous = x1;
	y1_previous = y1;
	outline = _outline;
	outline_size = _outline_size;
	color_override = _color_override;
	//if (outline_size == undefined) outline_size = 1;
	scaling = _scaling;
	items = ds_list_create();
	show_debug_message(ds_list_size(items));
	menu_items = ds_list_create();
	container_margin_top = 50;
	
	content = ds_list_create();
	
	//colour = _colour;
	resizing = false;
	resizing_left = false;
	resizing_right = false;
	gui_depth_index = 1;
	minimum_container_size = 400;
	lock = false;
	moving = false;
	render_mode = _render_mode;
	if (_color_override != undefined) {
		color_override = _color_override;
	}
	
	x0_scaling = x0;
	y0_scaling = y0;
	x1_scaling = x1;
	y1_scaling = y1;
	
	
	// In RavenContainer constructor
	scroll_offset = 0;
	scrollbar_height = 10;
	scrollbar_x0 = x0;
	scrollbar_x1 = x1;
	scrollbar_dragging = false;

	
	//RegisterRavenContainer(self);
	
	//Set the container reference in the items
	function UpdateItemContainers() {
		if (menu != noone) {
			menu.SetContainerId(container_id);
			menu.UpdateItemContainers();
		}
		for (var _i = 0; _i < ds_list_size(items); _i++) {
			var _item = ds_list_find_value(items, _i);
			_item.SetContainerId(container_id);
			ds_list_replace(items, _i, _item);
		}
	}
	
	function SetGUIDepthIndex(_gui_depth_index) {
		gui_depth_index = _gui_depth_index;
	}
	
	function AddItem(_raven_item) {
		show_debug_message("Adding item");
		ds_list_add(items, _raven_item);
		show_debug_message(ds_list_size(items));
	}
	
	function AddContent(_raven_item) {
		ds_list_add(content, _raven_item);	
	}
	
	//Delete an item from Raven Menu
	function DeleteItem(_raven_item) {
		ds_list_delete(items, _raven_item)	
	}
	
	function SetActive(_active) {
		active = _active;
	}
	
	function SetLock(_lock) {
		lock = _lock;	
	}
	
	//Retrieve all items from Raven Menu
	function GetMenuItems() {
		if (menu != noone) {
			return menu.GetItems()	
		}
	}
	
	function UpdatePosition(_x0, _y0, _x1, _y1) {
		if (!lock) {
			x0 = _x0;
			x1 = _y0;
			y0 = _x1;
			y1 = _y1;
			moving = true;
		}
	}
	
	function Move(_x_amount, _y_amount) {
		if (!lock) {
			window_set_cursor(cr_drag);
			x0 += _x_amount;
			y0 += _y_amount;
			x1 += _x_amount;
			y1 += _y_amount;
			moving = true;
		}
	}
	
	function Destroy() {
		//ds_list_destroy(menu_items);
		//ds_list_destroy(items);
		ds_list_clear(items);
		ds_list_clear(menu_items);
	}
		
		
	
	function GetActive() {
		return active;	
	}
	
	
	function UpdateContainerLock() {
		//Retrieve the container and update locked property
		if (menu != undefined && menu != noone) {
			lock = menu.container_lock;
		}
	}
	
	
	/// container_resize()
	/// @desc Resizes the container based on mouse position and outline size.

	/// @param {number} outline_size - The size of the container's outline.

// container_resize()
// @desc Resizes the container based on mouse position while dragging the edges.

	function containerResize() {
	//if the container is being moved resizing is not allowed.
	if (!menu) {
		return;	
	}
	if (!moving && !menu.is_dragging && !lock) {
		//if (menu != noone && !menu.is_dragging == noone && !menu.is_dragging) {
		var _select_size = outline_size * 3;
		if (_select_size < 32) _select_size = 32;
	    // Check if the mouse is being pressed
	    //if (mouse_check_button(mb_left)) {
		var _action_pressed = mouse_check_button(mb_left);
	
		//If released button we are no longer resizing.
		if (mouse_check_button_released(mb_left)) {
			resizing = false;
			resizing_left = false;
			resizing_right = false;
		}
		
			var _select = false;
			//show_debug_message("select size: " + string(_select_size));
	        // Check if the mouse is within the bottom edge with the specified margin
	        if (device_mouse_y_to_gui(0) > (y1 - _select_size) && device_mouse_y_to_gui(0) < (y1 + _select_size) && device_mouse_x_to_gui(0) > (x0 - _select_size) && device_mouse_x_to_gui(0) < (x1 + _select_size)) || resizing {
				//Hovering the bottom edge
				window_set_cursor(cr_size_ns);
				if (_action_pressed && !lock) {
					// Resizing the bottom edge
		            y1 += global.mouse_y_diff;
		            global.raven_occupied = self;
					_select = true;
					resizing = true;
					window_set_cursor(cr_size_ns);
				}
	        }
	        // Check if the mouse is within the left edge with the specified margin
			
	        if (device_mouse_x_to_gui(0) > (x0 - _select_size) && device_mouse_x_to_gui(0) < (x0 + _select_size) && device_mouse_y_to_gui(0) > (y0 - _select_size) && device_mouse_y_to_gui(0) < (y1 + _select_size)) || resizing_left {
				//Hovering the left edge
				window_set_cursor(cr_size_we);
				if (_action_pressed && !lock) {
	            // Resizing the left edge
				//check that the mouse is at least the minimum container size removed from the left edge of the container (x0)
				if (device_mouse_x_to_gui(0) < x1 - minimum_container_size) {
					x0 += global.mouse_x_diff;
				}
	            global.raven_occupied = self;
				_select = true;
				resizing_left = true;
				window_set_cursor(cr_size_we);
				}
	        }
	        // Check if the mouse is within the right edge with the specified margin
	        if (device_mouse_x_to_gui(0) > (x1 - _select_size) && (device_mouse_x_to_gui(0) < x1 + _select_size) && device_mouse_y_to_gui(0) > (y0 - _select_size) && device_mouse_y_to_gui(0) < (y1 + _select_size)) || resizing_right {
				//Hovering the right edge
				window_set_cursor(cr_size_we);
				if (_action_pressed && !lock) {
	            // Resizing the right edge
				//check that the mouse is at least the minimum container size removed from the right edge of the container (x1)
				if (device_mouse_x_to_gui(0) > x0 + minimum_container_size) {
					x1 += global.mouse_x_diff;
				}
	            global.raven_occupied = self;
				_select = true
				resizing_right = true;
				window_set_cursor(cr_size_we);
	        }
		
	    }
	   // else {
	        global.raven_occupy = noone;
			//window_set_cursor(cr_default);
	   // }
		//}
		}
	}
	//Binds a menu to this container
	function SetMenu(_raven_menu) {
		show_debug_message(" provided menu: " );
		show_debug_message(_raven_menu);
		show_debug_message("RAVENDEBUG: Setting menu container_id to: "  + string(container_id));
		_raven_menu.SetContainerId(container_id);
		menu = _raven_menu;
	}
	
	function SetMenuBoundByContainer(_is_bound_by_container) {
		if (menu != noone) {
			menu.SetIsBoundByContainer(_is_bound_by_container);
		}
	}
	
	
	function SetOutline(_outline) {
		outline = _outline;	
	}
	
	function GetIsMenuBoundByContainer() {
		if (menu != noone) {
			if (menu.GetIsBoundByContainer()) {
				return true;
			}
		}
		return false;
	}
	
	function Render() {
		
		//render container base (background) and outline
		draw_set_color(global.gui_background);
		if (color_override != undefined) {
			draw_set_color(color_override);
		}
		draw_rectangle(x0_scaling, y0_scaling, x1_scaling, y1_scaling, false);	
		if (outline) {
			draw_set_color(global.gui_outline);
			for (var _i = 0; _i < outline_size; _i++) {
			draw_rectangle(x0_scaling-_i, y0_scaling-_i, x1_scaling+_i, y1_scaling+_i, true);
			}
		}
		//render menu
		if (menu != noone) menu.Render();
		
		
		//render items
		var _sep = 16;
		switch (render_mode) {
			
			case GUI_RENDER_MODE.HLIST:
			show_error("NOT_IMPLEMENTED_EXCEPTION - Rendering method HLIST is not yet implemented into Raven!", false);
			break;
			
			case GUI_RENDER_MODE.VLIST:
		    var _y_current = y0_scaling + container_margin_top; // Starting Y position
			//show_debug_message("render list size: " + string(ds_list_size(items)));
		    for (var _i = 0; _i < ds_list_size(items); _i++) {
		        var _item = ds_list_find_value(items, _i);
				//show_debug_message(item.title);
		        // Update item's position for VLIST rendering
		        _item.SetCoords(x0_scaling + _item.margin, _y_current, x1_scaling + _item.margin, _y_current + _item.GetHeight());

		        // Render the item
		        _item.Render();
				//show_debug_message("Text should have been rendered at: x0: " + x0_scaling + " y0: " + _y_current + " x1: " + x1_scaling + " y1: " + _y_current);
		        // Move to the next Y position with separation
		        _y_current += _item.GetHeight() + _sep;
				}
			break;
			
			case GUI_RENDER_MODE.GRID:
				show_error("NOT_IMPLEMENTED_EXCEPTION - Rendering method GRID is not yet implemented into Raven!", false);
			break;
			
			case GUI_RENDER_MODE.COLUMNS2:
				show_error("NOT_IMPLEMENTED_EXCEPTION - Rendering method Columns2 is not yet implemented into Raven!", false);
			break;
			
			case GUI_RENDER_MODE.MANUAL:
				for (var _i = 0; _i < ds_list_size(items); _i++) {
					var _item = ds_list_find_value(items, _i);	
					// Render the item
					_item.Render();
				}
			break;
			
		}
	}
	
	function Update() {
		//Check whether the container is locked via the menu and update our lock property.
		UpdateContainerLock();
		
		//Check if we have moved the container last step, if not, moving will be false and resizing is allowed.
		if (x0 == x0_previous && x1 == x1_previous && y0 == y0_previous && y1 == y1_previous) {
			moving = false;			
		}
		containerResize();
		//render items
		menu_items = GetMenuItems();
		//render menu
		if (menu != noone) {
			
			//menu properties - check lock
			//check if hovering over lock icon
			if (device_mouse_x_to_gui(0) >= menu.lock_icon_x0 && device_mouse_x_to_gui(0) <= menu.lock_icon_x1 && device_mouse_y_to_gui(0) >= menu.lock_icon_y0 && device_mouse_y_to_gui(0) <= menu.lock_icon_y1) {
				//if clicking
				if (mouse_check_button_pressed(mb_left)) {
					//change lock 
					if (menu.container_lock) {
						menu.container_lock = false;
					} else {
						menu.container_lock = true;
					}
				}
			}
			
			if (menu.is_dragging) {
				//container moving
				Move(global.mouse_x_diff,global.mouse_y_diff);	
			
			}
			menu.Update();
		}	
		
		if (scaling) {
			x0_scaling = x0 * global.current_scale_x;
			x1_scaling = x1 * global.current_scale_x;
			y0_scaling = y0 * global.current_scale_y;
			y1_scaling = y1 * global.current_scale_y;
		} else {
			x0_scaling = x0;
			y0_scaling = y0;
			x1_scaling = x1;
			y1_scaling = y1;
		}
		
		//update menu container bounds
		
		if (GetIsMenuBoundByContainer()) {
			menu.SetContainerCoords(x0_scaling, y0_scaling, x1_scaling, y1_scaling);
		}
		
		//updatemenu items
		if (menu_items != undefined) {
			for (var _i = 0; _i < ds_list_size(menu_items); _i++) {
				var _item = ds_list_find_value(menu_items, _i).Update();
			}
		}
		
		if (items != undefined) {
			for (var _i = 0; _i < ds_list_size(items); _i++) {
				var _item = ds_list_find_value(items, _i).Update();
			}	
		}
		x0_previous = x0;
		y0_previous = y0;
		x1_previous = x1;
		y1_previous = y1;
	}

}