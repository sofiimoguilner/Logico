% vuelo(Codigo de vuelo, capacidad en toneladas, [lista de destinos]).
% Esta lista de destinos está compuesta de la siguiente manera:
% escala(ciudad, tiempo de espera)
% tramo(tiempo en vuelo)

vuelo(ARG845, 30, [escala(rosario,0), tramo(2), escala(buenosAires,0)]).

vuelo(MH101, 95, [escala(kualaLumpur,0), tramo(9), escala(capeTown,2),
tramo(15), escala(buenosAires,0)]).

vuelo(DLH470, 60, [escala(berlin,0), tramo(9), escala(washington,2), tramo(2), escala(nuevaYork,0)]).

vuelo(AAL1803, 250, [escala(nuevaYork,0), tramo(1), escala(washington,2),
tramo(3), escala(ottawa,3), tramo(15), escala(londres,4), tramo(1), escala(paris,0)]).

vuelo(BLE849, 175, [escala(paris,0), tramo(2), escala(berlin,1), tramo(3),
escala(kiev,2), tramo(2), escala(moscu,4), tramo(5), escala(seul,2), tramo(3), escala(tokyo,0)]).

vuelo(NPO556, 150, [escala(kiev,0), tramo(1), escala(moscu,3), tramo(5),
escala(nuevaDelhi,6), tramo(2), escala(hongKong,4), tramo(2), escala(shanghai,5), tramo(3), escala(tokyo,0)]).

vuelo(DSM3450, 75, [escala(santiagoDeChile,0), tramo(1), escala(buenosAires,2), tramo(7), escala(washington,4), 
tramo(15), escala(berlin,3), tramo(15), escala(tokyo,0)]).

% tiempoTotalVuelo/2 : Relaciona un vuelo con el tiempo que lleva en total, contando las esperas en las escalas 
% (y eventualmente en el origen y/o destino) más el tiempo de vuelo.

tiempo(escala(_,Tiempo), Tiempo).
tiempo(tramo(Tiempo, Tiempo)).

tiempoTotalVuelo(Vuelo,TiempoTotal):-
    vuelo(Vuelo, Toneladas, Destinos),
    findall(Tiempo, (member(Idem,Destinos), tiempo(Idem,Tiempo)), ListaTiempos),
    sum_list(ListaTiempos, TiempoTotal).

% escalaAburrida/2 : Relaciona un vuelo con cada una de sus escalas aburridas; 
% una escala es aburrida si hay que esperar mas de 3 horas.

escalasAburridasAux(escala(_,Tiempo)):-
    Tiempo > 3.
escalaAburrida(Vuelo, Escala):-
    vuelo(Vuelo,_, Escalas),
    member(Escala,Escalas),
    escalasAburridasAux(Escala).

% ciudadesAburridas/2 : Relaciona un vuelo con la lista de ciudades de sus escalas aburridas.
 ciudadesAburridas(Vuelo, CiudadesAburridas):-
    vuelo(Vuelo,_,Escalas),
    findall(Ciudad,(member(escala(Ciudad,Tiempo),Escalas),Tiempo>3),CiudadesAburridas).

% vueloLargo/1: Si un vuelo pasa 10 o más horas en el aire, entonces es un vuelo largo. 
% OJO que dice "en el aire", en este punto no hay que contar las esperas en tierra. 
% conectados/2: Relaciona 2 vuelos si tienen al menos una ciudad en común.

vueloLargo(Vuelo):-
    vuelo(Vuelo, _ ,SegmentosEnAire),
    findall(Tiempo, (member(tramo(Tiempo),SegmentosEnAire)), ListaTiempo),
    sum_list(ListaTiempo,TiempoEnAire),
    TiempoEnAire>=10.

conectados(Vuelo1, Vuelo2):-
    vuelo(Vuelo1,_,Destinos1),
    vuelo(Vuelo2,_,Destinos2),
    intersection(Destinos1, Destinos2, CiudadesEnComun),
    CiudadesEnComun \= [].

% bandaDeTres/3: Relaciona 3 vuelos si están conectados, el primero con el segundo, y el segundo con el tercero.

bandaDeTres(Vuelo1,Vuelo2,Vuelo3):-
    conectados(Vuelo1,Vuelo2),
    conectados(Vuelo2,Vuelo3).

% distanciaEnEscalas/3: Relaciona dos ciudades que son escalas del mismo vuelo y 
% la cantidad de escalas entre las mismas; si no hay escalas intermedias la distancia es 1.

distanciaEnEscalas(Ciudad1,Ciudad2, CantEscalas):-
    vuelo(Vuelo,_,Ciudades),
    member(Ciudad1, Ciudades),
    member(Ciudad2, Ciudades),
    nth1(Posicion1,Ciudades,Ciudad1),
    nth1(Posicion2,Ciudades,Ciudad2),
    Distancia is abs(Posicion1-Posicion2),
    CantEscalas is max(1, Distancia).

% vueloLento/1: Un vuelo es lento si no es largo, y además cada escala es aburrida.

vueloLento(Vuelo):-
    vuelo(Vuelo,_,Escalas),
    \+ vueloLargo(Vuelo),
    forall(member(Escala,Escalas), escalaAburrida(Vuelo,Escala)).

    