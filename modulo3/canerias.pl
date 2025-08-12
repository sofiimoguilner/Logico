%Una cañeria es una lista de piezas
%De los codos me interesa el color, p.ej. un codo rojo.
%codo(rojo).
%De los caños me interesan color y longitud, p.ej. un caño rojo de 3 metros.
%canio(rojo,3).
%De las canillas me interesan: tipo (de la pieza que se gira para abrir/cerrar), color y ancho (de la boca). 
%P.ej. una canilla triangular roja de 4 cm de ancho.
%canilla(triangular,roja, 4).

precio([],0). %inicializo la lista vacia
precio([Pieza | Piezas], Precio):-
    precio(Pieza,PrecioPieza),
    precio(Piezas,PrecioResto),
    Precio is PrecioPieza + PrecioResto.

precio(canio(_,Metros),Precio):-
    Precio is 3*Metros.

precio(codo(_),Precio):-
    Precio is 5.

precio(canilla(triangular,_,_),Precio):-
    Precio is 20.
precio(canilla(Tipo,_,Ancho),Precio):-
    Tipo \= triangular,
    Ancho <5,
    Precio is 12.
precio(canilla(Tipo,_,Ancho),Precio):-
    Tipo \= triangular,
    Ancho >5,
    Precio is 15.

% 2) Verifique si puedo enchufar P1 a la izquierda de P2. 
% Puedo enchufar dos piezas si son del mismo color, o si son de colores enchufables. 
% Las piezas azules pueden enchufarse a la izquierda de las rojas, y las rojas pueden enchufarse a la izquierda de las negras. 
% Las azules no se pueden enchufar a la izquierda de las negras, tiene que haber una roja en el medio.

coloresEnchufables(Color,Color).
coloresEnchufables(azul,rojo).
coloresEnchufables(rojo,negro).

color(canio(Color,_),Color).
color(codo(Color),Color).
color(canilla(_,Color,_),Color).
color(extremo(Color,_),Color).

puedoEnchufar(PiezaIzq,PiezaDerecha):-
    color(PiezaIz, ColorDerecho), %punto 2
    color(PiezaDerecha,ColorIzquierdo), %punto 2
    PiezaDerecha \= extremo(_,izquierda), %punto 5
    PiezaIzquirda \= extremo(_,derecha), %punto 5

    coloresEnchufables(ColorIzquierdo,ColorDerecho).

% 3)Modificar el predicado puedoEnchufar/2 de forma tal que pueda preguntar por elementos sueltos o por cañerías ya armadas. 
% P.ej. una cañería (codo azul, canilla roja) la puedo enchufar a la izquierda de un codo rojo (o negro), 
% y a la derecha de un caño azul. 
% Ayuda: si tengo una cañería a la izquierda, ¿qué color tengo que mirar? Idem si tengo una cañería a la derecha.

puedoEnchufar(Caneria, PiezaOcaneria):-
    last(Caneria, PiezaIzq),
    puedoEnchufar(PiezaIzq, PiezaOcaneria).
puedoEnchufar(PiezaOcaneria,[PiezaDerecha|_]):-
    puedoEnchufar(PiezaOcaneria, PiezaDerecha).

% 4)Definir un predicado canieriaBienArmada/1, que nos indique si una cañería está bien armada o no. 
% Una cañería está bien armada si a cada elemento lo puedo enchufar al inmediato siguiente, 
% de acuerdo a lo indicado al definir el predicado puedoEnchufar

canieriaBienArmada([]). % Una lista con solo un elemento siempre está "bien armada" porque no tiene nada con qué conectarse
% Recursivo
canieriaBienArmada([PiezaIzq,PiezaDerecha | Piezas]):-
    puedoEnchufar(PiezaDerecha,PiezaIzq) , % Comprueba si la pieza actual puede conectarse con la siguiente usando la regla que ya definiste.
    canieriaBienArmada([PiezaDerecha | Piezas]). % Llama recursivamente para seguir revisando el resto de la cañería, empezando ahora en PiezaDerecha.

% 5)Modificar el predicado puedoEnchufar/2 para tener en cuenta los extremos, que son piezas que se agregan a las posibilidades.
% De los extremos me interesa de qué punta son (izquierdo o derecho), y el color, p.ej. un extremo izquierdo rojo. 
% Un extremo derecho no puede estar a la izquierda de nada, mientras que un extremo izquierdo no puede estar a la derecha de nada. 
% Verificar que canieriaBienArmada/1 sigue funcionando. 
%Ayuda: resolverlo primero sin listas, y después agregar las listas. 
%Lo de las listas sale en forma análoga a lo que ya hicieron, ¿en qué me tengo que fijar para una lista si la pongo a la izquierda o a la derecha?.  

% Modificar el predicado canieriaBienArmada/1 para que acepte cañerías formadas por elementos y/u otras cañerías. 
% P.ej. una cañería así: codo azul, [codo rojo, codo negro], codo negro  se considera bien armada.

%7
canieriasLegales([Pieza], [Pieza]).
canieriasLegales(Piezas, [Pieza | CanieriaLegal]):-
    select(Pieza, Piezas, RestoPiezas),
    canieriasLegales(RestoPiezas, CanieriaLegal),
    canieriaBienArmada([Pieza | CanieriaLegal]).