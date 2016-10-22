% append numbers to the beginning of lines
number_line([],_,[]).
number_line([H|T], Num, [LH|LT]) :-
    string_concat(Num, " ", NSpace),
    string_concat(NSpace, H, LH),
    NPlus is Num + 1,
    number_line(T, NPlus, LT).

% Adds a line to the ProblemList if it is not ended by a semicolon
% TODO add only a line number
check_code([],[]).
check_code([H|T], [H|ProblemList]) :-
    \+ validate(H),
    check_code(T, ProblemList).
check_code([_|T], ProblemList) :-
    check_code(T, ProblemList).

% true if the given string Line ends with a semicolon
validate(Line) :-
    semicolon_delimited(Line).
% TODO check include packages lines
% TODO check that brackets are balanced

semicolon_delimited(Line) :-
    string_concat(_, ";", Line).

% checks for the beginning and end of a function or block
% TODO this is pretty naive, does not balance brackets
% only recognizes that they are a valid alternative to semicolons
% block_begin(Line) :-
%     string_concat(_, "{", Line).
% block_end(Line) :-
%     string_concat(_, "}", Line).
