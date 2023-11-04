/// @function	RavenStatusItem(_text, _on_click, _margin, _padding, _border_radius, _draw_outline)
/// @description Creates a clickable area with text in it.
/// @param {String}     text    The name of the status field.
/// @param {Id.DsMap}  _status_map  A ds map of key - value pairs where the key is the status, and the value is the result's expected result value for the status to be active.
/// @param {Real} _initial_status The initial status. Enum value from GUI_STATUS defined in obj_raven_init.
/// @param {Real}	_margin The margin around the button.
/// @param {Real}	_padding The padding of the button.
/// @param {Real} _border_radius The border radius of the button.
/// @param {Bool} _draw_outline whether or not to draw an outline.
function RavenStatusItem(_text, _status_map, _initial_status = undefined,  _margin = 0, _padding = 2, _border_radius = 0, _draw_outline = false) constructor {
	container_id = undefined;
	is_enabled = true;
	text = _text;
	status = _initial_status;
	status_map = _ds_status_map;
	result = undefined;
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
	
	/// @function	GetResult()
	/// @description Returns the value of result.
	function GetResult() {
		return result;
	}
	
	/// @function SetResult(_result)
	/// @description Sets the value of result.
	function SetResult(_result) {
		result = _result;
	}
	
	/// @function GetStatusMap()
	/// @descripotion Returns the status_map ds_map. 
	function GetStatusMap() {
		return status_map;
	}
	
	/// @function SetStatusMap(_status_map)
	/// @descsription Sets the value of status_map, given that the provided _status_map is of type ds_map, otherwise throws an error.
	function SetStatusMap(_status_map) {
		//create a mock ds map
		mock_map = ds_list_create();
		if (typeof(_status_map) == typeof(mock_map)) {
			status_map = _status_map;
		} else {
			show_error("The provided argument for argument: _status_map in function: SetStatusMap was not of type ds_map in struct: RavenStatusItem", true);
		}
		ds_list_destroy(mock_map);
		
	}
	
	/// @function GetContainerId()
	/// @description Returns the id of a bound container (container_id).
	function GetContainerId() {
		return container_id;	
	}
	
	/// @function SetContainerId(_container_id)
	/// @description Sets the container_id equal to the provided _container_id.
	function SetContainerId(_container_id) {
		container_id = _container_id;
	}
	
	/// @function SetEnabled(_set) 
	/// @description Whether the element is enabled.
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
		show_error("Function OnClick is not implemented in RavenStatusItem", true);
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
	
	
	/// @function SetStatusWithStatusMap()
	/// @description Evaluates if the result is equal to any value in the provided ds map, if it is, the key is saved as the status. Returns true if successful
	function SetStatusWithStatusMap() {
		var _key = ds_map_find_first(status_map);
		for (var _i = 0; _i < ds_map_size(status_map); i++) {
			var _value = ds_map_find_value(status_map, _key);
			if (_value == result) {
				status = _key;
				return true;	
				
			} else {
				_key = ds_map_find_next(status_map, _key);			
			}
			
		}
		return false;
	}
	
	/// @function CompareResultWithStatusMap()
	/// @description Evaluates if the result is equal to any value in the provided ds map, if it is, the key and value are returned.
	function CompareResultWithStatusMap() {
		var _key = ds_map_find_first(status_map);
		for (var _i = 0; _i < ds_map_size(status_map); i++) {
			var _value = ds_map_find_value(status_map, _key);
			if (_value == result) {
				return [_key, _value];	
				
			} else {
				_key = ds_map_find_next(status_map, _key);			
			}
			
		}
		return undefined;
	}
	
	
	function Update() {
		//todo compare result value against map here
		
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