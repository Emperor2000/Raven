/// TextInputItem Constructor
/// @function                RavenTextInputItem(_placeholder_text, _on_click, _margin, _font, _color)
/// @description             Raven text input field.
/// @param {_placeholder_text}     _placeholder_text    Will be displayed in the input field when the user has not typed any input.
/// @param {_on_click}  _on_click  _on_click is maintained for inheritance purposes and potential future functionality. DOES NOT currently do anything.
/// @param {_margin} _margin	applied as margin to the left of the input field from the container.
/// @param {_font} _font	The font used to draw text input.
/// @param {_color}	_color	The color used to draw input border
/// @param {_text_color} _text_color		The color used to draw text input
function RavenTextInputItem(_text, _on_click = undefined, _margin = 16, _font = fnt_dsansmono16, _color = undefined, _text_color = undefined) : RavenItem(_text, _on_click, _margin) constructor {
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
    hover = false;
    font = _font; // Font for the text item
    color = _color; // Color for the text
    input_text = "";
    cursor_position = 0;
	text_color = _text_color;
    active = false; // Flag to indicate if the item is actively receiving input
	placeholder_text = _text;
    // New variables for cursor blinking and input handling
    cursor_blink_interval = 30; // Adjust as needed
    cursor_blink_timer = 0;
    cursor_visible = true;

    // New methods to handle input
    function StartInput() {
        active = true;
        cursor_blink_timer = cursor_blink_interval;
    }

    function StopInput() {
        active = false;
        cursor_blink_timer = 0;
    }
	
	
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
		height = font_get_size(font);
		return height;	
	}

    // Update method with input handling and cursor blinking
    function Update() {
        hover = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x0, y0, x1, y1);
		//show_debug_message(hover);
        if (hover && !active && !lock_trigger && mouse_check_button_pressed(mb_left)) {
            StartInput();
        }

        if (active) {
            if (cursor_blink_timer > 0) {
                cursor_blink_timer -= 1;
                if (cursor_blink_timer == 0) {
                    cursor_visible = !cursor_visible;
                    cursor_blink_timer = cursor_blink_interval;
                }
            }
			//input_text = string_insert("|", input_text, cursor_position);
           // input_text = string_insert(cursor_position, "|", cursor_position + 1);
		   
		   //Copy to clipboard
		   
		   if (global.experimental_features) {
				if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C"))) {
					show_debug_message("copy command:");
				    clipboard_set_text(input_text);
				} else
				if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V"))) {
					show_debug_message("paste command:");
				    var _clipboard_text = clipboard_get_text();
					show_debug_message("text from clipboard: " + _clipboard_text);
				    input_text = string_insert(_clipboard_text, input_text, cursor_position + 1);
					show_debug_message("input text: " + input_text);
				    cursor_position += string_length(_clipboard_text);
				} else
				if (keyboard_check(vk_control) && keyboard_check_pressed(ord("X"))) {
					show_debug_message("cut command:");
					var _clipboard = input_text;
				    clipboard_set_text(_clipboard);
					cursor_position = 1;
					input_text = "";
				    //input_text = string_delete(input_text, 0, string_length(clipboard_get_text()));
				}
		   }
            if (keyboard_check_pressed(vk_left)) {
                cursor_position = max(0, cursor_position - 1);
            }
            if (keyboard_check_pressed(vk_right)) {
                cursor_position = min(string_length(input_text), cursor_position + 1);
            }
			if (keyboard_check_pressed(vk_backspace)) {
			    if (cursor_position > 0) {
			        cursor_position -= 1;  // Update cursor position first
			        input_text = string_delete(input_text, cursor_position, 1);  // Then modify input_text
			    }
			}
            if (keyboard_check_pressed(vk_delete)) {
                input_text = string_delete(input_text, cursor_position, 1);
            }

            var _input_char = keyboard_string;
            if (string_length(_input_char) > 0 && _input_char != "\r") {
                input_text = string_insert("", _input_char, cursor_position + 1);
                cursor_position += 1;
            }

            if (keyboard_check_pressed(vk_enter) || (!hover && mouse_check_button_pressed(mb_left))) {
                StopInput();
            }
        }
    }

    // Render method with cursor blinking and input display
	function Render() {

	    draw_set_font(font);
	    var _font_height = font_get_size(font);

	    // Determine the maximum width based on the input text length
	    var _max_width = string_width(input_text) <= 128 ? 128 : string_width(input_text) * 1.05;

	    // Draw the background rectangle
	    draw_rectangle(x0 + specific_margin, y0, x0 + specific_margin + _max_width, y1 + _font_height, true);

	    var _text_x = x0 + specific_margin;
	    var _text_y = y0 + (y1 - y0 - _font_height) / 2;

		if (text_color == undefined) {
			draw_set_color(global.gui_text_default);
		} else {
			draw_set_color(text_color);
		}

	    var _display_text = input_text;
	    if (string_length(_display_text) == 0 && !active) {
	        _display_text = placeholder_text;
	    }
		//show_debug_message("Display Text: " + _display_text);
		//show_debug_message("Input Text: " + input_text);

	    // Clamp the cursor position within the valid range
	    cursor_position = clamp(cursor_position, 0, string_length(input_text));

	    if (active && cursor_visible) {
	        var _pre_cursor = string_copy(_display_text, 0, cursor_position);
	        var _post_cursor = string_copy(_display_text, cursor_position + 1, string_length(_display_text) - cursor_position);
			_display_text = _pre_cursor + "|" + _post_cursor;
			//Debug purposes alternative, also displays the cursor position/index
	        //_display_text = _pre_cursor + "|" + _post_cursor + " " + string(cursor_position);
	    }
		//show_debug_message("display text: " + _display_text);
		//show_debug_message("input text: " + input_text);
	    var _text = draw_text(_text_x, _text_y, _display_text);
		//show_debug_message("result: " + _display_text);
	}

}