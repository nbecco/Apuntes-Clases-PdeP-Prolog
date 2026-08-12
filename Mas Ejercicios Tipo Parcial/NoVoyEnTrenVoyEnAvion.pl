viaja(lola, avion(latam, 180, internacional)).
viaja(lola, bicicleta(urbana)).
viaja(fran, tren(retiroRosario, 90)).
viaja(fran, avion(aerolineas, 90, doméstico)).
viaja(fran, tren(cabaLujan, 70)).
viaja(lucia, avion(united, 300, internacional)).

noEsSustentable(Persona):-
  findall(A, viaja(Persona, avion(A,_,internacional)), Aviones),
  findall(T, viaja(Persona, tren(T,_)), Trenes),
  findall(V, viaja(Persona, V), Todos),
  length(Aviones, CAviones),
  length(Trenes, CTrenes),
  length(Todos, CTodos),
  CTodos is CAviones + CTrenes.

%1)
% noEsSustentable, compara la cantidad total de viajes de una persona con la suma de los elementos de una lista que tengan 
% las aerolineas de los aviones internacionales que esa misma persona se tomo + el trayecto de los trenes que esa misma 
% persona tambien se tomo.
% Entonces el significado del predicado es verificar si todos los viajes que realiza una persona son exclusivamente
% en aviones internacionales o trenes (es decir, que la persona no utiliza ningún otro medio de transporte, como bicicletas
% o vuelos domésticos).

% noEsSustentable(lola), esta consulta devolveria "fasle", ya que la cantidad total de viajes 
% de lola es 2 y la suma de sus viajes en avion internacional (1) + viajes en tren (0) =  2/=0


%2)
%a. 
% Es poco declarativa, ya que es muy poco declarativa porque resuelve un problema lógico usando herramientas
% algorítmicas y matemáticas (contar elementos con length y sumarlos) en lugar de utilizar cuantificadores universales 
% (forall o not).

%b. 
% Si utiliza polimorfismo, Es Verdadero, la solución original sí utiliza polimorfismo. 
% Cuando el código hace viaja(Persona, V), la variable V es capaz de unificar de forma transparente y 
% genérica con diferentes formas de functores (avion/3, tren/2, bicicleta/1). 
% Eso es la definición misma de polimorfismo en este paradigma: tratar de la misma manera a individuos con distintas formas


%3) SOLUCION SUPERADORA POR NOSOTROS:
noEsSustentable2(Persona):-
  findall(Aerolinea, viaja(Persona, avion(Aerolinea,_,internacional)), ViajesAvion),
  findall(Trayectoria, viaja(Persona, tren(Trayectoria,_)), ViajesTren),
  findall(Viaje, viaja(Persona, Viaje), ViajesTotales),
  length(ViajesAvion, CantidadViajesEnAvion),
  length(ViajesTren, CantViajesEnTren),
  length(ViajesTotales, CantViajesTotales),
  CantViajesTotales is CantidadViajesEnAvion + CantViajesEnTren.

% Solución realmente declarativa y superadora
noEsSustentable3(Persona) :-
    viaja(Persona, _), % Generador: ligamos a la persona para que sea inversible
    forall(viaja(Persona, Medio), medioContaminante(Medio)).

% Aprovechamos el polimorfismo (Pattern Matching sobre el functor)
medioContaminante(avion(_, _, internacional)).
medioContaminante(tren(_, _)).