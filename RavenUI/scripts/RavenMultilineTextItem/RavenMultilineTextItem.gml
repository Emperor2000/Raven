/// RavenMultiLineTextItem Constructor
function RavenMultilineTextItem(_text, _on_click, _margin = 16, _font = fnt_dsansmono16, _color = undefined) : RavenItem(_text, _on_click, _margin) constructor {
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

    function GetContainerId() {
        return container_id;    
    }

    function SetContainerId(_container_id) {
        container_id = _container_id;
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

    function Render() {
        draw_set_font(font);
		
		if (color == undefined) {
			draw_set_color(global.gui_text_default);
		} else {
			draw_set_color(color);
		}

        var _x = x0 + specific_margin;
        var _y = (y0 + y1) / 2;
        var _max_width = x1 - x0 - specific_margin * 2;

        var _words = string_split(text, " ");
        var _current_line = "";

        for (var _i = 0; _i < array_length_1d(_words); _i++) {
            var _word = _words[_i];
            var _line_width = string_width(_current_line + " " + _word);

            if (_line_width <= _max_width) {
                if (_current_line != "") {
                    _current_line += " ";
                }
                _current_line += _word;
            } else {
                // Draw the current line and move the y-coordinate
                draw_text(_x, _y, _current_line);
                _y += string_height(_current_line);

                _current_line = _word; // Start a new line
            }
        }

        // Draw the last line
        draw_text(_x, _y, _current_line);
    }
}