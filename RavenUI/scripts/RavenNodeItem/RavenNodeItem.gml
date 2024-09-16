//A Raven Item is a page or a function trigger
///@Description An item, use false or noone for _on_click if not interactable.
/// @param {Function}  _on_click  The function to run when left clicking the node
/// @param {Function}  _on_connect_input The function to run when this node receives data (input) from another node.
/// @param {Function}  _on_connect_output The function to run when this node passes data (output) to another node.
/// @param {Real}	_margin The margin applied to the top, buttom, left and right of the item.
/// @param {Asset.GMSprite}	_sprite The sprite to use when this node is not connected.
/// @param {Asset.GMSprite} _sprite_connected_color The sprite to use when this node is connected.
/// @param {Real}	_sprite_x_scale The x scaling of the node image, where 1 is the original scale.
/// @param {Real}	_sprite_y_scale The y scaling of the node image, where 1 is the original scale.
function RavenNodeItem(_on_click, _on_connect_input, _on_connect_output, _margin = 0, _sprite = spr_node_white_fill, _sprite_connected_color = spr_node_white_fill, _sprite_xscale = 1, _sprite_yscale = 1) constructor {
	container_id = undefined;
	is_enabled = true;
	if (_on_click == noone || !_on_click || _on_click == undefined)
	    on_click = _on_click;
	else
	    on_click = method(self, _on_click); //Note that _on_click expects a function!
		
	if (_on_connect_input == noone || !_on_connect_input || _on_connect_input == undefined)
		on_connect_input = _on_connect_input;
	else
		on_connect_input = method(self, _on_connect_input);
	if (_on_connect_output == noone || !_on_connect_output || _on_connect_output == undefined)
		on_connect_output = _on_connect_output;
	else
		on_connect_output = method(self, _on_connect_output);
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
	sprite = _sprite
	sprite_xscale = _sprite_xscale;
	sprite_yscale = _sprite_yscale;
	sprite_connected_color = _sprite_connected_color;
	select_padding = 4; //appends in pixels to the selector.
	node_object_representation = instance_create_depth(x0,y0,0, obj_node);
	node_object_representation.node_struct_representation = self;
	connected_node_source_render_target = undefined; //used to reverse rerender to draw on top of everything else.
	is_input_logic_from_connected_node_executed = false;
	
	node_target_object_representation = undefined; //The node's object representation
	node_target = undefined; //The node's struct representation
	selected = false;
	bind_mode = false;
	bind_toggled_last_frame = false;
	
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
	
	/// @description	Set the function to run when a node passes data to this node.
	function SetOnConnectInput(_function) {
		on_connect_input = _function;
	}
	
	
	/// @description	Run the input function onto this node (what this node receives)
	function OnConnectInput() {
		if (on_connect_input == noone || !on_connect_input) {
			return noone;	
		} else {
			on_connect_input();	
		}
	}
	
	/// @description	Set the function to run when a node passes data to the connected node.
	function SetOnConnectOutput(_function) {
		on_connect_output = _function;
	}
	
	/// @description	Run the output function onto the connected node (what this node passes on)
	function OnConnectOutput() {
		if (on_connect_output == noone || !on_connect_output) {
			return noone;	
		} else {
			on_connect_output();	
		}
	}
	
	
	
	/// @description	returns the width of the text in pixels.
	function GetWidth() {
		return sprite_get_width(sprite)*sprite_xscale;
	}
	
	function SetCoords(_x0, _y0, _x1, _y1) {
		x0 = _x0;
		y0 = _y0;
		x1 = _x1;
		y1 = _y1;
		node_object_representation.x = x0;
		node_object_representation.y = y0;
	}
	
    function GetHeight() {
        return sprite_get_height(sprite)*sprite_yscale;
    }
	
	function Delete() {
		instance_destroy(node_object_representation);
	}
	
	function ClearConnectedNodeSourceRenderTarget() {
		connected_node_source_render_target = undefined;
		is_input_logic_from_connected_node_executed = false;
	}
	
	function ClearTarget() {
		if (node_target != undefined && node_target != noone) {
			node_target_object_representation = undefined;
			node_target = undefined;	
			ClearConnectedNodeSourceRenderTarget();
		}
	}
	
	function OnMouseRightDeleteNodeConnection() {
		if (hover && mouse_check_button(mb_right)) {
			if (connected_node_source_render_target != undefined) {
				var _conn_struct = connected_node_source_render_target.node_struct_representation;
				_conn_struct.ClearTarget();
				connected_node_source_render_target = undefined;	
			}
			if (node_target != undefined) {
				//Delete render target from source node
				//node_target.node_target_object_representation = undefined;
				//node_target.node_target = undefined;
				//Delete target node connection
				if (node_target_object_representation != undefined && node_target_object_representation != noone && node_target != noone && node_target != undefined) {
					node_target_object_representation = undefined;
					node_target.connected_node_source_render_target = undefined;
					node_target = undefined;
				}
			}
			ClearTarget();
		}
		//show_debug_message("CONNECTION DEBUGGER_-------------------");
		//show_debug_message(connected_node_source_render_target);
		//show_debug_message(node_target_object_representation);
		//show_debug_message(node_target);
		//show_debug_message(node_target);
		//show_debug_message("---------------------------------------");
	}
	
	
	function Update() {
		node_object_representation.depth = GetRavenContainerById(container_id).gui_depth_index;
		
		//If this node has been connected as an output node.
		if (connected_node_source_render_target != noone and connected_node_source_render_target != undefined && !is_input_logic_from_connected_node_executed) {
			//the node is connected and input logic has not been executed yet, run it:
			OnConnectInput();
			is_input_logic_from_connected_node_executed = true; //we have executed the input logic from the origin/connected node.
		}
		
		//gui_clicking = false;
			//Deactivate clicking if mb left has been released.
			if (!mouse_check_button(mb_left)) {
				gui_clicking = false;
			}
			
			if (mouse_check_button(mb_left) && selected) {
				bind_mode = true;
			} else {
				selected = false;	
				bind_mode = false;	
			}
			
		
		if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x0, y0, x0 + sprite_get_width(sprite)*sprite_xscale + select_padding, y0 + sprite_get_height(sprite)*sprite_yscale + select_padding)) {
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
				selected = true;
				window_set_cursor(cr_handpoint);
				OnClick();	
			} else {
				clicking = false;	
			}
		} else {
			hover = false;
		}
		
		//release drag --> this is where we check for the object and connect the node.
		if (bind_toggled_last_frame && !mouse_check_button(mb_left)) {
			//check if there is a node at the target position.
			var _obj = instance_position(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), obj_node);
			show_debug_message("INSTANCE POSITION FOUND");
			show_debug_message(_obj);
			if (_obj != undefined && _obj != noone && _obj != node_object_representation) {
				node_target_object_representation = _obj;
				node_target = node_target_object_representation.node_struct_representation;
				node_target.connected_node_source_render_target = node_object_representation; //bind this node's object representation to the target node's source
				show_debug_message(node_target_object_representation);
				//connection made --> should run output logic in connected node.
				output_function_template = function() {
					show_debug_message("Running node output function on target.OnConnectInput");
					OnConnectOutput();		
				}
				node_target.SetOnConnectInput(output_function_template);
			}
		}
		bind_toggled_last_frame = false;
		
		//todo --> remove connection to source and target node.
		//connected_node_source_render_target = undefined;
		OnMouseRightDeleteNodeConnection();
		
		
	}
	
	
	
	function Render() {	
		draw_sprite_ext(sprite,0,x0,y0,sprite_xscale,sprite_yscale,0,c_white,1);
		
		if (hover) {
			draw_sprite_ext(sprite,0,x0,y0,sprite_xscale,sprite_yscale,0,global.gui_menu_hover,0.3);
		}
		
		if (gui_clicking) {
			draw_sprite_ext(sprite,0,x0,y0,sprite_xscale,sprite_yscale,0,global.gui_menu_click,0.6);	
		}
		
		if (bind_mode) {
			draw_sinus_curve(x0 + GetWidth() / 2, y0 + GetHeight() / 2, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 300, 1, c_white, 2);	
			bind_toggled_last_frame = true;
			global.handler.lock_new_interactions(5);
		}
		
		if (node_target_object_representation != undefined && node_target_object_representation != noone) {
			draw_sinus_curve(x0 + GetWidth() / 2, y0 + GetHeight() / 2, node_target_object_representation.x + GetWidth() / 2, node_target_object_representation.y + GetHeight() / 2, 300, 1, c_white, 2);
			draw_sprite_ext(sprite_connected_color,0,x0,y0,sprite_xscale,sprite_yscale,0,c_white,1);
		}
		
		if (connected_node_source_render_target != undefined && connected_node_source_render_target != noone) {
			draw_sinus_curve(x0 + GetWidth() / 2, y0 + GetHeight() / 2, connected_node_source_render_target.x + GetWidth() / 2, connected_node_source_render_target.y + GetHeight() / 2, 300, 1, c_white, 2);
			draw_sprite_ext(sprite_connected_color,0,x0,y0,sprite_xscale,sprite_yscale,0,c_white,1);
		}
		
	}
	
	

}