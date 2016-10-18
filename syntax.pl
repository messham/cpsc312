% true if the given string Line ends with a semicolon
semicolon_delimited(Line) :-
    string_concat(_, ";", Line).

% checks for the beginning and end of a function or block
block_begin(Line) :-
    string_concat(_, "{", Line).
block_end(Line) :-
    string_concat(_, "}", Line).
