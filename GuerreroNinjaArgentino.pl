% persona(Nombre, Apertura, Fuerza)
persona(ada, 166, 60).
persona(beto, 166, 65).
persona(connie, 154, 50).
persona(dana, 180, 70).
persona(esteban, 193, 40).

% A)
% ¿Existe alguien que tenga una apertura de 180 cm?
% - persona(_, 180, _).
% ?- true


% ¿Cuál es la fuerza de dana?
% - persona(dana, _, Fuerza).
% ?- Fuerza = 70


% ¿Quiénes tienen apertura 166 cm?
% - persona(Persona, 166, _).
% ?- Persona = ada;
%    Persona = beto.


% ¿Millhouse tiene 33 de fuerza?
% - persona(milhouse, _, 33).
% ?- false (no existe una persona llamada milhouse)


% ¿Es cierto que connie tiene una apertura de brazos de 154 cm?
% - persona(connie, 154, _).
% ?- true





% B)
algunoSuperaA(Persona):-
    persona(Persona, _, Fuerza),
    findall(Otro, (persona(Otro,_,FuerzaOtro), FuerzaOtro > Fuerza), Otros),
    length(Otros, Longitud),
    Longitud > 0.

% Indicar Verdadero o Falso y justificar conceptualmente:

% a.
% El código resuelve el problema planteado.
% - Si resuelve el problema, ya que al crear una lista con los nombres de las personas que tengan mas fuerza que la fuerza
%   de la persona que estamos ingresando, y luego va a contar la cantidad de elementos de la lista con un length para luego
%   preguntar si esa cantidad es mayor a 0, o sea si al menos existe uno.

% b. 
% El predicado algunoSuperaA es inversible.
% - Si el predicado es inversible ya que para variables (que arrancan con Mayus), te devuelve las personas que fueron 
%   superadas por otras al menos una vez.


% El predicado algunoSuperaA tiene problemas de declaratividad.
% - Es verdadero, pero tu justificación no apunta al problema real. El problema no es que "no delega",
% sino que utiliza un enfoque algorítmico/procedural (crear listas, contar elementos, comparar con cero)
% para resolver un problema de existencia simple

% Codificar una solución que resuelva los problemas planteados.
algunoSuperaA2(Persona) :-
    % 1. Generador: Buscamos la fuerza de la persona indicada.
    persona(Persona, _, FuerzaPersona),
    % 2. Condición existencial: Buscamos cualquier otra persona...
    persona(_, _, FuerzaOtro),
    % 3. ...cuya fuerza sea mayor.
    FuerzaOtro > FuerzaPersona.





% C)
obstaculo(aro(7), 14).
obstaculo(aro(15), 70).
obstaculo(barril(seco, 80), 10).
obstaculo(pared(5), 90).
obstaculo(aro(15), 10).
obstaculo(barril(humedo, 50), 26).
obstaculo(aro(2), 27).

laMetaEstaEn1(Posicion):-
  obstaculo(_, Posicion),
  findall(Obs, (obstaculo(Obs, Pos), 
      Pos > Posicion), Obstaculos),
  length(Obstaculos, 0).

laMetaEstaEn2(Posicion):-
  forall(obstaculo(_, Pos), Posicion >= Pos).


%1. ¿Ambas soluciones funcionan igual? Justificar conceptualmente usando ejemplos de consulta individuales y existenciales con sus respuestas en cada caso.
% No funcinan igual por problemas de inversibilidad y falsos positivos, a continuacion explico el funcionamiento de ambos:

% laMetaEstaEn1 guarda en una lista llamada Obstaculos, todo los obstaculos que sean mayor al ingresado en la variable 
% llamada Posicion por el usuario y luego pregunta si la longitud de esta lista Obstaculos es cero, o sea que no exista 
% ningun obstaculo que tenga una mayor posicion que el ingresado.

% laMetaEstaEn2 agarra todas las posicion de los obstaculos (sin importar que obstaculos son) que se encuentran en la base
% de conocimientos y pregunta si todas estas posiciones son menores o iguales que la posicion ingresada en la variable por 
% el usuario. Entonces con que una sola posicion sea mayor que la posicion ingresada por el usuario va a tirar false.

% Diferencias: 
% Diferencia 1: Falsos Positivos (Consulta Individual)
% laMetaEstaEn1 exige que la posición de la meta sea un obstáculo real gracias a su generador inicial 
% obstaculo(_, Posicion).  
% laMetaEstaEn2 no tiene generador. Si hacemos la consulta individual ?- laMetaEstaEn2(1000)., 
% el motor responderá true (porque 1000 es mayor a todas las posiciones existentes), a pesar de que no existe
% ningún obstáculo en el metro 1000. laMetaEstaEn1(1000) devolvería false correctamente.  
 
