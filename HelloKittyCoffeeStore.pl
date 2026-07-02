% 1) 
    pedido(kuromi, bebida(mocca, frio, chico)).
    pedido(kuromi, pastel(torta, 2, [chocolate, crema])).
    pedido(melody, bebida(pinkLatte, caliente, grande)).
    pedido(melody, pastel(torta, 4, [frutilla, cereza, vainilla, crema])).
    pedido(cinnamoroll, pastel(cinnamoroll, 1, [canela, crema, vainilla])).
    pedido(pompompurin, bebida(cafeConLeche, caliente, chico)).
    pedido(chococat, pastel(torta, 3, [chocolate])).
    pedido(dearDaniel, bebida(matchaLatteLabubu, caliente, grande)).
    pedido(dearDaniel, pastel(torta, 3, [durazno, vainilla])).
    pedido(badtzMaru, bebida(cafe, caliente, mediano)).
    keruppi(vasoAgua).
    pedido(cinnamoroll, merchandising(taza, cinnamoroll)).
    pedido(dearDaniel, merchandising(taza, helloKitty)).


% 2)
    precio(agua, 0).
    precio(bebida(_, _, chico), 4000).
    precio(bebida(_, _, mediano), 6000).
    precio(bebida(_, _, grande), 8000).

    precio(pasteleria(_, Capas, Sabores), Precio) :-
        length(Sabores, CantidadSabores),
        Precio is 2000 * Capas + 800 * CantidadSabores.

    precio(merchandising(_, HelloKitty), 8000).
    precio(merchandising(_, Kuromi), 8000).
    precio(merchandising(_, Personaje), 6000) :-
        Personaje = helloKitty,
        Personaje = kuromi.


% 3)


% 4)


% 5)
    realizaPedidoCaro(Cliente):-
        Personaje(Cliente),
        forall(pedido(Cliente, Pedido), esCaro(Pedido)).

    esCaro(Pedido) :- 
        precio(Pedido, Precio),
        Precio > 6500.


% 6)



% 7)
