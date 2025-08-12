tiene(juan, foto([juan, hugo, pedro, lorena, laura], 1988)).
tiene(juan, foto([juan], 1977)).
tiene(juan, libro(saramago, "Ensayo sobre la ceguera")).
tiene(juan, bebida(whisky)).
tiene(valeria, libro(borges, "Ficciones")).
tiene(lucas, bebida(cusenier)).
tiene(pedro, foto([juan, hugo, pedro, lorena, laura], 1988)).
tiene(pedro, foto([pedro], 2010)).
tiene(pedro, libro(octavioPaz, "Salamandra")).
 
premioNobel(octavioPaz).
premioNobel(saramago).

% Determinamos que alguien es coleccionista si todos los elementos que tiene son valiosos:
% un libro de un premio Nobel es valioso
% una foto con más de 3 integrantes es valiosa
% una foto anterior a 1990 es valiosa
% el whisky es valioso

coleccionista(Persona):-
    tiene(Persona,_),
    forall(tiene(Persona,Cosa),valor(Cosa)).

valor(foto(Gente,_)):-
    length(Gente,Cantidad), Cantidad > 3.
valor(foto(_,Anio)):-
    Anio < 1990.
valor(libro(Escritor,_)):-
    premioNobel(Escritor).
valor(bebida(whisky)).

