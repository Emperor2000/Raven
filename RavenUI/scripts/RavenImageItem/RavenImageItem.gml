//A Raven Item is a page or a function trigger
///@Description An item, use false or noone for _on_click if not interactable.
/// @param {Asset.GMSprite}  _sprite  The sprite 
/// @param {Real}	_margin The margin applied to the top, buttom, left and right of the item.
/// @param {Real}	_image_x_scale The x scaling of the image, where 1 is the original scale.
/// @param {Real}	_image_y_scale The y scaling of the image, where 1 is the original scale.
function RavenImageItem(_sprite, _margin = 0, _sprite_xscale = 1, _sprite_yscale = 1) constructor {
	container_id = undefined;
	is_enabled = true;
	lock_trigger = false;
	subitems = ds_list_create();
	outline = false;
	margin = _margin;
	x0 = 0;
	y0 = 0;
	x1 = 0;
	y1 = 0;
	height = 0;
	sprite = _sprite
	sprite_xscale = _sprite_xscale;
	sprite_yscale = _sprite_yscale;
	
	function GetContainerId() {
		return container_id;	
	}
	
	function SetContainerId(_container_id) {
		container_id = _container_id;
	}
	
	function SetEnabled(_set) {
		is_enabled = _set;	
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
	}
	
    function GetHeight() {
        return sprite_get_height(sprite)*sprite_yscale;
    }
	
	function Update() {
		
	}
	
	function Render() {
		draw_sprite_ext(sprite,0,x0,y0,sprite_xscale,sprite_yscale,0,c_white,1);
	}
	
	

}