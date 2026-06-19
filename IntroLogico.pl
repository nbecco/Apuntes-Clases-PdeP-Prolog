% juegaEn/2 -> Equipo y Jugador
% relacion
juegaEn(argentina, messi).
juegaEn(argentina, paredes).
juegaEn(argentina, alvarez).
juegaEn(uruguay, vinia).
juegaEn(argentina, dePaul).
juegaEn(colombia, quinteros).
juegaEn(inter, messi).
juegaEn(inter, dePaul).


% propiedad
jugadorComoPropiedad(messi).



/*
¿Messi juega en Argentina?
juegaEn(argentina, messi). 

¿Qué jugadores juegan en Argentina?
juegaEn(argentina, Jugador). 

¿En qué equipos juega Messi?
juegaEn(Equipo, messi).

¿Qué equipos tienen a qué jugadores?
juegaEn(Equipo, Jugador).

¿Algún equipo tiene a Messi?
juegaEn(_, messi).

¿Algún jugador juega en Argentina? 
juegaEn(argentina, _).

¿Qué equipos existen?
juegaEn(Equipo, _).

¿Qué jugadores existen?
juegaEn(_, Jugador).

¿Alguien juega en algún equipo?
juegaEn(_,_).

¿Juega en Argentina Pepita?
juegaEn(argentina, pepita).
*/

%ganoMundial/2 -> Equipo y Año

ganoMundial(argentina, 2022).
ganoMundial(uruguay, 1950).

jugador(Jugador):-
    juegaEn(_, Jugador).

%fueCampeon/1 -> Jugador 
fueCampeon(Jugador):-
    juegaEn(Equipo, Jugador),
    ganoMundial(Equipo,_).

%esCrack/1 -> Jugador
esCrack(Jugador):-
    juegaEn(argentina, Jugador),
    juegaEn(inter, Jugador).
esCrack(messi).


%partidos/2 -> Jugador, Partidos
partidos(messi, 1140).
partidos(pepita, 1).

%goles/2 -> Jugador, Goles
goles(messi, 900).
goles(pepita, 7).

%esValioso/1 -> Jugador
esValioso(Jugador):-
    tieneMasGolesQuePartidos(Jugador).

esValioso(Jugador):-
    comparteClub(Jugador, JugadorCrack),
    esCrack(JugadorCrack).

tieneMasGolesQuePartidos(Jugador):-
    goles(Jugador, Goles),
    partidos(Jugador, Partidos),
    Goles > Partidos.

comparteClub(UnJugador, OtroJugador):-
    juegaEn(Equipo, UnJugador),
    juegaEn(Equipo, OtroJugador).