musico(luis, guitarra).
musico(luis, bajo).
musico(ana, voz). % la voz se considera un instrumento
musico(ana, teclado).
musico(juan, bateria).
musico(maria, voz).
musico(maria, guitarra).
instrumentosRequeridosParaBandaDe(rock, [guitarra, bateria, bajo, voz]).
instrumentosRequeridosParaBandaDe(jazz, [teclado, saxo, contrabajo, bateria]).

bandaPosible(Musicos, Genero):-  
  instrumentosRequeridosParaBandaDe(Genero, InstrumentosRequeridos),  
  findall(Instrumento,
    instrumentoDeAlgunMusico(Musicos, Instrumento), 
    InstrumentosDisponibles),  
  cubreTodos(InstrumentosRequeridos, InstrumentosDisponibles).  

instrumentoDeAlgunMusico(Musicos, Instrumento):-  
  member(Musico, Musicos), musico(Musico, Instrumento). 

cubreTodos(InstrumentosRequeridos, InstrumentosDisponibles):-  
  forall(member(Instrumento, InstrumentosRequeridos), 
   member(Instrumento, InstrumentosDisponibles)).


bandaPosible2(G, B):-  
  	instrumentosRequeridosParaBandaDe(B, I),  
  	forall(instrumentoDeAlgunMusico(G, II),member(II,I)).

% RESPUESTAS:

%1. Es correcta? No

%2. Es más expresiva? No

%3. Es más declarativa? No

%4. Mostrar ejemplos de consulta  y respuesta que muestren qué tan inversibles son ambas soluciones.

%?- bandaPosible([luis, ana, juan], Genero).
% Respuesta Original: Genero = rock (Asumiendo que Luis toca guitarra/bajo, Ana voz y Juan batería).
% Respuesta Nueva: Dará False por su defecto lógico (Ana toca el teclado, que no es de rock), pero mecánicamente logrará ligar la variable Genero a rock antes de fallar.

%?- bandaPosible(Banda, rock).
%Respuesta: Retornará False o un error de instanciación (dependiendo del motor Prolog que uses).

%La solución original no es totalmente inversible (solo es inversible respecto al género). 
% Para que fuera inversible respecto a los músicos, el código debería primero "generar" una lista de músicos 
% posibles sacándolos de la base de conocimientos explícitamente antes de pasarlos por el findall o el member, 
% dándole a Prolog un universo finito de datos concretos con los cuales trabajar. Y obviamente en la solucion nueva
% no es inversible porque directamente no funciona.