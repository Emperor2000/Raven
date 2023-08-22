/// TextItem Constructor

function RavenLineBreakItem(_margin, _height, _color = undefined) constructor {
    container_id = undefined;
    is_enabled = true;
    margin = _margin;
	height = _height;
    x0 = 0;
    y0 = 0;
    x1 = 0;
    y1 = 0;
	text_x1 = 0;
    hover = false;
    color = _color; // Color for the text

    function GetContainerId() {
        return container_id;    
    }

    function SetContainerId(_container_id) {
        container_id = _container_id;
    }
	
	function IsOutsideContainerBounds(container_x1) {
    return (x1 > container_x1);
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

    function GetWidth() {
		return x1 - x0;
    }   

    function SetCoords(_x0, _y0, _x1, _y1) {
        x0 = _x0;
        y0 = _y0;
        x1 = _x1;
        y1 = _y1;
    }

    function GetHeight() {
        return height;
    }
	
    function Update() {
		
    }
    
	// Render method to draw the text item
	function Render() {
		if (color != undefined) {
			draw_set_color(color);
			draw_rectangle(x0,x1,y0,y1,false);
		}
	}
}