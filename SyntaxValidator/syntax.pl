check_code(CodeRaw, ProblemList) :-
    % split raw code into list of lines
    split_string(CodeRaw, "\n", "", CodeListRaw),
    % delete white space
    delete(CodeListRaw, "", CodeList),
    % number lines
    numbered_lines(CodeList, 0, Numbered),
    % return list of problems
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
    string_concat(_, ";", Line).
% true if this is a well-formed package include line
% TODO this fails once lines are numbered
validate(Line) :-
    string_concat("#include <", EndLine, Line),
    string_concat(_, ">", EndLine).

% TODO check that brackets are balanced

% Ensure that all brackets are balanced
balanced(Code) :-
    atom_chars(Code, CharList),
    balanced(CharList, []).
balanced([],[]).
% Round brackets
balanced([C|S], K) :-
    C = '(',
    !,
    balanced(S, [C|K]).
balanced([C|S], [_|K]) :-
    C = ')',
    !,
    balanced(S, K).
% Curly brackets
balanced([C|S], K) :-
    C = '{',
    !,
    balanced(S, [C|K]).
balanced([C|S], [_|K]) :-
    C = '}',
    !,
    balanced(S, K).
% This character is not a bracket
balanced([C|S], K) :-
    C \= '(',
    C \= ')',
    C \= '{',
    C \= '}',
    balanced(S, K).
