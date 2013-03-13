PROGRAM LeerPartida;


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

    Procedure leerPalabra(var archivo : text; var palabra : string);
    Var
	    caracter	: char;
    Begin
	    palabra := '';
	    read(archivo,caracter);
	    while caracter <> ' ' do begin
		    palabra := palabra + caracter;
		    read(archivo,caracter);
	    end;
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
    Reset(partida);


    read(partida, ultimoJ);
    

    For i := 0 To ultimoJ Do
    Begin
				   (* aqui no se si leer palabra *)
	readln(partida, pc[i].posicion, pc[i].peon, pc[i].vida, pc[i].posicion);
	readln(partida, pc[i].conta.prj, pc[i].conta.arma, pc[i].conta.habt);
	    
	For j := 0 To 5 - pc[i].conta.prj Do
	Begin
	    LeerPalabra(partida, pc[i].lista.prj[j]);
	End;
	(* Armas Sin Descartar *)
	For j := 0 To 5 - pc[i].conta.arma Do
	Begin 	  	 	 	 	 	
	    LeerPalabra(partida, pc[i].lista.arma[j]);
	End;
	(* Habitaciones Sin Descartar *)
	For j := 0 To 8 - pc[i].conta.habt Do
	Begin
	    LeerPalabra(partida, pc[i].lista.habt[j]);
	End;
	readln(partida);

    	(* Personajes Descartados *)
	For  j := (5 - pc[i].conta.prj) To 5  Do
	Begin
	    LeerPalabra(partida, pc[i].lista.prj[j]);
	End;
	(* Armas Descartadas *)
	For j := (5 - pc[i].conta.arma)  To 5 Do
	Begin
	    LeerPalabra(partida, pc[i].lista.arma[j]);
	End;
	(* Habitaciones Descartadas *)
	For j := (8 - pc[i].conta.habt) To 8 Do
	Begin
	    LeerPalabra(partida, pc[i].lista.habt[j]);
	End;

    End;
    
    readln(partida);
    readln(partida, turnoActual); 

    Close(partida);
    
END.