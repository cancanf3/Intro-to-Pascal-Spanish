PROGRAM AnalisisDescendente;

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
	   
    lugar = Record // Tipo para las Habitacion.
		nombre : h; // Nombre de la Habitacion.
		x : integer; // Coordenada x de la habitacion.
		y : integer; // Coordenada y de la habitacion.
		alcanzable : boolean; // Alcanzable o no en un turno.
	        End;
    
    sbr  =  Record
		arma : a; // Carta de arma en el sobre.
		habt : h; // Carta de habitacion en el sobre
		prj  : p; // Carta de personaje en el sobre
	    End;
	
    user =  Record
		x : integer; // Coordenada x del jugador.
		y : integer; // Coordenada y del jugador.
		usuario : boolean; // True : El jugador es el usuario.
		vida : boolean; // --------------------------------------------------------------------
		mano : array[0..2] of pha; // Cartas repartidas al Jugador.
		donde : h; // Nombre de la habitacion donde se encuentra.
		peon  : p;  // Ficha que usa para jugar.
		posicion : integer; // posicion en la mesa del jugador.
	    End;

    (* Procedimiento que Intercambia dos variables tipo integer *)
    Procedure Swap (var n : integer; var m : integer);
    Var
	tmp : integer;
    Begin
	{Precondicion: True}
	
	
	{Postcondicion: True}
    End;   
    
    (* Funcion que genera numeros aleatorios en un rango dado *)
    Function Aleatorio(inicio : integer; tope : integer) : integer;
    Var 
	amplitud : integer;
    Begin
	{Precondicion: True}
	
	{Postcondicion: Aleatorio >= inicio /\ Aleatorio <= tope} 
    End;
    
    (* Proceso para eleccion de personajes *)
    Procedure SeleccionPersonaje(phaInit : cartas; var player : Array of user);
    Var
	i : integer; // Variable de teracion
	repartir: Array[0..5] of integer = (0,1,2,3,4,5);
    Begin
	{Precondicion: True}
	writeln('Seleccione un personaje ingresando el numero correspondiente.');
	For i := 0 To 5 Do
	Begin
	    Writeln(i+1, '.- ', phaInit[i]);
	End;
	
	write('Usuario Selecciona: ');
	read(i);
	While (i > 6) Or (i < 1) Do
	Begin
	    writeln('Numero ingresado no valido');
	    write('Usuario Selecciona: ');
	    read(i);
	End;
	player[0].peon := phaInit[i-1];
	writeln('El personaje seleccionado fue: ', player[0].peon);
	writeln;
	
	(* Asignamos los personajes a las Computadoras *)
	Swap(repartir[i-1], repartir[5]);

	For i:= 0 To 4 Do
	Begin
	    player[i+1].peon := phaInit[repartir[i]];
	    writeln('Jugador ', i + 2, ' Selecciona a: ', player[i+1].peon);
	End;
	{Postcondicion: (%forall pc[i] \ 0 < i <= 5 : (%existis \  
    
    End;






















VAR
    (* 
     * Personajes: 0 al 5
     * Habitaciones: del 6 al 14
     * Armas: 15 20 
    *)
    phaInit : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);

    habitacion : Array[0..8] of lugar;
    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario
    
    sobre   : sbr; // Variable que contiene los hechos reales
    
    
    i,j,co  : integer; // Variables para Iteracion y contadores.
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    Turno   : integer; // Contador de los Turnos.
    
    sospecha : sbr; // variable para realizar sospechas
    
    sospechaON : boolean;
    

BEGIN





END.