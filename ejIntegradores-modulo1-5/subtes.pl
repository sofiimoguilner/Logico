
linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).

combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).

% En qué linea está una estación, predicado estaEn/2.

entanEn(Linea, Estacion):-
    linea(Linea , Estaciones),
    member(Estacion, Estaciones).

% dadas dos estaciones de la misma línea, cuántas estaciones hay entre ellas, 
%p.ej. entre Perú y Primera Junta hay 5 estaciones. 
%Predicado distancia/3 (relaciona las dos estaciones y la distancia).

distancia(Estacion1,Estacion2,Distancia):-
    linea(_,Estaciones),
    nth1(Posicion1, Estaciones, Estacion1),
    nth1(Posicion2, Estaciones, Estacion2),
    Distancia is abs(Posicion1 - Posicion2). %abs me permite q la resta sea siempre 1

% Dadas dos estaciones de distintas líneas, si están a la misma altura (o sea, las dos terceras, 
% las dos quintas, etc.), p.ej. Independencia C y Jujuy que están las dos cuartas. Predicado mismaAltura/2.

mismaAltura(Estacion1, Estacion2):-
    linea(Linea1, Estaciones1),
    linea(Linea2, Estaciones2),
    Linea1 \= Linea2,
    nth1(Posicion1, Estaciones, Estacion1),
    nth1(Posicion2, Estaciones, Estacion2),
    Posicion1 =:= Posicion2.
% Dadas dos estaciones, si puedo llegar fácil de una a la otra, esto es, 
% si están en la misma línea, o bien puedo llegar con una sola combinación. Predicado viajeFacil/2.
viajeFacil(E1,E2):-
    entanEn(L1, E1),
    entanEn(L2,E2),
    L1 == L2.

viajeFacil(E1,E2):-
    entanEn(L1, E1),
    entanEn(L2,E2),
    L1 \= L2,
    combinacion(E1,E2).
