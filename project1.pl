print(X,R) :- R = X.
error([MSG|N], R) :- print([MSG|N],R).

countList([],0).
countList([_|T],R) :- countList(T,R1), R is R1+1.

%% string_concat("is there a line break
%% ", " here?", R).

%% string_concat(R, "
%%  here?", "is there a line break\n here?").

countLn("","",0).
%% countLn(S,R) :- string_concat("\n",R,S).
%% countLn(S,R,C) :- string_concat(R,NL,S), string_concat("\n",_,NL), countLn(NL,_,C1), C is C1+1.
countLn(S,R,C) :- string_concat(R,NL,S), string_concat("\n",_,NL), countLn(NL,_,C1), C is C1+1.
