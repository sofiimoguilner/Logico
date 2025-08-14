% vuelo(Codigo de vuelo, capacidad en toneladas, [lista de destinos]).
% Esta lista de destinos está compuesta de la siguiente manera:
% escala(ciudad, tiempo de espera)
% tramo(tiempo en vuelo)

vuelo(ARG845, 30, [escala(rosario,0), tramo(2), escala(buenosAires,0)]).

vuelo(MH101, 95, [escala(kualaLumpur,0), tramo(9), escala(capeTown,2),
tramo(15), escala(buenosAires,0)]).

vuelo(DLH470, 60, [escala(berlin,0), tramo(9), escala(washington,2), tramo(2), escala(nuevaYork,0)]).

vuelo(AAL1803, 250, [escala(nuevaYork,0), tramo(1), escala(washington,2),
tramo(3), escala(ottawa,3), tramo(15), escala(londres,4), tramo(1),escala(paris,0)]).

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
    
    