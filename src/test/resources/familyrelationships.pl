% Paternal Grandparents's family
male(robert).
male(michael).
female(jennifer).
female(elizabeth).

% Father's family
male(james).
male(user).
male(john).
female(mary).
female(patricia).

% User's family
male(william).
female(neha).
female(linda).

% Sister's family
male(david).
male(richard).
female(susan).

% Maternal Grandparents's family
male(joseph).
male(charles).
female(sarah).
female(nancy).

% Brother's family
male(daniel).
female(lisa).
female(donna).

% Son's family
male(kevin).
female(rita).
female(emily).

% Paternal Grandparents's family
spouse(robert, jennifer).

% Father's family
spouse(james, mary).

% User's family
spouse(user, neha).

% Sister's family
spouse(patricia, david).

% Maternal Grandparent's family
spouse(joseph, sarah).

% Brother's family
spouse(john, lisa).

% Son's family
spouse(william, rita).

% Grandparents's family
parent(robert, jennifer, james).
parent(robert, jennifer, michael).
parent(robert, jennifer, elizabeth).

% Father's family
parent(james, mary, user).
parent(james, mary, john).
parent(james, mary, patricia).

% User's family
parent(user, neha, william).
parent(user, neha, linda).

% Sister's family
parent(david, patricia, richard).
parent(david, patricia, susan).

% Maternal Grandparent's family
parent(joseph, sarah, charles).
parent(joseph, sarah, nancy).
parent(joseph, sarah, mary).

% Brother's family
parent(john, lisa, daniel).
parent(john, lisa, donna).

% Son's family
parent(william, rita, kevin).
parent(william, rita, emily).

% RULES

husband(Husband, Woman) :- male(Husband), spouse(Husband, Woman); male(Husband), spouse(Woman, Husband).
wife(Wife, Man) :- female(Wife), spouse(Wife, Man); female(Wife), spouse(Man, Wife).

father(Father, Child) :- male(Father), parent(Father, _, Child).
mother(Mother, Child) :- female(Mother), parent(_, Mother, Child).

son(Son, Parent) :-
    male(Parent), son(Son, Parent, _);
    female(Parent), son(Son, _, Parent).
son(Son, Father, Mother) :- male(Son), parent(Father, Mother, Son).
daughter(Daughter, Parent) :-
    male(Parent), daughter(Daughter, Parent, _);
    female(Parent), daughter(Daughter, _, Parent).
daughter(Daughter, Father, Mother) :- female(Daughter), parent(Father, Mother, Daughter).

sister(Sister, Y) :-
    female(Sister), parent(Father, Mother, Sister), parent(Father, Mother, Y), Sister \= Y.
brother(Brother, Y) :-
    male(Brother), parent(Father, Mother, Brother), parent(Father, Mother, Y), Brother \= Y.

father_in_law(FIL, Y) :- male(FIL), spouse(Spouse, Y), parent(FIL, _, Spouse);
                         male(FIL), spouse(Y, Spouse), parent(FIL, _, Spouse).
mother_in_law(MIL, Y) :- female(MIL), spouse(Spouse, Y), parent(_, MIL, Spouse);
                         female(MIL), spouse(Y, Spouse), parent(_, MIL, Spouse).

son_in_law(SIL, PIL) :-
    male(PIL), son_in_law(SIL, PIL, _);
    female(PIL), son_in_law(SIL, _, PIL).
son_in_law(SIL, Father, Mother) :- male(SIL), spouse(Daughter, SIL), parent(Father, Mother, Daughter);
                                   male(SIL), spouse(SIL, Daughter), parent(Father, Mother, Daughter).
daughter_in_law(DIL, PIL) :-
    male(PIL), daughter_in_law(DIL, PIL, _);
    female(PIL), daughter_in_law(DIL, _, PIL).
daughter_in_law(DIL, Father, Mother) :- female(DIL), spouse(Son, DIL), parent(Father, Mother, Son);
                                        female(DIL), spouse(DIL, Son), parent(Father, Mother, Son).

pota(Grandson, Grandparent) :-
    male(Grandparent), pota(Grandson, Grandparent, _);
    female(Grandparent), pota(Grandson, _, Grandparent).
pota(Grandson, Grandfather, Grandmother) :-
    parent(Grandfather, Grandmother, Son), son(Grandson, Son, _).
poti(Granddaughter, Grandparent) :-
    male(Grandparent), poti(Granddaughter, Grandparent, _);
    female(Grandparent), poti(Granddaughter, _, Grandparent).
poti(Granddaughter, Grandfather, Grandmother) :-
    parent(Grandfather, Grandmother, Son), daughter(Granddaughter, Son, _).

