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
		habt : h; // Carta de habitacion en el sobre.
		prj  : p; // Carta de personaje en el sobre.
	    End;
	
    user =  Record
		x : integer; // Coordenada x del jugador.
		y : integer; // Coordenada y del jugador.
		usuario : boolean; // True : El jugador es el usuario.
		vida : boolean; //Determina si el jugador esta vivo.
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
    Procedure AsignaCartas (phaInit : cartas; var sobre : sbr);

        Procedure RepatirCartas (x : integer; 
                                 y : integer; 
                                 z : integer
                                 Var pc : Array of user;
                                 phaInit  : cartas );
        Var 
        repartir : Array[0..20] of integer = (0,1,2,3,4,5,6,7,8,9,10
                                              11,12,13,14,15,16,17,18
                                              ,19,20);
        i,j : integer; // Variable de iteracion
        Begin
            {precondicion: x <= 5 /\ x >= 0 /\
                           y <= 14 /\ y >= 6 /\
                           z <= 20 /\ z >= 15 }


            {Postcondicion: (%forall a : 0 <= a <= 5 : 
                            (%forall b : 0 <= b <= 2 :
                            (%forall c : 0 <= c <= 17 : 
                            pc[a].mano[b] = phaInit[repatir[c]] ))) }
        End;
    Var
        x,y,z : integer; // Variables que permite eleccion aleatorio
    Begin
    
    {Precondicion: True }


    {Postcondicion:  x <= 5 /\ x >= 0 /\
                     y <= 14 /\ y >= 6 /\
                     z <= 20 /\ z >= 15 /\
                     (%exist q: 0 <= q <= 5 : sobre.prj = phaInit[q] ) /\
                     (%forall w: 0<= w <= 5 /\ w <> q 
                         : sobre.prj <> phaInit[w] ) /\
                     (%exist q: 6 <= q <= 14 : sobre.habt = phaInit[q] ) /\
                     (%forall w: 6 <= w <= 14 /\ w <> q 
                         : sobre.habt <> phaInit[w] ) /\
                     (%exist q: 15 <= q <= 20 : sobre.arma = phaInit[q] ) /\
                     (%forall w: 15 <= w <= 20 /\ w <> q 
                         : sobre.arma <> phaInit[w] ) }

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

	{Postcondicion: n < 0 ==> (n = n * -1) 
			/\ n >= 0 ==> (n = n)}
    End;
    
    (* Funcion que calcula la distancia ente un usuario y una habitacion *)
    Function Distancia(player : user ; Habitacion : lugar): integer;
    Begin
	{Precondicion: True}

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
    
    (* Proceso para sospechar *)

    Procedure sospecha_usuario( var sospechaON : boolean; var player : user ; 
			var pc : array of user; phaInit : cartas );
    Var
	sospech : sbr; // Variable que guarda la sospecha
	muestro : integer; // Variable que permite determinar que carta mostrar
	h,n,m,l : integer; // variables que permiten programacion robusta
	s : string; // Variable que muestra mensajes al usuario
	k : integer; // determina cuantas cartas son sospechadas por mano
	carta : Array[0..2] of pha; // Arreglo que guarda las cartas sospechadas
	i,j,co : integer; // Contadores 
	humano : boolean; // determina si el usuario ha mostrado una carta
    Begin
	(* Elegir arma a sospechar *)

	(* Elegir personaje a sospechar *)

	{Precondicion: player == ( % exist x : 0 <= x <= 5 : pc[x] }
    
	(* Mover el personaje al lugar de la sospecha *)

	(* Match de las cartas *)

	{Postcondicion: sospechaON == !( % Exist x : 0 <= x <= 5 : 
			( % exist y : 0 <= y <= 2 : sospech = pc[x].mano[y] ))}

    End;

    Procedure sospecha_computadora( var sospechaON : boolean; var player : user ; 
			var pc : array of user; phaInit : cartas );
    Var
	sospech : sbr; // Variable que guarda la sospecha
	muestro : integer; // Variable que permite determinar que carta mostrar
	h,n,m,l : integer; // variables que permiten programacion robusta
	s : string; // Variable que muestra mensajes al usuario
	k : integer; // determina cuantas cartas son sospechadas por mano
	carta : Array[0..2] of pha; // Arreglo que guarda las cartas sospechadas
	i,j,co : integer; // Contadores 
	humano : boolean; // determina si el usuario ha mostrado una carta
    Begin

	(* Computadora elegira arma a sospechar *)
	(* Computadora elegira personaje a sospechar *)

	{Precondicion: player == ( % exist x : 0 <= x <= 5 : pc[x] }

	(* Mover el personaje al lugar de la sospecha *)

	(* Match de las cartas *)
	    (* Si el usuario tiene una carta de la sospecha *)

	{Postcondicion: sospechaON == !( % Exist x : 0 <= x <= 5 : 
			( % exist y : 0 <= y <= 2 : sospech = pc[x].mano[y] ))}

    End;

	(* Proceso para Acusar *)

    Procedure Acusacion_usuario( var player : user; sobre : sbr);
    Var 
	acus : sbr; // Variables que almacenaran la acusasion del jugador
    Begin
	    
	    (* Usuario acusa *)

		{Precondicion: sospechaON == true }  
	    (* Verificacion de la acusacion *) 

	    (* Pierde el jugador o Gana y se Termina el juego *)
	    {Postcondicion: player.vida == ( acus.arma = sobre.arma /\
			    acus.prj = sobre.prj /\ acus.habt = acus.habt ) }
    End;	


    Procedure Acusacion_computadora( var player : user; sobre : sbr);
    Var 
	acus : sbr; // Variables que almacenaran la acusasion del jugador
    Begin
	    
	    (* Computador acusa *)
    
		{Precondicion: sospechaON == true }  
	    (* Verificacion de la acusacion *) 


	    (* Pierde el jugador o Gana y se Termina el juego *)
	    {Postcondicion: player.vida == ( acus.arma = sobre.arma /\
			    acus.prj = sobre.prj /\ acus.habt = acus.habt ) }
    End;	











    Procedure Turno ( var player : user; habitacion : Array of lugar);
    Var
	decision : integer;
	opinion : boolean;
	n : integer;
    Begin
	{Precondicion: player.vida == true }

	(* Emulacion de Dado *)
	(* El jugador va a moverse *)
	(* El jugador realiza una sospecha *)
	(* El jugador realiza una acusacion *)
	(* Fin de su turno *) 

	{Post condicion: player.vida == acusacion} 
    End;








VAR
    (* 
     * Personajes: 0 al 5
     * Habitaciones: del 6 al 14
     * Armas: 15 20 
     *)
    phaInit : cartas // Arreglo con todas las cartas del juego.
    habitacion : Array[0..8] of lugar; // Arreglo de las habitaciones.
    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario.
    
    sobre   : sbr; // Variable que contiene los hechos reales.
       
    i,j,co  : integer; // Variables para Iteracion y contadores.
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    Turno   : integer; // Contador de los Turnos.
    
    sospecha : sbr; // variable para realizar sospechas.
    
    sospechaON : boolean; // determina si la sospecha fue refutada.
    

BEGIN

    Introduccion;

    Inicializa(pc,PhaInit,Habitacion);

    SeleccionPersonaje(phaInit,pc);
    
    AsignaCartas(phaInit,sobre);
    
    While juegoON Do
    Begin
	    For i := 0 To 5 Do
	    Begin
	        turno(pc[i],pc,phaInit,habitacion);
	    End;
    End;
    
    Despedida;



END.
