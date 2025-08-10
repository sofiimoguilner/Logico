%Primer ejemplo: gustos
%Juan gusta de María. Pedro gusta de Ana y de Nora. 
persona(juan).
persona(maria).
persona(pedro).
persona(ana).
persona(nora).
persona(zulema).
persona(julian).
persona(matrio).
persona(luisa).
persona(ana).

gusta(juan,maria).
gusta(pedro,ana).
gusta(pedro,nora).

%Todos los que gustan de Nora gustan de Zulema. 
gusta(Persona, zulema):- gusta(Persona, nora).

%Julián gusta de las morochas y de las chicas con onda. 
gusta(julian, Persona):- morocha(Persona).
gusta(julian, Persona):- tieneOnda(Persona).

%Todos los que gustan de Ana y de Luisa, gustan de Laura. 
gusta(Persona, laura):- gusta(Persona, ana), gusta(Persona, luisa).

%Después cambiar ese "y" por un "o". 
gusta(Persona, laura):-
    (gusta(Persona, ana)
    ;
    gusta(Persona, luisa)).