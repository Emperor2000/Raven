/// RavenDropdownItem Constructor
function RavenDropdownItem(_text, _options = undefined, _margin = 16, _font = fnt_dsansmono16, _color = global.gui_text_default, _text_color = global.gui_text_default, _dropdown_color = global.gui_menu, _hover_color = global.gui_menu_hover, _background_color = global.gui_background) : RavenItem(_text, undefined, _margin) constructor {
    container_id = undefined;
    is_enabled = true;
    text = _text;
	options = ds_list_create(); // Initialize the options list
	if (_options != undefined) {
		options = _options;		
	}
	ds_list_add(options, "value 1");
	ds_list_add(options, "value 2");
	ds_list_add(options, "value 3");
    lock_trigger = false;
    clicking = false;
    gui_clicking = false;
    outline = false;
    margin = _margin;
    x0 = 0;
    y0 = 0;
    x1 = 0;
    y1 = 0;
    hover = false;
    font = _font; // Font for the text item
    color = _color; // Color for the text
    input_text = "";
    cursor_position = 0;
    text_color = _text_color;
    open = false;
    selected_item_index = -1;
    bg_color = _background_color;
    dropdown_color = _dropdown_color;
    hover_color = _hover_color;
	value = "";
	specific_margin = 0; //specific margin is an additional margin that can be applied to rendering an item. It is not delegated to a parent container as the regular margin is but applied inside this struct instance.
    
    function Toggle() {
        open = !open;
    }
	
	function SetValue(_value) {
		value = _value;
	}
	
	function SetValueByOptionIndex(_i) {
		if (selected_item_index < 0 || selected_item_index >= ds_list_size(options) || selected_item_index == noone || selected_item_index == undefined) {
			show_error("Index Out of Range Exception: RavenDropdownItem SetValueByOptionIndex function expects a valid index.", true);
		} else {
			value = ds_list_find_value(options, _i);	
		}
	}
	
	function GetValue() {
		return value;	
	}
	
	function GetSelectedItemIndex() {
		return selected_item_index;	
	}

	function Update() {
	    gui_clicking = false;

	    var _dropdown_x0 = x0;
	    var _dropdown_y0 = y0 + GetDropdownItemHeight(); // Adjusted position
	    var _dropdown_x1 = x0 + GetDropdownWidth();
	    var _dropdown_y1 = _dropdown_y0 + GetDropdownHeight();

	    if (open) {
	        _dropdown_y1 = _dropdown_y0 + GetDropdownItemHeight() + GetDropdownItemHeight() * ds_list_size(options) + margin; // Adjusted height
	    }

	    if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x0, y0, _dropdown_x1, _dropdown_y1)) {
	        hover = true;

	        if (mouse_check_button_pressed(mb_left)) {
	            clicking = true;
	        } else {
	            clicking = false;
	        }
	    } else {
	        hover = false;
	    }

	    if (clicking && point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x0, y0, _dropdown_x1, y0 + GetDropdownItemHeight())) {
	        Toggle();
	        clicking = false;
	    }

	    if (open) {
	        for (var _i = 0; _i < ds_list_size(options); _i++) {
				//This dropdown still has it's flaws, for some reason multiplying by 1.5 makes the Update region...
				//more accurate and reflect the Rendered region better, This  is on my todo list.
	            var _item_y = _dropdown_y0 + (_i + 1) * GetSpecificDropdownItemHeight(_i) * 1.5; // Adjusted position
	            var _item_height = GetDropdownItemHeight();

	            if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x0, _item_y, _dropdown_x1, _item_y + _item_height)) {
	                hover = true;

	                if (mouse_check_button_pressed(mb_left)) {
	                    selected_item_index = _i;
						value = ds_list_find_value(options, selected_item_index);
	                    Toggle();
	                }
	            }
	        }
	    }
	}
	function Render() {
	    // Draw dropdown text at the original y position
		draw_set_color(dropdown_color);
		
		//Draw accordion area
		//If the selected item index is less than 0 or more or equal to the ds list size it is not a valid item. In that case we can draw a compact rectangle as no value is selected.
		if (selected_item_index < 0 || selected_item_index >= ds_list_size(options) || selected_item_index == noone || selected_item_index == undefined) {
			draw_rectangle(x0, y0, x0 + GetDropdownWidth(), y0 + GetDropdownItemHeight(), false);
		} else {
			//If we do have a value we need to expand the x to make sure the text fits in the accordion.
			draw_rectangle(x0, y0, x0 + GetDropdownWidth() + string_width(ds_list_find_value(options, selected_item_index)), y0 + GetDropdownItemHeight(), false);
		}
	    draw_set_font(font);
	    draw_set_color(text_color);
	    draw_text(x0, y0, text);
		


	    if (open) {
	        // Draw dropdown items
	        for (var _i = 0; _i < ds_list_size(options); _i++) {
	            var _item_y = y0 + (_i + 1) * GetDropdownItemHeight(); // Adjusted position
	            var _item_height = GetDropdownItemHeight();

	            // Check if mouse is over the item
	            var _is_mouse_over = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x0, _item_y, x0 + GetDropdownWidth(), _item_y + _item_height);

	            // Draw highlighted item on hover
	            if (_is_mouse_over) {
	                draw_set_color(hover_color);
	                draw_rectangle(x0, _item_y, x0 + GetDropdownWidth(), _item_y + _item_height, true);
	            }
            
	            // Draw text with appropriate colors
	            draw_set_font(font);
	            draw_set_color(dropdown_color); // Set dropdown color
	            draw_rectangle(x0, _item_y, x0 + GetDropdownWidth(), _item_y + _item_height, false); // Draw outline
	            draw_set_color(text_color);
	            draw_text(x0 + 4, _item_y + 2, ds_list_find_value(options, _i)); // Adjusted position
            
	            // Apply outline when hovered
	            if (_is_mouse_over) {
	                draw_set_color(hover_color);
	                draw_text(x0 + 4, _item_y + 2, ds_list_find_value(options, _i));
	            }
	        }
	    } else {
	        // Draw selected item's text
	        if (selected_item_index >= 0 && selected_item_index < ds_list_size(options)) {
	            draw_set_color(text_color);
	            draw_text(x0 + string_width(text) + margin, y0, ds_list_find_value(options, selected_item_index));
				
	        }
	    }
	}

    function GetDropdownWidth() {
        var _max_width = string_width(text);
        for (var _i = 0; _i < ds_list_size(options); _i++) {
            var _option_width = string_width(ds_list_find_value(options, _i));
            if (_option_width > _max_width) {
                _max_width = _option_width;
            }
        }
        return _max_width + margin;
    }

    function GetDropdownHeight() {
        return GetDropdownItemHeight() * ds_list_size(options);
    }

    function GetDropdownItemHeight() {
        return string_height(ds_list_find_value(options, 0)) * 1.5;
    }
	
	function GetSpecificDropdownItemHeight(_i) {
		return string_height(ds_list_find_value(options, _i)) * 1.5;
	}

    function GetValue() {
        if (selected_item_index >= 0 && selected_item_index < ds_list_size(options)) {
            return ds_list_find_value(options, selected_item_index);
        } else {
            return "";
        }
    }
}