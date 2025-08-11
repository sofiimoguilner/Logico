
% Como se lee: ancestro es mi padre o bien el ancestro de mi papá
ancestro(Ancestro,Padre):-
    padre(Padre,Persona),
    ancestro(Ancestro,Padre).

