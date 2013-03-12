Program EscribirPartida;

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


Var
    
 
    
     phaInit : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);

    repartir   : Array[0..20] of integer = (0,1,2,3,4,5,6,7,8,9,10,11,12,
						13,14,15,16,17,18,19,20);

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    
    ultimoJ : integer;
    sobre : sbr;
    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario
    partida : Text;
    i,j : integer;
    turnoActual : integer;

Begin

    Assing(partida,'Partida.txt');
    Rewrite(partida);

    writeln(partida, ultimoJ + 1);
    writeln(partida);
    writeln(partida, sobre.prj, ' ', sobre.arma, ' ', sobre.habt);
    writeln(partida)

    For i := 0 To 5 Do
    Begin
	
	writeln(partida, pc[i].posicion + 1, pc[i].peon, pc[i].vida, pc[i].posicion + 1);
	
	write(partida, pc[i].conta.prj);
	write(partida, pc[i].conta.arma);
	write(partida, pc[i].conta.habts);
	writeln(partida);
	(* Personajes Sin Descartar *)
	For j := 0 To 5 - pc[i].conta.prj Do
	Begin
	    write(partida, pc[i].lista.prjs[j]);
	End;
	(* Armas Sin Descartar *)
	For j := 0 To 5 - pc[i].conta.arma Do
	Begin
	    write(partida, pc[i].lista.armas[j]);
	End;
	(* Habitaciones Sin Descartar *)
	For j := 0 To 8 - pc[i].conta.habts Do
	Begin
	    write(partida, pc[i].lista.habts[j]);
	End;
	writeln(partida);

    	(* Personajes Descartados *)
	For  j := (5 - pc[i].conta.prj) To 5  Do
	Begin
	    write(partida, pc[i].lista.prjs[j]);
	End;
	(* Armas Descartadas *)
	For j := (5 - pc[i].conta.arma)  To 5 Do
	Begin
	    write(partida, pc[i].lista.armas[j]);
	End;
	(* Habitaciones Descartadas *)
	For j := (8 - pc[i].conta.habts) To 8 Do
	Begin
	    write(partida, pc[i].lista.habts[j]);
	End;

    End;
    writeln(partida);
    writeln(partida, turnoActual); 

    Close(partida);

End.