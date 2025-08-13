
puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).

% Qué puntaje obtuvo un competidor en un salto

puntaje(Persona,Salto,ValorSaltos):-
    puntajes(Persona, ListaSaltos),
    nth1(Salto,ListaSaltos,ValorSalto).

% Si un competidor está descalificado o no. Un competidor está descalificado si hizo más de 5 saltos.

descalificado(Persona, CantSaltos):-
    puntajes(Persona,ListaSaltos),
    length(ListaSaltos, Cantidad),
    Cantidad > 5.

% Si un competidor clasifica a la final. Un competidor clasifica a la final si la suma de sus puntajes 
% es mayor o igual a 28, o si tiene dos saltos de 8 o más puntos.

clasifica(Persona):-
    puntajes(Persona, ListaSaltos),
    sum_list(Lista, Suma),
    Suma>= 28.

salto_alto_auxiliar(Salto):-
    Salto >= 8.

clasifica(Persona):-
    puntajes(Persona, ListaSaltos),
    include(salto_alto_auxiliar, ListaSaltos, SaltosAltos),
    length(SaltosAltos, Cant),
    Cant >=2 .
    
    