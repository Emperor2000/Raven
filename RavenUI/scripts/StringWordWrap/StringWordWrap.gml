/// string_word_wrap(text, max_width)
// Wraps a given text string to fit within a maximum width
// Returns an array containing the wrapped lines
function string_word_wrap(_text, _max_width) {
    var _lines = []; // Array to store wrapped lines
    var _current_line = ""; // Current line being built
    var _words = string_tokenize(_text); // Tokenize the text into individual words

    // Iterate through each word in the text
    for (var _i = 0; _i < array_length_1d(_words); _i++) {
        var _word = _words[_i];
        var _word_width = string_width(_word);

        // Check if adding the word exceeds the maximum width
        if (string_width(_current_line + " " + _word) <= _max_width || string_length(_current_line) == 0) {
            // If adding the word does not exceed the maximum width, add it to the current line
            if (string_length(_current_line) == 0) {
                _current_line = _word; // If the current line is empty, add the word directly
            } else {
                _current_line += " " + _word; // Otherwise, add a space before adding the word
            }
        } else {
            // If adding the word exceeds the maximum width, push the current line to the lines array
            array_push(_lines, _current_line);
            _current_line = _word; // Start a new line with the current word
        }
    }

    // Push the remaining line (if any) to the lines array
    if (string_length(_current_line) > 0) {
        array_push(_lines, _current_line);
    }

    return _lines; // Return the array of wrapped lines
}

/// string_tokenize(text)
// Tokenizes a given text string into individual words
// Returns an array containing the words

function string_tokenize(_text) {
    var _words = []; // Array to store individual words
    var _current_word = ""; // Current word being built

    // Iterate through each character in the text
    for (var _i = 1; _i <= string_length(_text); _i++) {
        var _char = string_char_at(_text, _i);

        // Check if the character is a space or newline
        if (_char == " " || _char == "\n") {
            // If the current word is not empty, push it to the words array
            if (string_length(_current_word) > 0) {
                array_push(_words, _current_word);
                _current_word = ""; // Reset the current word
            }
        } else {
            // If the character is not a space or newline, add it to the current word
            _current_word += _char;
        }
    }

    // Push the last word (if any) to the words array
    if (string_length(_current_word) > 0) {
        array_push(_words, _current_word);
    }

    return _words; // Return the array of words
}


/// string_wrap(text, max_width)
// Wraps a given text string to fit within a maximum width
// Returns an array containing the wrapped lines

function string_wrap(_text, _max_width) {
    var _lines = []; // Array to store wrapped lines
    var _current_line = ""; // Current line being built

    // Iterate through each character in the text
    for (var _i = 1; _i <= string_length(_text); _i++) {
        var _char = string_char_at(_text, _i);

        // Check if adding the character exceeds the maximum width
        if (string_width(_current_line + _char) <= _max_width || string_length(_current_line) == 0) {
            // If adding the character does not exceed the maximum width, add it to the current line
            _current_line += _char;
        } else {
            // If adding the character exceeds the maximum width, push the current line to the lines array
            array_push(_lines, _current_line);
            _current_line = _char; // Start a new line with the current character
        }
    }

    // Push the remaining line (if any) to the lines array
    if (string_length(_current_line) > 0) {
        array_push(_lines, _current_line);
    }

    return _lines; // Return the array of wrapped lines
}