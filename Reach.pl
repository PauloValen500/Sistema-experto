% Sistema experto de Halo Reach 
% Aldo Moreno Muñoz 21240667
% Paulo Valenzuela Reynoso 21240669

:- dynamic spartan_vivo/1.
:- dynamic spartan_fallecido/1.

spartan(noble_six, personalizable, noble_team).
spartan(carter, a259, noble_team).
spartan(kat, b320, noble_team).
spartan(jorge, 052, noble_team).
spartan(emile, a239, noble_team).
spartan(jun, a266, noble_team).

spartan_vivo(noble_six).
spartan_vivo(jorge).
spartan_vivo(carter).
spartan_vivo(jun).
spartan_vivo(kat).
spartan_vivo(emile).

arma(dmr, unsc, largo_alcance).
arma(shotgun, unsc, corto_alcance).
arma(assault_rifle, unsc, medio_alcance).
arma(sniper_rifle, unsc, muy_largo_alcance).
arma(m6g, unsc, secundaria).
arma(rocket_launcher, unsc, explosiva).
arma(granade_launcher, unsc, explosiva).

vehiculos(warthog, unsc, terrestre).
vehiculos(scorpion, unsc, terrestre).
vehiculos(falcon, unsc, aereo).
vehiculos(pelican, unsc, aereo).

mision(contingencia_invernal, ninguno, info(reach, reconocimiento, [carter, kat, jorge, emile, jun, noble_six])).
mision(oni_base_espada, ninguno, info(reach, defensa, [carter, kat, noble_six])).
mision(anochecer, ninguno, info(reach, infiltracion, [jun, noble_six])).
mision(punta_de_lanza, ninguno, info(reach, asalto, [carter, kat, jorge, noble_six])).
mision(larga_noche_de_solace, jorge, info(reach, operacion_especial, [carter, kat, jorge, noble_six])).
mision(exodo, ninguno, info(reach, evacuacion, [noble_six])).
mision(nueva_alejandria, kat, info(reach, operacion_urbana, [carter, kat, emile, noble_six])).
mision(el_paquete, carter, info(reach, extraccion, [carter, emile, noble_six])).
mision(the_pillar_of_autumn, emile, info(reach, escolta, [emile, noble_six])).
mision(lobo_solitario, noble_six, info(reach, resistencia, [noble_six])).

% Regla 1
tipo_mision(Mision):-
    mision(Mision, _, info(_, X, Team)),
    write('Mision: '), write(Mision), nl,
    write('Tipo: '), write(X), nl,
    write('Equipo: '), write(Team), nl.

% Regla 2
asiste_a_mision(Spartan, Mision) :-
    mision(Mision, _, info(_, _, Team)),
    member(Spartan, Team).

% Regla 3
progreso(Mision):- 
    mision(Mision, B, _),
    B \= ninguno,
    spartan_vivo(B),
    retract(spartan_vivo(B)),
    assertz(spartan_fallecido(B)),
    write(B), write(' termino su campana en la mision '), write(Mision), nl.

progreso(Mision):-
    mision(Mision, ninguno, _),
    write('Mision '), write(Mision), write(' completada sin bajas en el Noble Team.'), nl.

% Pruebas de ejecucion
probar_sistema :-
    write('=== INICIANDO PRUEBAS DEL SISTEMA EXPERTO ==='), nl, nl,
    write('1. Probando tipo_mision para oni_base_espada:'), nl,
    tipo_mision(oni_base_espada), nl,
    write('2. ¿Noble Six asiste a la mision Anochecer?: '),
    (asiste_a_mision(noble_six, anochecer) -> write('Si, asiste.') ; write('No asiste.')), nl, nl,
    write('3. ¿Jorge asiste a la mision Exodo?: '),
    (asiste_a_mision(jorge, exodo) -> write('Si, asiste.') ; write('No asiste.')), nl, nl,
    write('4. Ejecutando progreso para Contingencia Invernal (Sin bajas):'), nl,
    progreso(contingencia_invernal), nl,
    write('5. Ejecutando progreso para Larga Noche de Solace (Baja: Jorge):'), nl,
    progreso(larga_noche_de_solace), nl,
    write('=== FIN DE LAS PRUEBAS ==='), nl.