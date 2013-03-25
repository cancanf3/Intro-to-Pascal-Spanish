PROGRAM Tablero;


    Procedure Instrucciones ();
    {Pre:
	True
    }
    {Post;
	True
    }
        
    Begin
	writeln('Este programa es una simulacion del juego de Clue o Sospecha.');
	writeln();
	writeln('Usted podra elejir jugar con 2 a 5 computadoras contra las cuales competira por encontrar el Asesino del Senor del Black',
	'el lugar del crimen y el arma con la que se realizo. La mecanica del juego es la siguiente');

	

	writeln('	Reglas del Juego');
	writeln('1. El usuario elige una identidad que corresponde a uno de los personajes del juego.  Al resto de los');
	writeln('	    jugadores (que son de la máquina) se el asigna cualquiera de las identidates restantes');
	writeln('   2. Sin que ninguno de los jugadores vea,  se elige al azar un trio de cartas.  Una carta de personaje,  que será el');
	writeln('  criminal, otra carta de entre las armas, que será el objeto agresor y otra de entre las habitaciones que será el lugar');
	writeln(' del crimen. Estas tres tarjetas se guardan ocultas en un sobre. El resto de las tarjetas se juntan, se revuelven y se');
	writeln('reparten uniformemente entre los jugadores sin que sobren cartas.');
	writeln('3. Los jugadores pueden hacer una lista de todas las cartas del juego e ir marcando las que les tocaron y que desde');
	writeln('luego no son las que están en el sobre.');
	writeln('4. Los jugadores se enumeran según el turno que le corresponde en el juego, siguiendo el sentido de las agujas del');
	writeln('reloj y dándole el primer turno al usuario');
	writeln('	    5. Al inicio del juego, todos los peones que represetan a los personajes escogidos por los jugadores, se ubican en la');
	writeln('habitación del centro del tablero, desde allí iniciarán el juego.');
	writeln('6. Se lanza el dado, y según la posición actual y el número arrojado por el dado se escoge entre las habitaciones a la');
	writeln('que puede llegar, incluyendo la misma habitación actual. No es permitido quedarse en los pasillos, sino que debe');
	writeln('escogerse siempre una habitación.  Para llegar a una habitación no es imprescindible obtener una puntuación');
	writeln('exacta.');
	writeln('7. Una vez ubicado en una habitación, el jugador puede hacer la sospecha. La sospecha incluye el lugar en donde se');
	writeln('encuentra,  el arma y personaje.  El peón del  personaje que se incluya en la sospecha se traslada al cuarto');
	writeln('sugerido. El peón movido desde su habitación para que se formule una sospecha no regresa, después, a');
	writeln('su punto de origen; continúa su juego a partir de la nueva posición sobre el tablero de juego.');
	writeln('8. El jugador a la izquierda de quien formuló la sospecha, debe refutar la sospecha. Para ello, revisa en');
	writeln('sus cartas si tiene alguna de las que mencionó el participante.  De ser así, se la enseña sólo al que');
	writeln('preguntó sin que los otros jugadores puedan verlo, para que éste la elimine de su lista, ya que seguramente no');
	writeln('será esa la que este dentro del sobre. Si tiene más de una tarjeta de las que se mencionaron en la sospecha, solo');
	writeln('tiene que enseñar una, la que elija.'); 
	writeln('9. Si un jugador no puede refutar la sospecha, por no tener ninguna de las cartas, al jugador que se encuentra a la');
	writeln('izquierda de éste le corresponde entonces refutar la sospecha. Asi sucesivamente hasta que haya un jugador que');
	writeln('refuta la sospecha o ninguno de los jugadores diferentes al que formulo la sospecha haya podido refutarla.');
	writeln('10. Si un jugador hace una sospecha y ninguno de los otros jugadores puede refutarla; el jugador puede hacer una');
	writeln('acusación. De ser así, el jugador comprueba la validez de la misma mirando las cartas del sobre. Si es incorrecta,');
	writeln('queda eliminado del juego (ya que conoce la solución al mismo). Si es correcta, las cartas se muestran al resto de');
	writeln('los participantes.');
	writeln('11. El juego termina cuando un jugador hace una acusación que se comprueba correcta, en este caso ese jugador se');
	writeln('declara ganador. En caso que el usuario sea eliminado, por haber hecho una falsa acusación, se declara ganador a');
	writeln('la máquina y termina el juego. Si todos los jugadores, excepto el usuario, son eliminados por falsa acusación, el');
	writeln('juego termina y el  usuario se declara ganador');
	    	
    End;
    Procedure Bienvenida (var Siono : boolean);
    {Pre:
	True
    }
    {Post;
	True
    }
    
    
    Begin
	writeln('    ,o888888o.    8 8888      8 8888      88 8 8888888888 ',
		    '         8 8888      88    d888888o.   8 888888888o   ');
	writeln('   8888     `88.  8 8888      8 8888      88 8 8888       ',
		    '         8 8888      88  .`8888:` `88. 8 8888    `88. ');
	writeln(',8 8888       `8. 8 8888      8 8888      88 8 8888       ',
		    '         8 8888      88  8.`8888.   Y8 8 8888     `88 ');
	writeln('88 8888           8 8888      8 8888      88 8 8888       ',
		    '         8 8888      88  `8.`8888.     8 8888     ,88 ');
	writeln('88 8888           8 8888      8 8888      88 8 88888888888',
		    '8        8 8888      88   `8.`8888.    8 8888.   ,88  ');
	writeln('88 8888           8 8888      8 8888      88 8 8888       ',
		    '         8 8888      88    `8.`8888.   8 8888888888   ');
	writeln('88 8888           8 8888      8 8888      88 8 8888       ',
		    '         8 8888      88     `8.`8888.  8 8888    `88. ');
	writeln('`8 8888       .8` 8 8888      ` 8888     ,8P 8 8888       ',
		    '         ` 8888     ,8P 8b   `8.`8888. 8 8888      88 ');
	writeln('   8888     ,88`  8 8888        8888   ,d8P  8 8888       ',
		    '           8888   ,d8P  `8b.  ;8.`8888 8 8888    ,88  ');
	writeln('    `8888888P`    8 888888888888 `Y88888P    8 88888888888',
		    '8           `Y88888P`    `Y8888P ,88P` 8 888888888P   ');

	writeln('Bienvenido a Clue USB!');
	writeln();
	writeln('Desea leer las instrucciones?');
	
	Decision(SioNo);
	If SioNo Then
	Begin
	    Instrucciones;
	End
	Else
	Begin
	    writeln('Bien! Juguemos!');
	End;
	
    End;

    Procedure TableroClue ();
    {Pre:
	True
    }
    {Post;
	True
    }
    Begin
	writeln(' _________________________________________________________',
		    '_____________________________________________________  ');
		    
	writeln('/                     |                      |            ',
		    '         |                      |                    \ ');
	writeln('|                     |______________________|            ',
		    '         |______________________|                     |');
	writeln('|                                                         ',
		    '                                                      |');
		    
	writeln('|      Biblioteca                                    Cocin',
		    'a                                       Comedor       |');                  
	writeln('|                      ________      ________             ',
		    '          ________      ________                      |');
	writeln('|                     |        |    |        |            ',
		    '         |        |    |        |                     |');
	writeln('|_______       _______|        |    |        |_______     ',
		    '  _______|        |    |        |_______       _______|');
	writeln('|       |     |                |    |                |    ',
		    ' |                |    |                |     |       |');
	writeln('|       |     |________________|    |________________|    ',
		    ' |________________|    |________________|     |       |');
	writeln('|       |                                                 ',
		    '                                              |       |');
	writeln('|       |                                                 ',
		    '                                              |       |');
	writeln('|       |      ________________      ________________     ',
		    '  ________________      ________________      |       |');
	writeln('|       |     |                |    |                |    ',
		    ' |                |    |                |     |       |');
	writeln('|_______|     |_______         |    |         _______|    ',
		    ' |_______         |    |         _______|     |_______|');
	writeln('|                     |        |    |        |            ',
		    '         |        |    |        |                     |');
	writeln('|                     |________|    |________|            ',
		    '         |________|    |________|                     |');
	writeln('|                                                         ',
		    '                                                      |');
	writeln('|       Estudio                                     Vestib',
		    'ulo                                      Salon        |');
	writeln('|                      ________      ________             ',
		    '          ________      ________                      |');
	writeln('|                     |        |    |        |            ',
		    '         |        |    |        |                     |');
	writeln('|_______       _______|        |    |        |_______     ',
		    '  _______|        |    |        |_______       _______|');
	writeln('|       |     |                |    |                |    ',
		    ' |                |    |                |     |       |');
	writeln('|       |     |________________|    |________________|    ',
		    ' |________________|    |________________|     |       |');
	writeln('|       |                                                 ',
		    '                                              |       |');
	writeln('|       |                                                 ',
		    '                                              |       |');
	writeln('|       |      ________________      ________________     ',
		    '  ________________      ________________      |       |');
	writeln('|       |     |                |    |                |    ',
		    ' |                |    |                |     |       |');
	writeln('|_______|     |_______         |    |         _______|    ',
		    ' |_______         |    |         _______|     |_______|');
	writeln('|                     |        |    |        |            ',
		    '         |        |    |        |                     |');
	writeln('|                     |________|    |________|            ',
		    '         |________|    |________|                     |');
	writeln('|                                                         ',
		    '                                                      |');
	writeln('|     Invernadero                                   SalaDe',
		    'Baile                                 SalaDeBillar    |');
	writeln('|                      ______________________             ',
		    '          ______________________                      |');
	writeln('|                     |                      |            ',
		    '         |                      |                     |');
	writeln('\_____________________|______________________|____________',
		    '_________|______________________|____________________/ ');
    End;
    
    
    
    

BEGIN
END.