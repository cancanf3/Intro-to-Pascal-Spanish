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

    (* Procedimiento que inicializa las variables necesitadas *)
    Procedure Inicializa(var player : array of user; 
			    var phaInit : cartas; 
			    var Habitacion : array of lugar);
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

	{Postcondicion: (%forall i \ 0 < i <= 5 : (%existis j \ 0 <= j <= 5 : pc[i] = phaInit[j]} // ESTO NO SE SI ESTA BIEN ____---____  
    End;
    
    (* Funcion que calcula el valor absoluto de un entero dado *)
    Function VA(n : integer): integer;
    Begin
	{Precondicion: True}
	If n < 0 Then
	Begin
	    VA := n * -1;
	End
	Else
	Begin
	    VA := n;
	End;
	{Postcondicion: n < 0 ==> (n = n * -1) 
			/\ n >= 0 ==> (n = n)}
    End;
    
    
    (* Funcion que calcula la distancia ente un usuario y una habitacion *)
    Function Distancia(player : user ; Habitacion : lugar): integer;
    Begin
	{Precondicion: True}
	Distancia := VA(Habitacion.x - player.x) 
		     + VA(Habitacion.y - player.y);
	{Postcondicion: Distancia = \Habitacion.x - player.x\  
			+ \Habitacion.y - player.y\}
    End;
    
    (* Procedimiento que permite mover a los jugadores *)   
    Procedure Mover (var player : user; // Usurio o Computadora.
			 n: integer;    // Lo que saco con el dado.
			 Habitacion : array of lugar);
    Var
	eleccion : Array[0..8] of integer; // Ayuda para Habts. Alcanzables.
	moverA : integer; // Eleccion del Usuario.
	co, i  : integer; // Contadores.
    Begin
	{Precondicion: n >= 1 /\ n <= 6}
	
	{Postondicion: (%exits i \ 0 <= i <= 8 : player.x = Habitacion[i].x 
						/\ player.y = Habitacion[i].y
						/\ player.donde = Habitacion[i].nombre) }
    End;

    









VAR
    (* 
     * Personajes: 0 al 5
     * Habitaciones: del 6 al 14
     * Armas: 15 20 
     *)
    phaInit : cartas // Arreglo con todas las cartas del juego
    habitacion : Array[0..8] of lugar; // Arreglo de las habitaciones
    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario
    
    sobre   : sbr; // Variable que contiene los hechos reales
       
    i,j,co  : integer; // Variables para Iteracion y contadores.
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    Turno   : integer; // Contador de los Turnos.
    
    sospecha : sbr; // variable para realizar sospechas
    
    sospechaON : boolean;
    

BEGIN





END.