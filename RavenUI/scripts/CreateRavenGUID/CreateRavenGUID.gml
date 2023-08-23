/// @Description returns a new Raven GUID/UID
function CreateRavenGUID() {
	if (global.raven_debug) show_debug_message("RAVENDEBUG: Generating a GUID");
	var _characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	var _guid = "";

	repeat(24)
	{
	    var _random_index = irandom_range(1, string_length(_characters));
	    _guid += string_char_at(_characters, _random_index);

	    if (string_length(_guid) % 8 == 0 && string_length(_guid) != 24)
	        _guid += "-";
	}

	return string(_guid);
}