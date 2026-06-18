% TERMINOS QUE VIMOS HOY:
% forall/2 : es un cuantificador universal, se usa para expresar que una propiedad es cierta para todos los elementos de un conjunto. Por ejemplo, si queremos decir que todos los campeones son peligrosos, podríamos escribir forall(Campeon, esPeligroso(Campeon)). Ademas todo forall se puede definir usando 'not'.
% unificacion : es el proceso de encontrar una sustitucion de variables que hace que dos terminos sean iguales. Por ejemplo, si tenemos el termino padre(X, Y) y el termino padre(juan, maria), la unificacion nos diria que X=juan e Y=maria.
% inversibilidad : un predicado es inversible si se puede usar para generar informacion, no solo para validar informacion ya existente.
% is : es equivalente a el igual (=).
% findall(Template, Goal, Bag) : es un predicado que se usa para generar una lista con todos los resultados de una consulta. Por ejemplo, si queremos obtener una lista con todos los campeones que son tanques, podríamos escribir findall(Campeon, esTanque(Campeon), CamponesTanques). SE UTILIZA SOLO EN CASOS EXTREMOS.
% sumlist(ListaNumeros, Resultado)
% length (Valores, Resultado)


%1
rol(maestroYi, jungla).
rol(vi, jungla).
rol(jinx, adc).
rol(missFortune, adc).
rol(garen, top).
rol(mundo, top).
rol(zoe, mid).
rol(akali, mid). 
rol(morgana, soporte).
rol(rakan, soporte).


%2
vidaInicial(garen, 1100).
vidaInicial(mundo, 1500).
vidaInicial(maestroYi, 800).
vidaInicial(vi, 850).
vidaInicial(jinx, 400).
vidaInicial(missFortune, 450).
vidaInicial(rakan, 1200).
vidaInicial(morgana, 600).
vidaInicial(zoe, 600).
vidaInicial(akali, 1010).

ataqueInicial(garen, 120).
ataqueInicial(mundo, 110).
ataqueInicial(maestroYi, 180).
ataqueInicial(vi, 150).
ataqueInicial(jinx, 220).
ataqueInicial(missFortune, 200).
ataqueInicial(rakan, 50).
ataqueInicial(morgana, 80).
ataqueInicial(zoe, 150).
ataqueInicial(akali, 130). 

%3
%esTanque/1
esTanque(Campeon):-
    vidaInicial(Campeon, Vida),
    Vida > 1000.

%esPeligroso/1
esPeligroso(Campeon):-
    ataqueInicial(Campeon, Ataque),
    Ataque > 50.


%4
%estaRoto/1 campeon
estaRoto(Campeon):-
    esTanque(Campeon),
    esPeligroso(Campeon).
estaRoto(maestroYi).


%5
%dificilDeUsar/1 campeon
dificilDeUsar(Campeon):-
    rol(Campeon, _). % <- Generador, acota el universo
    not(estaRoto(Campeon)).


%6 
%estaDesbalanceado/1 rol
estaDesbalanceado(Rol):-
    rol(_, Rol),
    forall(rol(Campeon, Rol), estaRoto(Campeon)). % <- forall(P, Q) == P=>Q (es cierto si para todo P, Q es cierto)

% IMPORTANTE: not/1 y forall/2 no son inversibles, no se pueden usar para generar información, solo para validar información ya existente.


%7
%vidaEn/3 nivel, campeon, vida
vidaEn(Nivel, Campeon, Vida):-
    vidaInicial(Campeon, VidaInicial),
    Vida is VidaInicial + (Nivel * 100).

%EJEMPLO DE USO DE "IS":
%doble/2 numero, resultado
doble(Numero, Resultado):-
    Resultado is Numero * 2.


%8
%ataqueEnNivel/3 nivel, campeon, ataque
ataqueEnNivel(Nivel, Campeon, Ataque):-
    ataqueInicial(Campeon, AtaqueInicial),
    Ataque is AtaqueInicial * Nivel.


%9
%cantidadDe/2 rol, cantidad
cantidadDe(Rol, Cantidad):-
    rol(_, Rol), % <- Generador, acota el universo
    findall(Campeon, rol(Campeon, Rol), Campeones),
    length(Campeones, Cantidad).


%10 FIJARME QUE COPIARON LOS PROFES EN EL CODIGO DE LA CLASE
%promedioVidaInicial/2 rol, promedio
promedioVidaInicial(Rol, Promedio):-
    rol(_, Rol), % <- Generador, acota el universo
    findall(Vida, VidaInicialDe(Rol, Vida), Vidas),
    promedio(Vidas, Promedio).

%vidaInicialDe/2 rol, vida
vidaInicialDe(Rol, Vida):-
    rol(Campeon, Rol),
    vidaInicial(Campeon, Vida).

%promedio/2 numeros, promedio
promedio(Numeros, Promedio):-
    sumlist(Numeros, Suma),
    length(Numeros, Cantidad),
    Promedio is Suma / Cantidad.


%11 QUEDA DE TAREA