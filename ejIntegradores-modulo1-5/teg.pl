/* distintos paises */
paisContinente(argentina, americaDelSur).
paisContinente(bolivia, americaDelSur).
paisContinente(brasil, americaDelSur).
paisContinente(chile, americaDelSur).
paisContinente(ecuador, americaDelSur).
paisContinente(alemania, europa).
paisContinente(españa, europa).
paisContinente(francia, europa).
paisContinente(inglaterra, europa).
paisContinente(aral, asia).
paisContinente(china, asia).
paisContinente(gobi, asia).
paisContinente(india, asia).
paisContinente(iran, asia).

/*países importantes*/
paisImportante(argentina).
paisImportante(kamchatka).
paisImportante(alemania).

/*países limítrofes*/
limitrofes([argentina,brasil]).
limitrofes([bolivia,brasil]).
limitrofes([bolivia,argentina]).
limitrofes([argentina,chile]).
limitrofes([españa,francia]).
limitrofes([alemania,francia]).
limitrofes([nepal,india]).
limitrofes([china,india]).
limitrofes([nepal,china]).
limitrofes([afganistan,china]).
limitrofes([iran,afganistan]).

/*distribución en el tablero */
ocupa(argentina, azul, 4).
ocupa(bolivia, rojo, 1).
ocupa(brasil, verde, 4).
ocupa(chile, negro, 3).
ocupa(ecuador, rojo, 2).
ocupa(alemania, azul, 3).
ocupa(españa, azul, 1).
ocupa(francia, azul, 1).
ocupa(inglaterra, azul, 2). 
ocupa(aral, negro, 2).
ocupa(china, verde, 1).
ocupa(gobi, verde, 2).
ocupa(india, rojo, 3).
ocupa(iran, verde, 1).

/*continentes*/
continente(americaDelSur).
continente(europa).
continente(asia).

/*objetivos*/
objetivo(rojo, ocuparContinente(asia)).
objetivo(azul, ocuparPaises([argentina, bolivia, francia, inglaterra, china])).
objetivo(verde, destruirJugador(rojo)).
objetivo(negro, ocuparContinente(europa)).

% estaEnContinente/2: Relaciona un jugador y un continente si el jugador ocupa al 
% menos un país en el continente.

estaEnContinente(Jugador, Continente):-
    ocupa(Pais,Jugador,_),
    paisContinente(Pais,Continente).

% cantidadPaises/2: Relaciona a un jugador con la cantidad de países que ocupa.
 cantidadPaises(Jugaodor, CantPaises):-
    findall(Pais,ocupa(Pais,Jugador,_),Paises),
    length(Paises,CantPaises).

% ocupaContinente/2: Relaciona un jugador y un continente si el jugador ocupa totalmente al continente.

ocupaContinente(Jugador,Continente):-
    continente(Continente).
    forall(
        paisContinente(Pais,Continente),
        ocupa(Pais,Jugador,_)).

% leFaltaMucho/2: Relaciona a un jugador y un continente si al jugador le falta ocupar más de 2 países de dicho continente.

leFaltaMucho(Jugador,Continente):-
    continente(Continente),
    findall(Pais, (paisContinente(Pais,Continente),\+(ocupa(Pais,Jugador,_))),PasisesNoOCupa),
    length(PasisesNoOCupa, Cant),
    Cant > 2.

% sonLimitrofes/2: Relaciona 2 países si son limítrofes.

sonLimitrofes(P1,P2):-
    limitrofes([P1,P2]).
sonLimitrofes(P1,P2):-
    limitrofes([P2,P1]).

% esGroso/1: Un jugador es groso si cumple alguna de estas condiciones:
   % ocupa todos los países importantes,
   % ocupa más de 10 países
   % o tiene más de 50 ejercitos.

esGroso(Jugador):-
    forall(paisImportante(Pais), ocupa(Pais,Jugador,_)).
    
esGroso(Jugador):-
    findall(Pais, ocupa(Pais,Jugador,_),PaisesOcupados),
    length(PaisesOcupados,Cant),
    Cant > 10.
esGroso(Jugador):-
    findall(Ejercito, ocupa(_,Jugador,Ejercito),Ejercitos),
    sum_list(Ejercitos, Suma),
    Suma > 50.

% estaEnElHorno/1: un país está en el horno si todos sus países limítrofes están ocupados 
% por el mismo jugador que no es el mismo que ocupa ese país.

estaEnElHorno(Pais):-
    ocupa(Pais,Jugador,_),
    forall((limitrofes(Pais,P1),  ocupa(Pais,OtroJugador,_)),(OtroJugador\=Jugador)).
    
% esCaotico/1: un continente es caótico si hay más de tres jugadores en él.

esCaotico(Pais):-
    findall(Jugador, ocupa(Pais,Jugador,_),ListaJugadores),
    length(ListaJugadores,Cant),
    Cant > 3.

% capoCannoniere/1: es el jugador que tiene ocupado más países.

capoCannoniere(Jugador):-
    cantidadPaises(Jugador,CantMax),
    forall((cantidadPaises(OtroJugador, OtraCant), Jugador \= OtroJugador),CantMax >= OtraCant).

% ganadooor/1: un jugador es ganador si logro su objetivo 

ganadooor(Jugador):-
    