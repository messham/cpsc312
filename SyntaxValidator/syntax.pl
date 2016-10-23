check_code(Code, ProblemList) :-
    numbered_lines(Code, 0, Numbered),
    problems(Numbered, ProblemList).

% append numbers to the beginning of lines
numbered_lines([],_,[]).
numbered_lines([H|T], Num, [LH|LT]) :-
    string_concat(Num, " ", NSpace),
    string_concat(NSpace, H, LH),
    NPlus is Num + 1,
    numbered_lines(T, NPlus, LT).

% Adds a line to the ProblemList if it is not ended by a semicolon
problems([],[]).
problems([H|T], [H|ProblemList]) :-
    \+ validate(H),
    problems(T, ProblemList).
problems([_|T], ProblemList) :-
    problems(T, ProblemList).

% true if the given string Line ends with a semicolon
validate(Line) :-
    semicolon_delimited(Line).
% TODO check include packages lines
% TODO check that brackets are balanced

semicolon_delimited(Line) :-
    string_concat(_, ";", Line).
