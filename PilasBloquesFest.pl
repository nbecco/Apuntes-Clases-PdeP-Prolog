%%APUNTES DE LA CLASE:
% Member: sirve para saber si un elemento pertenece a una lista (va agarrando de a un elemento del functor).
% Se utilizan las LISTAS cuando no se la cantidad de respuestas que puedo llegar a obtener. Si se sabe la cantidad de respuestas, NO SE UTILIZAN LAS LISTAS

%1)
%a.
leGusta(chuy, peces).
leGusta(duba, churrascos).
leGusta(lita, ensalada([tomate, lechuga])).
leGusta(coty, pasto).
leGusta(mañic, pasto).
leGusta(mañic, churrascos).
leGusta(duba, asado(entrania, limonada)).
%pepita no por universo cerrado.

%b.
%esDeTipo/2 (Comida, Tipo)
esDeTipo(peces, carne).
esDeTipo(churrascos, carne).
esDeTipo(tomate, planta).
esDeTipo(lechuga, planta).
esDeTipo(pasto, planta).
esDeTipo(asado(_, _), carne).

%En este no hace falta un generador porque queremos hacer cosas locas
esDeTipo(ensalada(Ingredientes), planta):-
    forall(member(Ingrediente, Ingredientes), esDeTipo(Ingrediente, planta)).


%2)
%a. 
%seEncuentra/3 (Bioma, Comida, Cantidad)
seEncuentra(bosque, churrasco, 3).
seEncuentra(desierto, tomate, 1).
seEncuentra(desierto, lechuga, 1).
seEncuentra(llanura, pasto, 1).
seEncuentra(playaPatagonica, peces, 4).
seEncuentra(playaPatagonica, lechuga, 3).

%b.
%esNutritivo/1 (Bioma)
esNutritivoMio(Bioma):-
    seEncuentra(Bioma, Comida, _),
    seEncuentra(Bioma, OtraComida, _),
    Comida \= OtraComida,
    forall(esDeTipo(Comida, planta), esDeTipo(OtraComida, planta)).

%esNutritivoProfes(Bioma):-
%    tieneMuchosIngredientes(Bioma),
%    tieneTipoPlanta(Bioma).


%3)
%a.
%caminoDirecto/2 (Partida, Destino)
caminoDirecto(norte, desierto).
caminoDirecto(desierto, llanura).
caminoDirecto(llanura, bosque).
caminoDirecto(bosque, playaPatagonica).


%b.
%puedeLlegar/2 (Partida, Destino)
puedeLlegar(Partida, Destino):-
    caminoDirecto(Partida, Destino).

% ¿Se puede llegar del Norte a la Llanura?
% norte -> desierto -> llanura 
% caso recursivo
puedeLlegar(Partida, Destino):-
    caminoDirecto(Partida, Siguiente),
    puedeLlegar(Siguiente, Destino).


%4)
conoceA(coty, lita).
conoceA(lita, duba).
conoceA(duba, mañic).
conoceA(duba, capy).
conoceA(capy, mañic).
conoceA(capy, lita).
conoceA(capy, coty).

seConocen(UnPersonaje, OtroPersonaje):-
    conoceA(UnPersonaje, OtroPersonaje).
seConocen(UnPersonaje, OtroPersonaje):-
    conoceA(OtroPersonaje, UnPersonaje).

caminoDesde(Inicial, Final, Camino):-
    caminoEntre(Inicial, Final, [Inicial], Camino).

caminoEntre(UnPersonaje, OtroPersonaje, [UnPersonaje, OtroPersonaje]):-
    seConocen(UnPersonaje, OtroPersonaje).

caminoEntre(UnPersonaje, OtroPersonaje, Visitados, [UnPersonaje | RestoCamino]):-
    seConocen(UnPersonaje, Intermedio),
    Intermedio \= OtroPersonaje,
    not(member(Intermedio, Visitados)),
    caminoEntre(Intermedio, OtroPersonaje, [Intermedio | Visitados], RestoCamino).