function RavenMenu(_x, _y, _item_width, _height, _margin, _font = fnt_bookshelf) constructor {
	container_id = undefined;
    x = _x * global.interface_scale;
    y = _y * global.interface_scale;
    item_width = _item_width * global.interface_scale;
    height = _height * global.interface_scale;
    margin = _margin * global.interface_scale;
    outline = false;
    item_outline = false;
    x0 = 0;
    y0 = y;
    x1 = display_get_gui_width();
	///x1 = 0;
    y1 = y + height;
	container_width = noone;
	container_height = noone;
	is_bound_by_container = false;
	is_dragging = false;
	select_margin = 8;
	font = _font;
	
	lock_icon_x0 = 0;
	lock_icon_x1 = 0;
	lock_icon_y0 = 0;
	lock_icon_y1 = 0;
	
	//this container specs are used in case the menu is part of a container.
	//The menu and items should transform along with the container.
	container_x0 = x0;
	container_y0 = y0;
	container_x1 = x1;
	container_y1 = y1;
	container_lock = true;

    items = ds_list_create();
	
	function GetContainerId() {
		return container_id;
	}
	
	function SetContainerId(_container_id) {
		show_debug_message("SetContainerId: ");
		show_debug_message(_container_id);
		container_id = _container_id;
		return container_id;
	}

    function AddItem(_raven_item) {
       ds_list_add(items, _raven_item);
	 // ds_list_find_value(items, _raven_item).SetContainerReference(container_reference)
	
    }
	
	//Sewt the container reference in the menu items
	function UpdateItemContainers() {
		show_debug_message("Updating item containers...");
		//show_debug_message(container_id);
		for (var _i = 0; _i < ds_list_size(items); _i++) {
			var _item = ds_list_find_value(items, _i);
			_item.SetContainerId(container_id);
		}
	}

    function DeleteItem(_raven_item) {
        ds_list_delete(items, _raven_item);
    }

    function SetOutline(_outline) {
        outline = _outline;
    }
	function GetContainer() {
		return container;	
	}
	
	//Container menu size
	function SetContainerSize(_container_width, _container_height) {
		container_width = _container_width;
		container_height = _container_height;
	}
	
	function SetContainerCoords(_container_x0, _container_y0, _container_x1, _container_y1) {
		container_x0 = _container_x0;
		container_y0 = _container_y0;
		container_x1 = _container_x1;
		container_y1 = _container_y1;
	}
	
	//Container bounds
	function SetIsBoundByContainer(_is_bound_by_container) {
		is_bound_by_container = _is_bound_by_container; 
	}
	
	function GetIsBoundByContainer() {
		return is_bound_by_container;	
	}
	

    function GetItems() {
        return items;
    }

    function SetItemOutline(_item_outline) {
        item_outline = _item_outline;
    }

    function Update() {
        x1 = display_get_gui_width();
		if (is_dragging) {
			if (!mouse_check_button(mb_left)) {
				is_dragging = false;
			}
		}
		
        if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), container_x0, container_y0, container_x1, y1)) {
			//show_debug_message("mouse x: " + string(device_mouse_x_to_gui(0)));
			//show_debug_message("mouse y: " + string(device_mouse_y_to_gui(0)));
			//show_debug_message("x0: " + string(x0));
			//show_debug_message("x1: " + string(x1));
			//show_debug_message("y0: " + string(y0));
			//show_debug_message("x1: " + string(x1));
			//show_debug_message("can drag");
            // Hover in menu
			if (mouse_check_button(mb_left)) {
				is_dragging = true;
				
			}
        }
    }
	
	
	function Destroy() {
		ds_list_destroy(items);	
	}
	

	function Render() {
	    var _window_width = display_get_gui_width();
	
		//override if bound to a container
		//applied x and y used for container alignment.
		var _x0_applied = x0;
		var _y0_applied = y0;
		var _x1_applied = x1;
		var _y1_applied = y1;
	
		if (is_bound_by_container) {
			_window_width = container_x1 - container_x0;
			_x0_applied = container_x0;
			_y0_applied = container_y0;
			_x1_applied = container_x1;
			_y1_applied = container_y1;
		
		
			x = _x0_applied;
			y = _y0_applied;
		}
		
		lock_icon_x0 = _x1_applied-margin - sprite_get_width(spr_lock)/4;
		lock_icon_x1 = _x1_applied-margin + sprite_get_width(spr_lock)/4;
		lock_icon_y0 = (y+height/2) - sprite_get_height(spr_lock/2);
		lock_icon_y1 = (y+height/2) + sprite_get_height(spr_lock/2);
	
	    var _draw_pos = x + margin;
	    var _row_count = 1;
	    var _items_in_row = 0;
	    var _row_start_index = 0;
	
	    draw_set_color(global.gui_menu);
		//draw_rectangle(200,200,1200,1200,false);
	    draw_rectangle(_x0_applied, _y0_applied, _x1_applied, _y0_applied + height, false);
	    draw_rectangle(_x0_applied, _y0_applied, _x1_applied, _y0_applied + height, true);

	    for (var _i = 0; _i < ds_list_size(items); _i++) {
	        var _raven_item_reference = ds_list_find_value(items, _i);
	        draw_set_valign(fa_center);

	        if (_draw_pos + _raven_item_reference.GetWidth() > _window_width && _items_in_row > 0) {
	            _row_count++;
	            _draw_pos = x + margin;
	            _items_in_row = 0;
	            _row_start_index = i;
			
	        }
		
			//if the item is bound by a container we should override the draw position
			if (is_bound_by_container) {
				//draw_pos = _x0_applied + margin;
			}
			
			draw_set_color(global.gui_menu_hover);
			if (_raven_item_reference.hover) {
				 draw_rectangle(_raven_item_reference.x0, _raven_item_reference.y0, _raven_item_reference.x1, _raven_item_reference.y1, false);	
			}


	        draw_set_color(global.gui_menu_click);
	        if (_raven_item_reference.gui_clicking) {
	            draw_rectangle(_raven_item_reference.x0, _raven_item_reference.y0, _raven_item_reference.x1, _raven_item_reference.y1, false);
	        }

	        draw_set_color(global.gui_text_default);
	        var _draw_pos_start = _draw_pos;
	        var _draw_pos_y = y + ((_row_count - 1) * height) + (height / 2);
		
			//If the item is bound by a container should override the draw_y position
			//if (is_bound_by_container) {
			//	draw_pos_y = _y0_applied + height/2;	
			//}
		
	        //draw_text(draw_pos, draw_pos_y, _raven_item_reference.Gettext());
			draw_set_font(font);
			draw_text_ext_transformed(_draw_pos,_draw_pos_y,_raven_item_reference.GetText(),8, 300,global.interface_scale, global.interface_scale, 0)
	        var _draw_pos_move_amount = (_raven_item_reference.GetWidth() + margin) * global.interface_scale;
	        _draw_pos += _draw_pos_move_amount;
	        _items_in_row++;

	        var _button_padding = margin / 2;
	        var _button_start_x = _draw_pos_start - _button_padding;
	        var _button_start_y = _draw_pos_y - (height / 2); // Adjust button position based on text position
	        var _button_end_x = _draw_pos - _button_padding;
	        var _button_end_y = _button_start_y + height;
	

	        _raven_item_reference.SetCoords(_button_start_x, _button_start_y, _button_end_x, _button_end_y);

	        if (item_outline) {
				draw_set_color(global.gui_outline);
	            draw_rectangle(_button_start_x, _button_start_y, _button_end_x, _button_end_y, item_outline);
	        }
	        draw_set_valign(fa_top);
	    }

	    // Adjust the overall height of the menu to match the last row
	    y1 = y + _row_count * height;
		
		//if container_lock is enabled
		if (container_lock) {
			//render lock icon
			draw_sprite_ext(spr_lock,0,_x1_applied-margin,1+y+height/2, global.interface_scale, global.interface_scale, 0,c_white,1);
		}
		
		if (!container_lock) {
			draw_sprite_ext(spr_lock,1,_x1_applied-margin,1+y+height/2,global.interface_scale,global.interface_scale,0,c_white,1);
		}
		draw_set_color(c_red);
		//draw_rectangle(lock_icon_x0,lock_icon_y0,lock_icon_x1,lock_icon_y1, false);
	}
}