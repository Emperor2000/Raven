// Init
global.handler = instance_create_depth(x,y,depth, obj_raven_handler);
#region Macros
// Dark THEME - macros not directly used, but simply serve as data store for THEME manager
#macro GUI_DARK_BACKGROUND $2a2a2e
#macro GUI_DARK_MENU $1b1b1b
#macro GUI_DARK_TEXT_DEFAULT $c6c6d0
#macro GUI_DARK_TEXT_OPTIONAL $7f7f8e
#macro GUI_DARK_TEXT_PRIMARY $bfbfd9
#macro GUI_DARK_BUTTON_BORDER $39393a
#macro GUI_DARK_MENU_CLICK $373838
#macro GUI_DARK_OUTLINE $171718

#macro GUI_ACTIVITY_COLOUR_DEFAULT $b1b1c7
#macro GUI_ACTIVITY_COLOUR_SCHEDULER $aacc74
#macro GUI_ACTIVITY_COLOUR_HTTP $7bc3c8


// Raven THEME 
#macro GUI_RAVEN_BACKGROUND $2a2a2e
#macro GUI_RAVEN_MENU $1b1b1b
#macro GUI_RAVEN_TEXT_DEFAULT $f0a8c0
#macro GUI_RAVEN_TEXT_PRIMARY $bd95a3
#macro GUI_RAVEN_BUTTON_BORDER $382d31
#macro GUI_RAVEN_MENU_CLICK $45373c
#macro GUI_RAVEN_CHECKMARK $9e6975




// Text
#macro GUI_TEXT_FONT_DEFAULT default
#macro GUI_TEXT_FONT_MENU_ 14

#endregion

#region global variables - base
enum THEME {
	RAVEN,
	DARK,
	LIGHT,
	DARKMIN,
	APPLE,
	COFFEE
}
global.THEME = THEME.RAVEN;

global.open_help_page = function open_help_page(){
	url_open("https://ravenforgamemaker.com");
}

global.resolution_x = 3840; //1920; 
global.resolution_y = 2160; //1080;

global.resolution_base_x = 1366;
global.resolution_base_y = 768;

global.current_size_x = window_get_width();
global.current_size_y = window_get_height();
global.current_scale_x = 1;
global.current_scale_y = 1;
global.interface_scale = 1.5;

global.gui_background = GUI_DARK_BACKGROUND;
global.gui_menu = GUI_DARK_MENU;
global.gui_text_default = GUI_DARK_TEXT_DEFAULT;
global.gui_text_primary = GUI_DARK_TEXT_PRIMARY;
global.gui_button_border = GUI_DARK_BUTTON_BORDER;
global.gui_menu_click = GUI_DARK_MENU_CLICK;
global.gui_menu_hover = $34292d;
global.gui_outline = GUI_DARK_OUTLINE;
global.gui_checkmark_color = GUI_RAVEN_CHECKMARK;

global.gui_depth_index = 0; //auto increment id, currently unused. TODO

global.experimental_features = false; //Enables some experimental features in the framework. These functionalities may be untested or still contain bugs!
global.preview_features = true; //Enables preview features in the framework, more thoroughly tested than experimental features, but may be overhauled or altered.

#endregion

#region Callback functions & Closures

global.destroy_container = function() {
    var _captured_container_id = self.container_id;
    // Define the actual destroy_container logic using captured_container_id
    DestroyRavenContainerById(_captured_container_id);
};

#endregion


//GET STARTED HERE
#region Config & Customize
display_set_gui_maximise();

//THEMES INIT
//CHANGE YOUR SELECTED THEME
THEME = THEME.RAVEN;


//Also copy paste any custom THEMEs in step event if you want to update these dynamically.
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
		global.gui_checkmark_color = $9e6975;
		global.gui_item_color = $9e6975;
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


#endregion

