% natacion: estilos (lista), metros nadados, medallas
practica(ana, natacion([pecho, crawl], 1200, 10)). 
practica(luis, natacion([perrito], 200, 0)).
practica(vicky, 
   natacion([crawl, mariposa, pecho, espalda], 800, 0)).
% fútbol: medallas, goles marcados, veces que fue expulsado
practica(deby, futbol(2, 15, 5)).
practica(mati, futbol(1, 11, 7)).
% rugby: posición que ocupa, medallas
practica(zaffa, rugby(pilar, 0)).

%quienes son los nadadores 
nadador(Quien):-practica(Quien, natacion(_,_,_)).

%Medallas obtenidas
medallas(Alguien,Medallas):-
    practica(Alguien,Deporte),
    cuantasMedallas(Deporte,Medallas).

 %trabajo con pattern matching en base a cada functor
cuantasMedallas(natacion(_,_,Medallas),Medallas).
cuantasMedallas(futbol(Medallas,_,_),Medallas).
cuantasMedallas(rugby(_,Medallas),Medallas).

% El predicado medallas es inversible pq practica funciona como generador

%Buen deportista
buenDeportista(Alguien):-
    practica(Alguien, Deporte), esBueno(Deporte).
%usa pattern matching
esBueno(natacion(Estilos,_,_)):-
    length(Estilos, CantidadEstilos), CantidadEstilos > 3.
esBueno(natacion(_,metros,_)):-metros > 1000.
esBueno(futbol(_,Goles,Expulsiones)):-
    Valor is Goles - Expulsiones, Valor > 5.
esBueno(rugby(pilar,_)).
esBueno(rugby(wing,_)).