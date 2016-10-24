% Check the code for proper format and balanced brackets
% The first predicate is for balanced brackets, the second is for unbalanced
% Any malformed lines of code are output as the problem list
check_code(CodeRaw, ProblemList) :-
    % check for balanced brackets
    balanced(CodeRaw),
    % split code into lines on newline char
    split_string(CodeRaw, "\n", "", CodeListRaw),
    % delete white space
    delete(CodeListRaw, "", CodeList),
    % number lines
    numbered_lines(CodeList, 0, Numbered),
    % return list of problem lines
    problems(Numbered, ProblemList),
    !,
    write("All brackets appear to be balanced").
% Unbalanced parentheses
check_code(CodeRaw, ProblemList) :-
    \+balanced(CodeRaw),
    split_string(CodeRaw, "\n", "", CodeListRaw),
    delete(CodeListRaw, "", CodeList),
    numbered_lines(CodeList, 0, Numbered),
    problems(Numbered, ProblemList),
    write("There is a bracket imbalance").

% append numbers to the beginning of lines
numbered_lines([],_,[]).
numbered_lines([H|T], Num, [LH|LT]) :-
    string_concat(Num, " ", NSpace),
    string_concat(NSpace, H, LH),
    NPlus is Num + 1,
    numbered_lines(T, NPlus, LT).

% Adds a line to the ProblemList if it is not valid
problems([],[]).
problems([H|T], [H|ProblemList]) :-
    \+ validate(H),
    problems(T, ProblemList).
problems([_|T], ProblemList) :-
    problems(T, ProblemList).

% true if this is a well-formed package import
validate(Line) :-
    line_number(Line, Num),
    string_concat(Num, " ", Line).
validate(Line) :-
    line_number(Line, Num),
    string_concat(BegLine, EndLine, Line),
    string_concat(Num, " #include <", BegLine),
    !,
    string_concat(_, ">", EndLine).
% true if the given string Line ends with a semicolon, or opens/closes a block
validate(Line) :-
    string_concat(_, "{", Line).
validate(Line) :-
    string_concat(EndBlock, "}", Line),
    !,
    validate(EndBlock).
validate(Line) :-
    string_concat(_, ";", Line).

% return the number from the beginning of this line of code
line_number(Line, Num) :-
    sub_atom(Line, 0, _, _, C),
    atom_number(C, Num),
    number(Num).

% Ensure that all brackets are balanced
% the list Brackets functions as a stack, adding or removing brackets and
% checking that the list is empty at the end of the file
balanced(Code) :-
    atom_chars(Code, CharList),
    balanced(CharList, []).
balanced([],[]).
% Round brackets
balanced([C|S], Brackets) :-
    C = '(',
    !,
    balanced(S, [C|Brackets]).
balanced([C|S], [_|Brackets]) :-
    C = ')',
    !,
    balanced(S, Brackets).
% Curly brackets
balanced([C|S], Brackets) :-
    C = '{',
    !,
    balanced(S, [C|Brackets]).
balanced([C|S], [_|Brackets]) :-
    C = '}',
    !,
    balanced(S, Brackets).
% This character is not a bracket
balanced([C|S], Brackets) :-
    C \= '(',
    C \= ')',
    C \= '{',
    C \= '}',
    balanced(S, Brackets).
