% puedeCumplir(Persona, Rol): relaciona una persona con un rol que puede cumplir
puedeCumplir(jorge, instrumentista(guitarra)).
puedeCumplir(daniel, instrumentista(guitarra)).
puedeCumplir(daniel, actor(narrador)).
puedeCumplir(daniel, instrumentista(tuba)).
puedeCumplir(daniel, actor(paciente)).
puedeCumplir(marcos, actor(narrador)).
puedeCumplir(marcos, actor(psicologo)).
puedeCumplir(marcos, instrumentista(percusion)).
puedeCumplir(daniel, instrumentista(percusion)).
puedeCumplir(carlos, instrumentista(violin)).
puedeCumplir(carlitos, instrumentista(piano)).
puedeCumplir(daniel, actor(canto)).
puedeCumplir(carlos, actor(canto)).
puedeCumplir(carlitos, actor(canto)).
puedeCumplir(marcos, actor(canto)).
puedeCumplir(jorge, actor(canto)).
puedeCumplir(jorge, instrumentista(bolarmonio)).

%necesita(Sketch, Rol): relaciona un sketch con un rol necesario para interpretarlo.
necesita(payadaDeLaVaca, instrumentista(guitarra)).
necesita(malPuntuado, actor(narrador)).
necesita(laBellaYGraciosaMozaMarchoseALavarLaRopa, actor(canto)).
necesita(laBellaYGraciosaMozaMarchoseALavarLaRopa, instrumentista(violin)).
necesita(laBellaYGraciosaMozaMarchoseALavarLaRopa, instrumentista(tuba)).
necesita(lutherapia, actor(paciente)).
necesita(lutherapia, actor(psicologo)).
necesita(cantataDelAdelantadoDonRodrigoDiazDeCarreras, actor(narrador)).
necesita(cantataDelAdelantadoDonRodrigoDiazDeCarreras, instrumentista(percusion)).
necesita(cantataDelAdelantadoDonRodrigoDiazDeCarreras, actor(canto)).
necesita(rhapsodyInBalls, instrumentista(bolarmonio)).
necesita(rhapsodyInBalls, instrumentista(piano)).

% duracion(Sketch, Duracion):. relaciona un sketch con la duración (aproximada, pero la vamos a tomar como fija) que se necesita para interpretarlo.
duracion(payadaDeLaVaca, 9).
duracion(malPuntuado, 6).
duracion(laBellaYGraciosaMozaMarchoseALavarLaRopa, 8).
duracion(lutherapia, 15).
duracion(cantataDelAdelantadoDonRodrigoDiazDeCarreras, 17).
duracion(rhapsodyInBalls, 7).

% Necesitamos programar interprete/2, que relacione a una persona con un sketch en el que puede participar. 
% Inversible.

interprete(Persona,Sketch):-
    necesita(Sketch,Rol),
    puedeCumplir(Persona,Rol).

% Se precisa la relación duracionTotal/2, que relacione una lista de 
% sketches con la duración total que tomaría realizarlos a todos. 
% Inversible para la duración.

duracionTotal(Sketches, DuracionTotal):-
    maplist(duracion, Sketches,ListaDuracion),
    sum_list(ListaDuracion, DuracionTotal).

% Saber si un sketch puede ser interpretado por un conjunto de intérpretes. 
% Esto sucede cuando en ese conjunto disponemos de intérpretes que cubren todos los roles 
% necesarios para el mencionado sketch.
% Inversible para el sketch.

interpretado(Sketch,Personas):-
    forall(
        necesita(Sketch,Rol),
        (member(Persona,Personas),puedeCumplir(Persona,Rol))
        ).

% Hacer generarShow/3 que relacione: 
%   Un conjunto de posibles intérpretes.
%   Una duración máxima del show.
%   Una lista de sketches no vacía (un show), que deben poder ser interpretados por los intérpretes y durar menos que la duración máxima.
%   Inversible para el show.

generarShow(Personas,DurancionMaxima,Show):-
    sketchesCandidatos(Personas,Sketches), % Obtiene lista de todos los sketches que estos intérpretes pueden realizar
    subconjunto(Sketches,Show), % Genera todas las combinaciones posibles
    Show \= [], % Condicion de consigna
    duracionTotal(Sketches,DuracionTotal),
    DuracionTotal < DurancionMaxima.

sketchesCandidatos(Personas,Sketches):-
    findall(Sketch,interpretado(Sketch,Personas),Sketches).

subconjunto(_, []). % la lista vacía es un subconjunto de cualquier conjunto
subconjunto(Conjunto, [Elemento | Subconjunto]):-
    select(Elemento, Conjunto, Resto),
    subconjunto(Resto, Subconjunto).

% Los shows, muchas veces tienen algún participante estrella; 
% que es aquel que puede participar en todos los sketchs que componen dicho show. 
% Implementar un predicado que relacione a un show con un participante estrella.
% Inversible para la estrella

participanteEstrella(Show, ParticipnteEstrella):-
    forall(member(Sketch,Sketches), interprete(Sketches,ParticipnteEstrella)).

% Es puramenteMusical/1. Esto sucede cuando en todos los sketches, sólo se precisan roles de instrumentista.

puramenteMusical(Sketches):-
    forall(member(Sketch,Sketchesl),
           forall(necesita(Sketch,Rol), instrumentista(Rol))
           ).
    