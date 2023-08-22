/// @Description returns a new Raven GUID/UID
function CreateRavenGUID() {
	if (global.raven_debug) show_debug_message("RAVENDEBUG: Generating a GUID");
	var characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	var guid = "";

	repeat(24)
	{
	    var random_index = irandom_range(1, string_length(characters));
	    guid += string_char_at(characters, random_index);

	    if (string_length(guid) % 8 == 0 && string_length(guid) != 24)
	        guid += "-";
	}

	return string(guid);
}