paternal_grandfather(Grandfather, Y) :-
    father(Father, Y), father(Grandfather, Father).
paternal_grandmother(Grandmother, Y) :-
    father(Father, Y), mother(Grandmother, Father).

maternal_grandfather(Grandfather, Y) :-
    mother(Mother, Y), father(Grandfather, Mother).
maternal_grandmother(Grandmother, Y) :-
    mother(Mother, Y), mother(Grandmother, Mother).

grandfather(Grandfather, Grandchild) :-
    paternal_grandfather(Grandfather, Grandchild);
    maternal_grandfather(Grandfather, Grandchild).
grandmother(Grandmother, Grandchild) :-
    paternal_grandmother(Grandmother, Grandchild);
    maternal_grandmother(Grandmother, Grandchild).

navaasa(Grandson, Grandparent) :-
    male(Grandparent), navaasa(Grandson, Grandparent, _);
    female(Grandparent), navaasa(Grandson, _, Grandparent).
navaasa(Grandson, Grandfather, Grandmother) :-
    parent(Grandfather, Grandmother, Daughter), mother(Daughter, Grandson), male(Grandson).
navaasi(Granddaughter, Grandparent) :-
    male(Grandparent), navaasi(Granddaughter, Grandparent, _);
    female(Grandparent), navaasi(Granddaughter, _, Grandparent).
navaasi(Granddaughter, Grandfather, Grandmother) :-
    parent(Grandfather, Grandmother, Daughter), mother(Daughter, Granddaughter), female(Granddaughter).

grandson(Grandson, Grandparent) :-
    pota(Grandson, Grandparent);
    navaasa(Grandson, Grandparent).
granddaughter(Granddaughter, Grandparent) :-
    poti(Granddaughter, Grandparent);
    navaasi(Granddaughter, Grandparent).


% Bhabhi = Brother's wife
bhabhi(Bhabhi, Y) :- brother(Brother, Y), female(Bhabhi), spouse(Bhabhi, Brother);
                     brother(Brother, Y), female(Bhabhi), spouse(Brother, Bhabhi).

% Jija = Sister's husband
jija(JijaJi, Y) :- sister(Sister, Y), husband(JijaJi, Sister).

sister_in_law(SIL, Y) :- spouse(X, Y), sister(SIL, X);
                         spouse(Y, X), sister(SIL, X).
brother_in_law(BIL, Y) :- spouse(X, Y), brother(BIL, X);
                          spouse(Y, X), brother(BIL, X).

% chacha = Father's brother
% chachi = chacha's wife
chacha(Chacha, Y) :- father(Father, Y), brother(Chacha, Father).
chachi(Chachi, Y) :- chacha(Chacha, Y), wife(Chachi, Chacha).

% Bua = Father's sister
% Phupha = linda's husband
bua(Bua, Y) :- father(Father, Y), sister(Bua, Father).
phupha(Phupha, Y) :- bua(Bua, Y), husband(Phupha, Bua).

% maama = Mother's brother
% maami = maama's wife
maama(Maama, Y) :- mother(Mother, Y), brother(Maama, Mother).
maami(Maami, Y) :- maama(Maama, Y), wife(Maami, Maama).

% Mausii = Mother's sister
% Mausaa = Mausii's Husband
mausii(Mausii, Y) :- mother(Mother, Y), sister(Mausii, Mother).
mausaa(Mausaa, Y) :- mausii(Mausii, Y), husband(Mausaa, Mausii).

% Bhatijaa, Bhanja = Nephew
% Bhatiiji, Bhanji = Niece
bhatija(Nephew, Y) :- brother(Brother, Y), son(Nephew, Brother, _).
bhatiji(Bhatiiji, Y) :- brother(Brother, Y), daughter(Bhatiiji, Brother, _).
bhanja(Bhanja, Y) :- sister(Sister, Y), son(Bhanja, _, Sister).
bhanji(Bhanji, Y) :- sister(Sister, Y), daughter(Bhanji, _, Sister).

find_relation(Relation, X, Y) :-
    member(Relation, [husband, wife, father, mother, son, daughter, sister, brother,
                father_in_law, mother_in_law, son_in_law, daughter_in_law,
                pota, poti, paternal_grandfather,
                paternal_grandmother, maternal_grandfather, maternal_grandmother,
                navaasa, navaasi, bhabhi, jija,
                sister_in_law, brother_in_law, chacha, chachi, bua, phupha, maama,
                maami, mausii, mausaa, bhatija, bhatiji, bhanja, bhanji]),
    call(Relation, X, Y).