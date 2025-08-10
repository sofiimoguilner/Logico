progenitor(homero, bart).
progenitor(homero, lisa).
progenitor(homero, maggie).
progenitor(abe, homero).
progenitor(abe, jose).
progenitor(jose, pepe).
progenitor(mona, homero).
progenitor(jacqueline, marge).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(marge, maggie).

%Resolver los predicados hermano, tío, primo y abuelo. 

hermano(Hermano1,Hermano2):- 
    progenitor(Padre,Hermano1), 
    progenitor(Padre,Hermano2),
    Hermano1\=Hermano2.

tio(Sobrino, Tio):-
    progenitor(Padre,Sobrino),
    hermano(Padre,Tio).

primo(Primo1, Primo2):-
    progenitor(Padre1, Primo1),
    progenitor(Padre2, Primo2),
    hermano(Padre1,Padre2).

abuelo(Abuelo, Nieto):-
    progenitor(Abuelo, Padre),
    progenitor(Padre, Nieto).

    