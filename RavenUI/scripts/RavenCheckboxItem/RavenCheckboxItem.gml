/// RavenCheckboxItem Constructor
function RavenCheckboxItem(_text, _on_click = undefined, _margin = 16, _font = fnt_dsansmono16, _color = global.gui_text_primary, _checkmark_color = global.gui_checkmark_color, _value = false) : RavenItem(_text, _on_click, _margin) constructor {
    container_id = undefined;
    is_enabled = true;
    text = _text;
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
    value = _value; // Checkbox value (true or false)
	checkmark_color = _checkmark_color;
	checkbox_scale = 1.5;
	rectangle_x0 = 0;
	rectangle_y0 = 0;
	rectangle_x1 = 0;
	rectangle_y1 = 0;
	specific_margin = 0; //specific margin is an additional margin that can be applied to rendering an item. It is not delegated to a parent container as the regular margin is.
	
	function SetCheckboxScale(_checkbox_scale) {
		checkbox_scale = _checkbox_scale;
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

    function ToggleValue() {
        value = !value;
    }

    function GetValue() {
        return value;
    }

    function SetCoords(_x0, _y0, _x1, _y1) {
        x0 = _x0;
        y0 = _y0;
        x1 = _x1;
        y1 = _y1;
    }

    function Update() {
        gui_clicking = false;
        if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), rectangle_x0, rectangle_y0, rectangle_x1, rectangle_y1)) {
            hover = true;
            if (mouse_check_button_pressed(mb_left)) {
                clicking = true;
            } else {
                clicking = false;
            }
        } else {
            hover = false;
        }

        if (clicking && point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), rectangle_x0, rectangle_y0, rectangle_x1, rectangle_y1)) {
            ToggleValue();
            clicking = false; // Reset clicking state after handling the click
        }
    }

    function Render() {
		
		// Draw the text
        draw_set_font(font);
        draw_set_color(global.gui_text_default);
        draw_text(x0 + specific_margin, y0, text);
		
		
        var _checkbox_x = x0 + specific_margin + string_width(text);
        var _checkbox_y = y0 - string_height(text)/2 + specific_margin/2;

        if (value) {
            draw_set_color(checkmark_color); // Change color to checkmark color
        } else {
            draw_set_color(global.gui_background); // Change color to match background
        }

        // Draw checkbox rectangle
        draw_rectangle(_checkbox_x, _checkbox_y, _checkbox_x + GetCheckboxWidth(), _checkbox_y + GetCheckboxHeight(), false);
		
		draw_set_color(global.gui_text_default);
		draw_rectangle(_checkbox_x, _checkbox_y, _checkbox_x + GetCheckboxWidth(), _checkbox_y + GetCheckboxHeight(), true);
		
		rectangle_x0 = _checkbox_x;
		rectangle_y0 = _checkbox_y;
		rectangle_x1 = _checkbox_x + GetCheckboxWidth();
		rectangle_y1 = _checkbox_y + GetCheckboxHeight();
		


    }

    function GetCheckboxWidth() {
        return GetTextHeight() * checkbox_scale;
    }

    function GetCheckboxHeight() {
        return GetTextHeight() * checkbox_scale;
    }

    function GetTextHeight() {
        return string_height(text);
    }
}