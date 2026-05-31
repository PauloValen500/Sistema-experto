maestro('Gerardo Carpio').
maestro('Suárez y Gómez').
maestro('Sirino').

meDioClase('Gerardo Carpio', 'Si').
meDioClase('Suárez y Gómez', 'Si').



conozco(Maestro) :-
    meDioClase(Maestro, _).