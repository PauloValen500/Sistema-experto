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

shangheili(minior, azul, infanteria_basica, covenant, 1).
shangheili(major, rojo, lider_escuadron, covenant, 2).
shangheili(ultra, blanco, lider_combate, covenant, 3).
shangheili(ranger, plateado, asalto, covenant, 4).
shangheili(spec_ops, morado, fuerzas_especiales, covenant, 5).
shangheili(general, dorado, comandate_terrestre, covenant, 6).
shangheili(zealot, marron, mision_especial, covenant, 7).
shangheili(field_marshal, vino, comandante_operaciones, covenant, 8).

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

arma_shangheili(pistola_de_plasma, corto_alcance, 0).
arma_shangheili(rifle_de_plasma, medio_alcance, 0).
arma_shangheili(repetidor_de_plasma, medio_alcance, 0).
arma_shangheili(granada_de_plasma, explosiva, 0).

arma_shangheili(aguijoneador, medio_alcance, 1).
arma_shangheili(rifle_de_agujas, largo_alcance, 2).

arma_shangheili(rifle_de_foco, largo_alcance, 4).
arma_shangheili(rifle_de_conmocion, explosiva, 4).

arma_shangheili(espada_de_energia, cuerpo_a_cuerpo, 5).

arma_shangheili(canon_de_combustible, explosiva_pesada, 6).
arma_shangheili(lanzador_de_plasma, explosiva_pesada, 6).

arma_shangheili(espada_de_energia_sagrada, cuerpo_a_cuerpo, 7).
arma_shangheili(canon_de_combustible_field_marshal, explosiva_pesada, 8).

vehiculos(warthog, unsc, terrestre).
vehiculos(scorpion, unsc, terrestre).
vehiculos(falcon, unsc, aereo).
vehiculos(pelican, unsc, aereo).
vehiculos(ghost, covenant, terrestre).
vehiculos(wraith, covenant, terrestre).
vehiculos(banshee, covenant, aereo).
vehiculos(phantom, covenant, aereo).

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

covenant_en_mision(contingencia_invernal, [zealot, field_marshal, minor]).
covenant_en_mision(oni_base_espada, [minor, major, zealot]).
covenant_en_mision(anochecer, [ranger, spec_ops, minor]).
covenant_en_mision(punta_de_lanza, [minor, major, ultra, general]).
covenant_en_mision(larga_noche_de_solace, [ranger, spec_ops, zealot]).
covenant_en_mision(exodo, [minor, major, ultra]).
covenant_en_mision(nueva_alejandria, [ranger, spec_ops, field_marshal]).
covenant_en_mision(el_paquete, [ultra, general, zealot]).
covenant_en_mision(the_pillar_of_autumn, [general, zealot, field_marshal]).
covenant_en_mision(lobo_solitario, [ultra, zealot, field_marshal]).

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