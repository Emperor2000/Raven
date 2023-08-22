//A Raven Item is a page or a function trigger
///@Description An item, use false or noone if not interactable.
function RavenItem(_text, _on_click, _margin) constructor {
	container_id = undefined;
	is_enabled = true;
	text = _text;
	if (_on_click == noone || !_on_click)
	    on_click = _on_click;
	else
	    on_click = method(self, _on_click);
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
	
	
	/// @description	returns the text of the item.
	function GetText() {
		return text;	
	}
	
	function SetText(_text) {
		text = _text;
	}
	
	/// @description	returns the width of the text in pixels.
	function GetWidth() {
		if (text != noone) {
			return string_width(text);	
		}
	}	
	
	function SetCoords(_x0, _y0, _x1, _y1) {
		x0 = _x0;
		y0 = _y0;
		x1 = _x1;
		y1 = _y1;
	}
	
	function GetHeight() {
		height = y1 - y0;
		return height;	
	}
	
	
	function Update() {
		gui_clicking = false;
		if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x0, y0, x1, y1)) {
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
	
	
	

}