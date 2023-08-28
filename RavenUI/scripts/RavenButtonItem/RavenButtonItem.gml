//A Raven Item is a page or a function trigger
///@Description An item, use false or noone for _on_click if not interactable.
/// @param {String}     text    The unique instance ID value of the instance to check.
/// @param {String}  on_click  The object index to be checked against.
/// @param {Real}	_margin Not yet implemented!
function RavenButtonItem(_text, _on_click, _margin = 0, _padding = 2, _border_radius = 0, _draw_outline = false) constructor {
	container_id = undefined;
	is_enabled = true;
	text = _text;
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
	draw_outline = _draw_outline;
	padding = _padding;
	border_radius = _border_radius;
	
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
			return string_width(text)+padding+padding;	
		}
	}	
	
	function SetCoords(_x0, _y0, _x1, _y1) {
		x0 = _x0;
		y0 = _y0;
		x1 = _x1;
		y1 = _y1;
	}
	
    function GetHeight() {
        return string_height(text);
    }
	
	
	function Update() {
		var _px0 = x0 - padding;
		var _px1 = x1 + padding;
		var _py0 = y0 - padding;
		var _py1 = y1 + padding;
		gui_clicking = false;
		if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _px0, _py0, _px0+GetWidth(), _py0+GetHeight())) {
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
		var _px0 = x0 - padding;
		var _px1 = x1 + padding;
		var _py0 = y0 - padding;
		var _py1 = y1 + padding;
		
		draw_set_color(global.gui_menu);
		draw_roundrect_ext(_px0,_py0,_px0+GetWidth(),_py1, border_radius, border_radius, false);
		draw_set_color(global.gui_text_default);

		if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),_px0,_py0,_px0+GetWidth(),_py1)) {
			draw_set_color(global.gui_menu_hover);
			draw_roundrect_ext(_px0,_py0,_px0+GetWidth(),_py1, border_radius, border_radius, false);
			
			if (mouse_check_button_pressed(mb_left)) {
				draw_set_color(global.gui_menu_click);
				draw_roundrect_ext(_px0,_py0,_px0+GetWidth(),_py1, border_radius, border_radius, false);
			}
		}
		if (draw_outline) {
			draw_set_color(global.gui_text_default);
			draw_roundrect_ext(_px0,_py0,_px0+GetWidth(),_py1, border_radius, border_radius, true);
		}
		draw_set_color(global.gui_text_default);
		draw_text(x0, y0, text);
	}
	
	

}