// Create the _keyboard_check_ext function
/// @function _keyboard_check_ext
/// @description Check _keyboard input once every specified number of _frames
/// @param {Real} _key - The key to check
/// @param {Real} _frames - Number of frames to wait before checking input again
/// @returns {bool} Returns true if the _key is pressed, otherwise false
function keyboard_check_ext(_key, _frames) {
	// Check if the frame counter exists for the specified _key
    if (!ds_map_exists(global.keyboard_check_counters, string(_key)))
    {
        // If it doesn't exist, create it and set it to 0
        ds_map_add(global.keyboard_check_counters, string(_key), 0);
    }
    
    // Increment the frame counter for the specified _key
    global.keyboard_check_counters[? string(_key)]++;
    
    // Check if the counter has reached the specified number of _frames
    if (global.keyboard_check_counters[? string(_key)] >= _frames)
    {
        // Reset the frame counter for the specified _key
        global.keyboard_check_counters[? string(_key)] = 0;
        
        // Return the state of the _key
        return keyboard_check(_key);
    }
    
    // If not enough _frames have passed, return false
    return false;
}