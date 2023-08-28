/// TextItem Constructor
function RavenTextItem(_text, _on_click, _margin, _font, _color = undefined) : RavenItem(_text, _on_click, _margin) constructor {
    container_id = undefined;
    is_enabled = true;
    text = _text;
    on_click = _on_click;
    lock_trigger = false;
    clicking = false;
    gui_clicking = false;
    outline = false;
    margin = _margin;
	specific_margin = 0; //specific margin is an additional margin that can be applied to rendering an item. It is not delegated to a parent container as the regular margin is but applied inside this struct instance.
    x0 = 0;
    y0 = 0;
    x1 = 0;
    y1 = 0;
	text_x1 = 0;
    hover = false;
    font = _font; // Font for the text item
    color = _color; // Color for the text

    function GetContainerId() {
        return container_id;    
    }

    function SetContainerId(_container_id) {
        container_id = _container_id;
    }
	
	function IsOutsideContainerBounds(_container_x1) {
    return (x1 > _container_x1);
}

    function SetEnabled(_set) {
        is_enabled = _set;    
    }

    function SetOnClick(_function) {
        if (is_enabled) {
            on_click = _function;
            SetEnabled(true);
        }
    }

    function OnClick() {
        if (on_click == noone || !on_click) {
            return noone;
        } else {
            on_click();
        }
    }

    function GetText() {
        return text;    
    }

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
        return string_height(text);
    }
	
    function Update() {
        gui_clicking = false;
        if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x0, y0, x1, y1)) {
            hover = true;

            if (mouse_check_button(mb_left)) {
                gui_clicking = true;
            } else {
                gui_clicking = false;
            }

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
	
	//check if our text element is outside the bounds of the container
	function IsTextOutsideBounds() {
		if (text_x1 > x1) {
			return true;
		}
		return false;
	}
    
	// Render method to draw the text item
	function Render() {
	    draw_set_font(font);
		if (color == undefined) {
			draw_set_color(global.gui_text_default);
		} else {
			draw_set_color(color);
		}

	    // Calculate the width of the text
	    var _text_width = string_width(text);

	    // Draw the text up to the x1 position if it fits within the bounds
	    if (text_x1 <= x1) {
	        draw_text(x0 + specific_margin, (y0 + y1) / 2, text);
	    } else {
	        // Calculate the maximum number of characters that can be drawn within bounds
	        var _max_chars = 0;
	        var _current_width = 0;

	        for (var _i = 1; _i <= string_length(text); _i++) {
	            _current_width = string_width(string_copy(text, 1, _i));
	            if (x0 + specific_margin + _current_width <= x1) {
	                _max_chars = _i;
	            } else {
	                break;
	            }
	        }

	        // Draw the portion of the text that fits within the bounds
	        if (_max_chars > 0) {
	            var _truncated_text = string_copy(text, 1, _max_chars);
	            draw_text(x0 + specific_margin, (y0 + y1) / 2, _truncated_text);
	        }
	    }
	    text_x1 = x0 + specific_margin + _text_width;
	}
}