% Diferencia 2: Inversibilidad (Consulta Existencial)
% Consulta: ?- laMetaEstaEn1(Pos).Respuesta: Pos = 90. 
% Funciona perfecto porque el generador obstaculo(_, Posicion) instanció la variable antes de entrar al findall.  
% Consulta: ?- laMetaEstaEn2(Pos).Respuesta: ERROR (o false dependiendo del motor). 
% Falla estrepitosamente porque la variable Posicion entra libre al forall. Al llegar a la comparación Posicion >= Pos, Prolog no puede comparar matemáticamente una variable vacía contra un número.  


%2. Codificar una versión nueva sin usar ni forall ni findall, que sea inversible.

laMetaEstaEn3(Posicion):-
    obstaculo(_, Posicion), %GENERADOR QUE LIGA A LA VARIABLE PARA QUE SEA INVERSIBLE.
    not((
      obstaculo(_, Pos),
      Pos > Posicion
    )).





    % D)
puedeDarUnPaso(Persona, Desde, Hasta):-
   persona(Persona, Apertura, Fuerza),
   Apertura > Hasta - Desde, 
   obstaculo(aro(Grosor), Hasta),
   Fuerza > Grosor.

puedeDarUnPaso(Persona, Desde, Hasta):-
   persona(Persona, Apertura, Fuerza),
   Apertura > Hasta - Desde, 
   obstaculo(pared(Altura), Hasta),
   Fuerza > Altura * 3.

puedeDarUnPaso(Persona, Desde, Hasta):-
   persona(Persona, Apertura, Fuerza),
   Apertura > Hasta - Desde, 
   obstaculo(barril(humedo,Diametro), Hasta),
   Fuerza > 50 * Diametro / 10.

puedeDarUnPaso(Persona, Desde, Hasta):-
   persona(Persona, Apertura, Fuerza),
   Apertura > Hasta - Desde, 
   obstaculo(barril(seco,Diametro), Hasta),
   Fuerza > 30 * Diametro / 10.

% 1. Responder verdadero o falso y justificar conceptualmente:

% a. Es sencillo agregar un nuevo tipo de obstáculo sin cambiar el predicado puedeDarUnPaso.
% No debido a que cada obstaculo tiene una cuenta distinta para hacer por lo tanto cada obstaculo necesita un predicado 
% distino (falta delegación y polimorfismo).

% b. Hay conceptos del dominio que no están en el código.
% Si ya que la Dificultad de cada uno de los obstaculos (que es la cuenta que aparece en la ultima linea de cada predicado)
% no esta siendo declarada como Dificultad sino que se pierde en el codigo, ese 'mayor' pasa a ser en true or false.

% c. Se repite lógica.
% Si se repite logica, ya que para cada uno de los tipos de obstaculos se hizo un predicado especialmente para ese obstaculo.

% Proponer una nueva solución que resuelva los problemas detectados en el punto anterior.
% 1. Predicado principal limpio, sin repetir lógica y usando el concepto de "dificultad"
puedeDarUnPaso(Persona, Desde, Hasta) :-
    persona(Persona, Apertura, Fuerza),
    Apertura > Hasta - Desde, 
    obstaculo(Obstaculo, Hasta),
    dificultad(Obstaculo, Dificultad), % <-- Aparece el concepto de dominio
    Fuerza > Dificultad.

% 2. Delegación polimórfica: calculamos la dificultad según la "forma" del obstáculo
dificultad(aro(Grosor), Grosor).

dificultad(pared(Altura), Dificultad) :-
    Dificultad is Altura * 3.

dificultad(barril(humedo, Diametro), Dificultad) :-
    Dificultad is 50 * Diametro / 10.

dificultad(barril(seco, Diametro), Dificultad) :-
    Dificultad is 30 * Diametro / 10.






% E)
% 1. Caso Base: La persona está en una posición desde la cual 
% puede dar un solo paso y llegar directamente a la meta.
puedeGanarDesde(Persona, Posicion) :-
    laMetaEstaEn3(PosicionMeta),
    puedeDarUnPaso(Persona, Posicion, PosicionMeta).

% 2. Caso Recursivo: La persona puede dar un paso hasta un obstáculo intermedio, 
% y desde esa nueva posición, puede ganar la carrera.
puedeGanarDesde(Persona, Posicion) :-
    puedeDarUnPaso(Persona, Posicion, PosicionIntermedia),
    puedeGanarDesde(Persona, PosicionIntermedia).