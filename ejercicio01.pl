% Sintaxix: relacion(objeto1, objeto1).


% Estas dos líneas a lo que nos ayudan es a poder modificar los hechos existentes en tiempo de ejecución con el uso
% de retract() y assert()
:- dynamic spartan_fallecido/1.
:- dynamic spartan_vivo/1.


% Estos son hechos normales, lo que nuestro sistema sabe así que cualquier cosa definida la da como true.
spartan(jorge, noble_team).
spartan(carter, noble_team).
spartan(noble_six, noble_team).
spartan(kat, noble_team).

spartan_vivo(jorge).
spartan_vivo(carter).
spartan_vivo(noble_six).
spartan_vivo(kat).

arma(dmr, humana, mediana_distancia).
arma(rifle_de_plasma, no_humana, mediana_distancia).

usa_arma(carter, dmr).
usa_arma(noble_six, dmr).

habilidad(holograma, distraccion).
habilidad(bloqueo_armadura, defensa).
habilidad(evasion, movilidad).

mision(nueva_alexandria, ciudad, kat).

% esto de aquí ya viene siendo una regla, velo como una tipo funcion jeje
spartan_eficiente(X) :- miembro(X, noble_team) , usa_arma(X, dmr).

% esta tambien es una regla, se ve perra pero esta facil, pedimos una mision y vemos quien se murió en ella
% y si se muere alguien pues lo mandamos de los spartans vivos a los muertos, y  ya, lo escirbimos

progreso(Mision) :- 
    mision(Mision, _, Spartan),
    spartan_vivo(Spartan),
    retract(spartan_vivo(Spartan)),
    assert(spartan_fallecido(Spartan)),
    write('El/La Spartan '), 
    write(Spartan), 
    write(' temrinó su campaña').