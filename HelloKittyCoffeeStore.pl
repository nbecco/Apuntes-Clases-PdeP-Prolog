% 1) 
    pedido(kuromi, bebida(mocca, frio, chico)).
    pedido(kuromi, pastel(torta, 2, [chocolate, crema])).
    pedido(melody, bebida(pinkLatte, caliente, grande)).
    pedido(melody, pastel(torta, 1, [frutilla, cereza, vainilla, crema])).
    pedido(cinnamoroll, pastel(cinnamoroll, 1, [canela, crema, vainilla])).
    pedido(pompompurin, bebida(cafeConLeche, caliente, chico)).
    pedido(chococat, pastel(torta, 3, [chocolate])).
    pedido(dearDaniel, bebida(matchaLatteLabubu, caliente, grande)).
    pedido(dearDaniel, pastel(torta, 3, [durazno, vainilla, anana])).
    pedido(badtzMaru, bebida(cafe, caliente, mediano)).
    pedido(keroppi, agua).
    pedido(cinnamoroll, merchandising(taza, cinnamoroll)).
    pedido(dearDaniel, merchandising(taza, helloKitty)).


% 2)
    precio(agua, 0).
    precio(bebida(_, _, chico), 4000).
    precio(bebida(_, _, mediano), 6000).
    precio(bebida(_, _, grande), 8000).

    precio(pastel(_, Capas, Sabores), Precio) :-
        length(Sabores, CantidadSabores),
        Precio is 2000 * Capas + 800 * CantidadSabores.

    precio(merchandising(_, helloKitty), 8000).
    precio(merchandising(_, kuromi), 8000).
    precio(merchandising(_, Personaje), 6000) :-
        Personaje \= helloKitty,
        Personaje \= kuromi.


% 3)
compra(Cliente, NumeroDePedidos):-
    pedido(Cliente, _),
    findall(Pedido, pedido(Cliente, Pedido), Pedidos),
    length(Pedidos, NumeroDePedidos).


% 4)
noLeGustaCrema(Cliente):-
    pedido(Cliente, pastel(_, _, ListaSabor)),
    not(member(crema, ListaSabor)).

% 5)
    realizaPedidoCaro(Cliente):-
    pedido(Cliente, _), %ESTA BIEN IMPLEMENTAR ESTA LINEA POR la Inversibilidad (es un Generador de Inversibilidad)
        forall(pedido(Cliente, Pedido), esCaro(Pedido)).

    esCaro(Pedido) :- 
        precio(Pedido, Precio),
        Precio > 6500.


% 6)
gastoTotalPorCliente(Cliente, TotalGasto) :-
    pedido(Cliente, _),
    % El findall ahora recolecta Precios y vincula el pedido con su precio
    findall(Precio, (pedido(Cliente, Pedido), precio(Pedido, Precio)), ListaDePrecios),
    sumlist(ListaDePrecios, TotalGasto).

clienteQueMasGasto(Cliente) :-
    gastoTotalPorCliente(Cliente, GastoMaximo),
    % Verificamos que para cualquier otro gasto de otro cliente, el de nuestro Cliente sea mayor o igual
    forall(gastoTotalPorCliente(_, OtroGasto), GastoMaximo >= OtroGasto).
