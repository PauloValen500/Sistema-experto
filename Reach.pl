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

arma(dmr, unsc,largo_alcance).
arma(shotgun, unsc, corto_alcance).
arma(assault_rifle, unsc, medio_alcance).
arma(sniper_rifle, unsc,muy_largo_alcance).
arma(m6g, unsc, secundaria).
arma(rocket_launcher, unsc, explosiva).
arma(granade_launcher, unsc, explosiva).


vehiculos(warthog, unsc, terrestre).
vehiculos(scorpion, unsc, terrestre).
vehiculos(falcon, unsc, aereo).
vehiculos(pelican, unsc, aereo).

mision(contingencia_invernal, ninguno, info(reach, reocnocimiento, equipo(carter,kat,jorge,emile,jun,noble_six))).
mision(oni_base_espada, ninguno, info(reach, defensa, equipo(carter,kat,noble_six))).
mision(anochecer, ninguno, info(reach, infiltracion, equipo(jun, noble_six))).
mision(punta_de_lanza, ninguno, info(reach, asalto, equipo(carter, kat, jorge, noble_six))).
mision(larga_noche_de_solace, jorge, info(reach, operacion_especial, equipo(carter, kat, jorge, noble_six))).
mision(exodo, ninguno, info(reach, evacuacion, equipo(noble_six))).
mision(nueva_alejandria, kat,info(reach, operacion_urbana, equipo(carter, kat, emile, noble_six))).
mision(el_paquete, carter, info(reach, extraccion, equipo(carter, emile, noble_six))).
mision(the_pillar_of_autumn, emile, info(reach, escolta, equipo(emile, noble_six))).
mision(lobo_solitario, noble_six, info(reach, resistencia, equipo(noble_six))).


progreso(Mision):- mision(Mision, B, _),
    B \= ninguno,
    spartan_vivo(B),
    assertz(spartan_fallecido(B)),
    retract(spartan_vivo(B)),
    write(B), write(' temrinó su campaña en la mision '),
    write(Mision), nl.

progreso(Mision):- mision(Mision, ninguno, _),
    write("Mision "), write(Mision),
    write(' completada sin bajas en el Noble Team.'), nl.