distancia(buenosAires, puertoMadryn, 1300).
distancia(puertoMadryn, puertoDeseado, 732).
distancia(puertoDeseado, rioGallegos, 736).
distancia(puertoDeseado, calafate, 979).
distancia(rioGallegos, calafate, 304).
distancia(calafate, chalten, 213).

% Calcular los kilómetros de viaje entre dos puntos fácilmente

kilometrosViaje(Origen,Destino,Km):-
    distancia(Origen,Destino,Km).
kilometrosViaje(Origen,Destino,KmTotales):-
    distancia(Origen,PuntoIntermedio,KmPrimeraParte),
    kilometrosViaje(PuntoIntermedio,Destino,KmSegundaParte),
    KmTotales is KmPrimeraParte + KmSegundaParte.

% Estan todos los caminos menos pra calafate - Buenos aires, ya que tengo la base de conocimiento solo para un sentido
% Predicado adicional que cambia el sentido del viaje 

viajeTotal(Origen,Destino,Km):-
    kilometrosViaje(Origen,Destino,Km).
viajeTotal(Origen, Destino, KmTot):-
    kilometrosViaje(Destino, Origen, KmTot).
