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

%verifique si puedo enchufar P1 a la izquierda de P2. 
%Puedo enchufar dos piezas si son del mismo color, o si son de colores enchufables. 
%Las piezas azules pueden enchufarse a la izquierda de las rojas, y las rojas pueden enchufarse a la izquierda de las negras. 
%Las azules no se pueden enchufar a la izquierda de las negras, tiene que haber una roja en el medio.

coloresEnchufables(Color,Color).
coloresEnchufables(azul,rojo).
coloresEnchufables(rojo,negro).

color(canio(Color,_),Color).
color(codo(Color),Color).
color(canilla(_,Color,_),Color).
color(extremo(Color,_),Color).

puedoEnchufar(P1,P2):-
    color(PiezaIzquirda, ColorDerecho),
    color(PiezaDerecha,ColorIzquierdo),
    PiezaDerecha \= extremo(_,izquierda),
    PiezaIzquirda \= extremo(_,derecha),
    coloresEnchufables(ColorIzquierdo,ColorDerecho).
