Program EscribirPartida;

TYPE
    pha = (SenoraBlanco, SenorVerde, SenoraCeleste, ProfesorCiruela,
	   SenoritaEscarlata, CoronelMostaza, Biblioteca, Cocina, Comedor,
	   Estudio, Vestibulo, Salon, Invernadero, SalaDeBaile, SalaDeBillar,
	   Candelabro, Cuchillo, Cuerda, LlaveInglesa, Revolver, Tubo);
    
    p = SenoraBlanco..CoronelMostaza;
    h = Biblioteca..SalaDeBillar;
    a = Candelabro..Tubo;
    
    cartas= Array[0..20] of pha;
    prjs = Array[0..5] of p;
    habts = Array[0..8] of h;
    armas  = Array[0..5] of a;
	   
    lugar = Record
		nombre : h;
		x : integer;
		y : integer;
		alcanzable : boolean;
	        End;
    
    sbr  =  Record
		arma : a;
		habt : h;
		prj  : p;
	        End;
	
    descarte = Record // Variable contadora de descarte para las pc 
        arma : integer;
        habt : integer;
        prj  : integer;
               End;

    lista_cartas = Record
        arma : armas;
        habt : habts;
        prj  : prjs; 
                   End;	

    user =  Record
		x : integer;
		y : integer;
		usuario : boolean;
        vida : boolean;
        mano : array[0..2] of pha;
		donde : h;
		peon  : p;  // Ficha que usa para jugar
		lista : lista_cartas;  // Lista de cartas
        conta : descarte;
     posicion : integer;
        
            End;


VAR
    
 
    
     phaInit : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    
    ultimoJ : integer;
    
    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario
    partida : Text;
    i,j : integer;
    turnoActual : integer;

BEGIN

    Assign(partida,'Partida.txt');
    Rewrite(partida);
    (* Hasta aqui esta bien *)
    writeln(partida, ultimoJ);
    writeln(partida, sobre.prj, ' ', sobre.arma, ' ', sobre.habt);
    
    For i := 0 To ultimoJ Do
    Begin
	
	writeln(partida, jugadores[i].posicion, jugadores[i].peon, jugadores[i].vida, jugadores[i].posicion);
	
	write(partida, jugadores[i].conta.prj);
	write(partida, jugadores[i].conta.arma);
	write(partida, jugadores[i].conta.habt);
	writeln(partida);
	(* Personajes Sin Descartar *)
	For j := 0 To 5 - jugadores[i].conta.prj Do
	Begin
	    write(partida, jugadores[i].lista.prj[j], ' ');
	End;
	(* Armas Sin Descartar *)
	For j := 0 To 5 - jugadores[i].conta.arma Do
	Begin 	  	 	 	 	 	
	    write(partida, jugadores[i].lista.arma[j], ' ');
	End;
	(* Habitaciones Sin Descartar *)
	For j := 0 To 8 - jugadores[i].conta.habt Do
	Begin
	    write(partida, jugadores[i].lista.habt[j], ' ');
	End;
	writeln(partida);

    	(* Personajes Descartados *)
	For  j := (5 - jugadores[i].conta.prj) To 5  Do
	Begin
	    write(partida, jugadores[i].lista.prj[j], ' ');
	End;
	(* Armas Descartadas *)
	For j := (5 - jugadores[i].conta.arma)  To 5 Do
	Begin
	    write(partida, jugadores[i].lista.arma[j], ' ');
	End;
	(* Habitaciones Descartadas *)
	For j := (8 - jugadores[i].conta.habt) To 8 Do
	Begin
	    write(partida, jugadores[i].lista.habt[j], ' ');
	End;

    End;
    writeln(partida);
    writeln(partida, Turn); 

    Close(partida);
END.