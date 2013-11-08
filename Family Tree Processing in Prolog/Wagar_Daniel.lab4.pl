% First_name Last_name
% CSCI 305 Lab 4
%consult(`royal.pl').
% A mother is a female parent
mother(M, C):- parent(M, C), female(M).
% A father is a male parent 
father(F, C):- parent(F, C), male(F). 	
% Check both possible orders of married to determine if spouse
spouse(S, O):- married(S, O).		
spouse(S, O):- married(O, S).
% Find the children of a parent
child(C, P):- parent(P, C).
% Find the male children of a parent
son(S, P):- child(S, P), male(S).	
% Find the female children of a parent
daughter(D, P):- child(D, P), female(D).
% Find sibling by seeing if two different people have the same parents
sibling(S, X):- father(F, S), father(F, X), mother(M, S), mother(M, X), S\=X. 
% Find male siblings
brother(B, X):- sibling(B, X), male(B).
% Find female siblings
sister(S, X):- sibling(S, X), female(S).
% Find an aunt by blood, then
% Find aunt by law.  Two possible ways: 
% The first is the wife of a blood uncle
% The other way is by the marriage of a niece/nephew, in which
% case the spouses blood aunt becomes aunt-in-law of co-spouse
aunt(A, N):- parent(X, N), sister(A, X).
aunt(A, N):- parent(X, N), brother(B, X), spouse(A, B).
aunt(A, N):- married(X, N), aunt(A, X).
% Find an uncle by blood, then
% Find uncle by law.  Two possible ways: 
% The first is the husband of a blood aunt
% The other way is by the marriage of a niece/nephew, in which
% case the spouses blood uncle becomes uncle-in-law of co-spouse
uncle(U, N):- parent(X, N), brother(U, X).
uncle(U, N):- parent(X, N), sister(S, X), spouse(U, S).
uncle(U, N):- married(X, N), uncle(U, X).
% Find grandparents, or parents parents.
grandparent(G, C):- parent(X, C), parent(G, X).
% Find male grandparents
grandfather(G, C):- grandparent(G, C), male(G).
% Find female grandparents
grandmother(G, C):- grandparent(G, C), female(G).
% Find grandchildren, or childrens children.
grandchild(C, G):- grandparent(G, C).
% Find direct ancestors, begining with parents.
ancestor(A, D):- parent(A, D).
% Use recursion to find all direct ancestors past parent
ancestor(A, D):- parent(X, D), ancestor(A, X).
% Find direct descendents, begining with children
descendant(D, A):- child(D, A).
% Use recursion to find all direct descendents past children
descendant(D, A):- child(X, A), descendant(D, X).
% Determine if X is older than Y by comparing birth dates
older(X, Y):- born(X, W), born(Y, Z), W < Z. 
% Determine if X is younger than Y by comparing birth dates
younger(X, Y):- born(X, W), born(Y, Z), W > Z.
% Determine who was regent when a person was born by comparing their birth date
% to the dates in which a regent ruled
regentWhenBorn(X, Y):- born(Y, W), reigned(X, A, B), W >= A,  W =< B.
% Find a persons cousins by finding their aunts and uncles 
% (including aunt/uncle by law) children when 
cousin(C, X):- parent(P, C), parent(O, X), sibling(P, O), children(C, P), C\=X.