//init raven
#region Init RavenGUI
global.raven_debug = true;
raven_gui = new RavenMain();
raven_menu = new RavenMenu(0,0,64,32,32);
overview_button = new RavenItem("Overview",noone);
new_button = new RavenItem("New", noone);
save_button = new RavenItem("Save",noone);
view_button = new RavenItem("View",noone);
undo_button = new RavenItem("Undo", noone);
redo_button = new RavenItem("Redo", noone);
export_button = new RavenItem("Export", noone);
preferences_button = new RavenItem("Preferences", noone);
variables_button = new RavenItem("variables", noone);
changelog_button = new RavenItem("Changelog", noone);
help_button = new RavenItem("Help",global.open_help_page);
//container = new RavenContainer(0,0,1920,1080, true, false);
container = new RavenContainer(0,0,global.resolution_x, global.resolution_y, true, false);
container.SetLock(true);
raven_gui.SetMenu(raven_menu);
raven_menu.SetOutline(true);
raven_menu.AddItem(overview_button);
raven_menu.AddItem(new_button);
raven_menu.AddItem(save_button);
raven_menu.AddItem(view_button);
raven_menu.AddItem(undo_button);
raven_menu.AddItem(redo_button);
raven_menu.AddItem(export_button);
raven_menu.AddItem(variables_button);
raven_menu.AddItem(preferences_button);
raven_menu.AddItem(changelog_button);
raven_menu.AddItem(help_button);
raven_gui.AddContainer(container);
//raven_gui.AddContainer(new RavenContainer(200,200,400,400,false, c_red));









//Get Started here:

//replace with your own elements------------------------
var _subcontainer = new RavenContainer(200,200,600,600,false, true, GUI_RENDER_MODE.VLIST, 3);
_subcontainer.SetGUIDepthIndex(2);
var _container_menu = new RavenMenu(0,0,64,32,32);
_subcontainer.SetMenu(_container_menu);
_container_menu.AddItem(new RavenItem("Exit",global.destroy_container,32));
_subcontainer.SetMenuBoundByContainer(true);
_subcontainer.AddItem(new RavenTextItem("This is a TextField",0,16, fnt_dsansmono16));
_subcontainer.AddItem(new RavenTextItem("Welcome to Raven, enter your name:",0,16,fnt_dsansmono16));

_subcontainer.AddItem(new RavenTextInputItem("Username", noone, 16, fnt_dsansmono16, GUI_RAVEN_TEXT_DEFAULT));
//subcontainer.AddItem(new RavenMultilineTextItem("Let's write an entire section. This code should be shifted to the next line as soon as it overflows!",0,16,fnt_dsansmono16, GUI_RAVEN_TEXT_DEFAULT));
_subcontainer.AddItem(new RavenTextItem("",0,16,fnt_dsansmono16));
_subcontainer.AddItem(new RavenTextItem("",0,16,fnt_dsansmono16));
_subcontainer.AddItem(new RavenCheckboxItem("Check Me: "));
show_debug_message("list size (init0): " + string(ds_list_size(_subcontainer.items)));
_subcontainer.AddItem(new RavenLineBreakItem(32,32));
_subcontainer.AddItem(new RavenButtonItem("This is a button", noone, 16, 6, 6, true));
_subcontainer.AddItem(new RavenImageButtonItem(noone,spr_sample_image,16,1,1));
_subcontainer.AddItem(new RavenImageItem(spr_sample_image,16,1,1));
_subcontainer.AddItem(new RavenMultilineTextItem("This is a multiline text item. A multi line text item shifts any text that does not fit on a certain line to the next line, again and again. Until all text fits within your container horizontally.", -1,16,fnt_dsansmono16));
//subcontainer.AddItem(new RavenDropdownItem("Dropdown"));
raven_gui.AddContainer(_subcontainer);



//----------------------------------





//We must push all references when finished init so that each raven item knows it's parent container:
raven_gui.PushReferences();


#endregion


//Container init
//Containers support being rendered in a few different modes.
enum GUI_RENDER_MODE {
	HLIST,
	VLIST,
	GRID,
	COLUMNS2,
	MANUAL
}