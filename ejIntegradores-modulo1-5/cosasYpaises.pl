
% buscar(Cosa,Ciudad), y definimos el predicado tarea/2
tarea(basico,buscar(libro,jartum)).
tarea(basico,buscar(arbol,patras)).
tarea(basico,buscar(roca,telaviv)).
tarea(intermedio,buscar(arbol,sofia)).
tarea(intermedio,buscar(arbol,bucarest)).
tarea(avanzado,buscar(perro,bari)).
tarea(avanzado,buscar(flor,belgrado)).

% Para definir en qué nivel está cada participante se define el predicado nivelActual/2
nivelActual(pepe,basico).
nivelActual(lucy,intermedio).
nivelActual(juancho,avanzado).

% qué idioma se habla en cada ciudad, qué idiomas habla cada persona, y el capital actual de cada persona. 
% Esto lo representamos con los predicados idioma/2, habla/2 y capital/2:

idioma(alejandria,arabe).
idioma(jartum,arabe).
idioma(patras,griego).
idioma(telaviv,hebreo).
idioma(sofia,bulgaro).
idioma(bari,italiano).
idioma(bucarest,rumano).
idioma(belgrado,serbio).

habla(pepe,bulgaro).
habla(pepe,griego).
habla(pepe,italiano).
habla(juancho,arabe).
habla(juancho,griego).
habla(juancho,hebreo).
habla(lucy,griego).

capital(pepe,1200).
capital(lucy,3000).
capital(juancho,500).

% destinoPosible/2 e idiomaUtil/2.
% destinoPosible/2 relaciona personas con ciudades; una ciudad es destino posible para un nivel si alguna 
% tarea que tiene que hacer la persona (dado su nivel) se lleva a cabo en la ciudad. P.ej. los destinos posibles 
% para Pepe son: Jartum, Patras y Tel Aviv.
% idiomaUtil/2 relaciona niveles con idiomas: un idioma es útil para un 
% nivel si en alguno de los destinos posibles para el nivel se habla el idioma. 
% P.ej. los idiomas útiles para Pepe son: árabe, griego y hebreo.

destinoPosible(Persona, Ciudades):-
    nivelActual(Persona, Nivel),
    tarea(Nivel, buscar(_,Ciudades)).

idiomaUtil(Nivel, Idioma):-
    tarea(Nivel, bucar(_,Ciudad)),
    idioma(Ciudad,Idioma).

% excelenteCompaniero/2, que relaciona dos participantes. 
% P2 es un excelente compañero para P1 si habla los idiomas de todos los destinos 
% posibles del nivel donde está P1. P.ej. Juancho es un excelente compañero para Pepe, 
% porque habla todos los idiomas de los destinos posibles para el nivel de Pepe.
% Asegurar que el predicado sea inversible para los dos parámetros. 

excelenteCompaniero(Participante1, Participante2):-
    Participante1 \= Participante2,
    nivelActual(Participante1, Nivel),
    forall((tarea(Nivel,buscar(_,Ciudades)),idioma(Ciudad, Idioma)), %todos los idiomas que necesita el Participante 1
     habla(Participante2,Idioma)). % Exige que Participante2 hable todos los idiomas

% interesante/1: un nivel es interesante si se cumple alguna de estas condiciones
% todas las cosas posibles para buscar en ese nivel están vivas (las cosas vivas en el ejemplo son: árbol, perro y flor)
% en alguno de los destinos posibles para el nivel se habla italiano.
% la suma del capital de los participantes de ese nivel es mayor a 10000
% Asegurar que el predicado sea inversible.

cosaViva(arbol).
cosaViva(perro).
cosaViva(flor).
interesante(Nivel):-
    forall(tarea(Nivel,buscar(Cosa,_)), cosaViva(Cosa)).
interesante(Nivel):-
    tarea(Nivel, bucar(_,Ciudad)),
    idioma(Ciudad,italiano).
interesante(Nivel):-
    findall(Capital, (nivelActual(Persona,Nivel),capital(Persona,Capital)), Capitales),
    sum_list(Capitales, Suma),
    Suma > 10000.

% complicado/1: un participante está complicado si: no habla ninguno de los idiomas de los destinos posibles 
% para su nivel actual; está en un nivel distinto de básico y su capital es menor a 1500, o está en el nivel 
% básico y su capital es menor a 500.

noHablaNingunIdioma(Participante):-
    nivelActual(Participante,Nivel),
    forall(
     (tarea(Nivel,buscar(_,Ciudad)), idioma(Ciudad,Idioma)), 
     \+(habla(Participante,Idioma))
     ).

capitalNoTieneValor(Participante):-
    nivelActual(Participante, basico),
    capital(Participante,Valor),
    Valor < 500.
capitalNoTieneValor(Participante):-
    nivelActual(Participante, Nivel),
    Nivel \= basico,
    capital(Participante,Valor),
    Valor < 1500.

complicado(Participante):-
    noHablaNingunIdioma(Participante),
    capitalNoTieneValor(Participante).

% homogeneo/1: un nivel es homogéneo si en todas las opciones la cosa a buscar es la misma. 
% En el ejemplo, el nivel intermedio es homogéneo, porque en las dos opciones el objeto a buscar es un árbol. 
% Asegurar que el predicado sea inversible. 

homogeneo(Nivel):-
    tarea(Nivel, buscar(Cosa,_)),
    forall(tarea(Nivel, buscar(OtraCosa,_)), OtraCosa = Cosa).

% poliglota/1: una persona es políglota si habla al menos tres idiomas. En general: es válido agregar los 
% predicados necesarios para poder garantizar inversibilidad o auxiliares para resolver cada ítem, 
% y usar en un ítem los predicados definidos para resolver ítems anteriores. 

poliglota(Participante):-
    findall(Idioma, habla(Persona, Idioma), Idiomas),
    sort(Idiomas, IdiomasUnicos),  % elimina duplicados
    length(IdiomasUnicos, Cantidad),
    Cantidad >= 3.