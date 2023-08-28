//A Raven Item is a page or a function trigger
///@Description An item, use false or noone for _on_click if not interactable.
/// @param {String}  on_click  The object index to be checked against.
/// @param {Asset.GMSprite}  _sprite  The sprite 
/// @param {Real}	_margin The margin applied to the top, buttom, left and right of the item.
/// @param {Real}	_image_x_scale The x scaling of the image, where 1 is the original scale.
/// @param {Real}	_image_y_scale The y scaling of the image, where 1 is the original scale.
function RavenImageButtonItem(_on_click, _sprite, _margin = 0, _sprite_xscale = 1, _sprite_yscale = 1) constructor {
	container_id = undefined;
	is_enabled = true;
	if (_on_click == noone || !_on_click)
	    on_click = _on_click;
	else
	    on_click = method(self, _on_click); //Note that _on_click expects a function!
	lock_trigger = false;
	clicking = false;
	gui_clicking = false;
	subitems = ds_list_create();
	outline = false;
	margin = _margin;
	x0 = 0;
	y0 = 0;
	x1 = 0;
	y1 = 0;
	hover = false;
	height = 0;
	sprite = _sprite
	sprite_xscale = _sprite_xscale;
	sprite_yscale = _sprite_yscale;
	
	function GetContainerId() {
		return container_id;	
	}
	
	function SetContainerId(_container_id) {
		container_id = _container_id;
	}
	
	function SetEnabled(_set) {
		is_enabled = _set;	
	}
	
	/// @onclick		Set the onclick event trigger for the item.
	function SetOnClick(_function) {
		if (is_enabled) {
			on_click = _function;
			SetEnabled(true);
		}
	}
	
	///@description		Execute the onclick trigger/event
	function OnClick() {
		if (on_click == noone || !on_click) {
			return noone;
		} else {
			//execute onclick function
			on_click();
		}
	}
	
	/// @description	returns the width of the text in pixels.
	function GetWidth() {
		return sprite_get_width(sprite)*sprite_xscale;
	}
	
	function SetCoords(_x0, _y0, _x1, _y1) {
		x0 = _x0;
		y0 = _y0;
		x1 = _x1;
		y1 = _y1;
	}
	
    function GetHeight() {
        return sprite_get_height(sprite)*sprite_yscale;
    }
	
	
	function Update() {
		gui_clicking = false;
		if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x0, y0, x0 + sprite_get_width(sprite)*sprite_xscale, y0 + sprite_get_height(sprite)*sprite_yscale)) {
			hover = true;
			
			//use mouse_check_button for gui responsiveness
			if (mouse_check_button(mb_left)) {
				gui_clicking = true;
			} else {
				gui_clicking = false;
			}
			
			//mouse check button pressed for click functionality, only triggered once
			if (mouse_check_button_pressed(mb_left)) {
				clicking = true;
				window_set_cursor(cr_handpoint);
				OnClick();	
			} else {
				clicking = false;	
			}
		} else {
			hover = false;
		}
	}
	
	function Render() {
		draw_sprite_ext(sprite,0,x0,y0,sprite_xscale,sprite_yscale,0,c_white,1);
		
		if (hover) {
			draw_sprite_ext(sprite,0,x0,y0,sprite_xscale,sprite_yscale,0,global.gui_menu_hover,0.3);
		}
		
		if (gui_clicking) {
			draw_sprite_ext(sprite,0,x0,y0,sprite_xscale,sprite_yscale,0,global.gui_menu_click,0.6);	
		}
	}
	
	

}