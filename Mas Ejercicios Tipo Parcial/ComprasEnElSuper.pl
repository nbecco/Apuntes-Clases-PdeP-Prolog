marca(cindor, laSerenisima).
marca(latuna, nereida).
marca(serenito, laSerenisima).

compro(martina, latuna).
compro(martina, cindor).
compro(aye, cindor).
compro(aye, serenito).

cliente(Cliente):-
    compro(Cliente, _).


%1. 
%a.
obsesivo(Cliente) :- 
    cliente(Cliente),
    forall(compro(Cliente, Producto), marca(Producto, Marca)).

%b.
obsesivo(Cliente) :- 
    marca(_, Marca),
    forall(compro(Cliente, Producto), marca(Producto, Marca)).

%c.
obsesivo(Cliente) :- 
    marca(Producto, _), 
    forall(compro(Cliente, Producto), marca(Producto, Marca)).

%a) 
% Marca no está instanciada (ligada) antes del forall. Al entrar como variable libre, 
% Prolog evalúa en cada iteración si el producto comprado tiene alguna marca (lo cual siempre es true), 
% en lugar de exigir que sea la misma marca para todas las compras

%b) 
% Ligar Marca antes del forall funciona lógicamente, pero usar marca(_, Marca) como generador es ineficiente 
% y redundante. Obliga al motor a repetir el forall por cada producto de la base de conocimientos, testeando 
% al cliente contra marcas que quizás jamás consumió

%c) 
% Al ligar Producto fuera del forall, se rompe la lógica del negocio. El predicado deja de iterar sobre 
% "todas las compras del cliente" y pasa a evaluar únicamente las compras de ese producto específico, 
% ignorando todo el resto de los productos que el cliente puso en su carrito.



%2. Codificar una solución superadora, correcta conceptualmente, pero que en lugar de usar forall/2 use not/1.
obsesivo2(Cliente) :-
    % 1. Generador: Ligamos al cliente, a un producto que compró, y a la marca de ese producto.
    % Esto asegura que el predicado sea totalmente inversible.
    compro(Cliente, Producto),
    marca(Producto, MarcaPrincipal),
    
    % 2. Condición excluyente: NO debe pasar que...
    not((
        compro(Cliente, OtroProducto),
        marca(OtroProducto, OtraMarca),
        OtraMarca \= MarcaPrincipal % ...esa otra marca sea distinta a la principal.
    )).