raven_gui.Update();

if (global.current_size_x != window_get_width() || global.current_size_y != window_get_height()) {
    global.current_size_x = window_get_width();
    global.current_size_y = window_get_height();
    global.current_scale_x = global.current_size_x / global.resolution_base_x;
    global.current_scale_y = global.current_size_y / global.resolution_base_y;
	global.current_scale_x = 1;
	global.current_scale_y = 1;

    // Update the scale factor for UI elements or perform any necessary actions
	show_debug_message(global.current_size_x);
	show_debug_message(global.current_size_y);
	show_debug_message(global.current_scale_x);
	show_debug_message(global.current_scale_y);


}


//global.resolution_base_x and global.resolution_base_y
//constitute the scale factor the app was designed for
//that scale should be 1 for width and height
//todo: remove THEME manager from step event and only update when called.

//Theme Manager
//generics
global.gui_status_success = $25de23
global.gui_status_warning = $2362de;
global.gui_status_error = $2323de;
global.gui_status_disabled = $242425;
switch(THEME) {
	case THEME.RAVEN:
		global.gui_background = $2a2a2e;
		global.gui_menu = $1b1b1b;
		global.gui_text_default = $f0c5d3;
		global.gui_text_primary = $dbc4cc;
		global.gui_button_border = $382d31;
		global.gui_menu_click = $45373c;
		global.gui_menu_hover = $34292d;
		global.gui_outline = $1b1b1b;
		global.gui_checkmark_color = c_lime;
		break;
	case THEME.DARK:
		global.gui_background = $2a2a2e;
		global.gui_menu = $1b1b1b;
		global.gui_text_default = $c6c6d0;
		global.gui_text_primary = $bfbfd9;
		global.gui_button_border = $39393a;
		global.gui_menu_click = $373838;
		global.gui_menu_hover = global.gui_menu_click;
		global.gui_outline = $1b1b1b;
		global.gui_checkmark_color = c_lime;
		break;
	case THEME.LIGHT:
		//lobal.gui_background = $e3e3e3;
		global.gui_background = $dddbdc;
		global.gui_menu = $dddbdc;
		global.gui_text_default = $303030;
		global.gui_text_primary = $1f1f1f;
		global.gui_button_border = $272727;
		global.gui_menu_click = $cacaca;
		global.gui_menu_hover = global.gui_menu_click;
		global.gui_outline = $171718;
		global.gui_checkmark_color = c_lime;
		break;
	case THEME.DARKMIN:
		//not implemented
		global.gui_background = GUI_DARK_BACKGROUND;
		global.gui_menu = GUI_DARK_MENU;
		global.gui_text_default = GUI_DARK_TEXT_DEFAULT;
		global.gui_text_primary = GUI_DARK_TEXT_PRIMARY;
		global.gui_button_border = GUI_DARK_BUTTON_BORDER;
		global.gui_menu_click = GUI_DARK_MENU_CLICK;
		global.gui_menu_hover = global.gui_menu_click;
		global.gui_checkmark_color = c_lime;
		break;
	case THEME.APPLE:
		global.gui_background = $9494d2;
		global.gui_menu = $4c4cc8;
		global.gui_text_default = $292954;
		global.gui_text_primary = $292954;
		global.gui_button_border = $645dc1;
		global.gui_menu_click = $5e57bf;
		global.gui_menu_hover = global.gui_menu_click;
		global.gui_outline = $5f57c8;
		global.gui_checkmark_color = c_lime;
		break;
	case THEME.COFFEE:
		global.gui_background = $638aa7;
		global.gui_menu = $2a485f;
		global.gui_text_default = $75aad2;
		global.gui_text_primary = $97cbf2;
		global.gui_button_border = $7490a5;
		global.gui_menu_click = $7eb8e3;
		global.gui_menu_hover = global.gui_menu_click;
		global.gui_outline = $2a485f;
		global.gui_checkmark_color = c_lime;
		break;
}




	