(*
 *
 * AnalisisDescendente.pas
 *
 * Este es el esqueleto de lo que seria un juego de Clue.
 * Contiene los tipos de datos, funciones con sus 
 * especificaciones y esquema general del juego.
 *
 * Autores:
 * 	Jose Pena
 *	Jose Pascarella
 *
 * Ultima Modificacion: 
 *	11 / 03 2013
 *
 *)

PROGRAM AnalisisDescendente;

TYPE 

    (* Todas las cartas del juego *)

    pha = (SenoraBlanco, SenorVerde, SenoraCeleste, ProfesorCiruela,
	   SenoritaEscarlata, CoronelMostaza, Biblioteca, Cocina, Comedor,
	   Estudio, Vestibulo, Salon, Invernadero, SalaDeBaile, SalaDeBillar,
	   Candelabro, Cuchillo, Cuerda, LlaveInglesa, Revolver, Tubo);

    (* Subrango de las cartas *)

    p = SenoraBlanco..CoronelMostaza; // Personajes
    h = Biblioteca..SalaDeBillar; // Habitaciones
    a = Candelabro..Tubo; // Armas

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
    
    mazo  =  Record
		        arma : a; // Carta de arma en el sobre.
		        habt : h; // Carta de habitacion en el sobre.
		        prj  : p; // Carta de personaje en el sobre.
	        End;
	
    usuario =  Record
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
    Procedure Inicializa(var jugadorTurno : array of usuario; 
			    var phainicio : cartas; 
			    var Habitacion : array of lugar
			    var ultimoJ : integer);
    Begin
	    {Precondicion: True}
	
	    {Postcondicion: True}
    End;
    
    (* Procedimiento que da la bienvenida y explica las reglas *)
    Procedure Introduccion( phainicio : cartas; 
			   Habitacion : array of lugar);
    Begin
	    {Precondicion: True}
	
	    {Postcondicion: True}
    End;
    
    (* Procedimiento que informa en que turno se consiguieron los hechos 
	    y agradece al usuario por jugar *)
    Procedure Despedida(Turno : integer);
    Begin
	    {Precondicion: True}
	
	    {Postcondicion: True}
    End;
    
    (* Funcion que genera numeros aleatorios en un rango dado *)
    Function Aleatorio(inicio : integer; tope : integer) : integer;
    Begin
	    {Precondicion: True}
	
	    {Postcondicion: Aleatorio >= inicio /\ Aleatorio <= tope} 
    End;
    
    (* Funcion emula un dado *)
    Function Dado(): integer;
    Begin
	    {Precondicion: True}
	
	    {Postcondicion: Dado >= 0 /\ Dado <= 6} 
    End;
    
    (* Asignacion de las cartes *) 
    Procedure AsignaCartas (phainicio : cartas; var sobre : mazo; var jugadores : Array of usuario; ultimoJ : integer;)

        Procedure RepatirCartas (x : integer; 
                                 y : integer; 
                                 z : integer;
                                 Var jugadores : Array of usuario;
                                 phainicio  : cartas );
        Begin
            {precondicion: x <= 5 /\ x >= 0 /\
                           y <= 14 /\ y >= 6 /\
                           z <= 20 /\ z >= 15 }


            {Postcondicion: (%forall a : 0 <= a <= ultimoJ : 
                            (%forall b : 0 <= b <= 2 :
                            (%forall c : 0 <= c <= ( ultimoJ * 3 ) : 
                            jugadores[a].mano[b] = phainicio[c] ))) 
			    /\ (%forall g : 0 <= g <= ( 17 - ultimoJ*3 ) : 
			    (%forall h : 2 <= h <= ( 17 - ultimoj*3 ) : jugadores[0].mano[h] = phainicio[g] ))
				}
        End;
   
    Begin
    
        {Precondicion: True }


        {Postcondicion:  x <= 5 /\ x >= 0 /\
                         y <= 14 /\ y >= 6 /\
                         z <= 20 /\ z >= 15 /\
                         (%exist q: 0 <= q <= 5 : sobre.prj = phainicio[q] ) /\
                         (%forall w: 0<= w <= 5 /\ w <> q 
                             : sobre.prj <> phainicio[w] ) /\
                         (%exist q: 6 <= q <= 14 : sobre.habt = phainicio[q] ) /\
                         (%forall w: 6 <= w <= 14 /\ w <> q 
                             : sobre.habt <> phainicio[w] ) /\
                         (%exist q: 15 <= q <= 20 : sobre.arma = phainicio[q] )/\
                         (%forall w: 15 <= w <= 20 /\ w <> q 
                             : sobre.arma <> phainicio[w] ) }

    End;

    (* Proceso para eleccion de personajes *)

    Procedure SeleccionPersonaje(phainicio : cartas; var jugadores : Array of usuario; var ultimoJ : integer);
    Begin
	    {Precondicion: True}

	    {Postcondicion: (%forall i \ 0 < i <= ultimoJ :
		        (%existis j \ 0 <= j <= 5 : jugadores[i] = phainicio[j])) }
    End;
    
    (* Funcion que calcula el valor absoluto de un entero dado *)

    Function VA(n : integer): integer;
    Begin
	    {Precondicion: True}

	    {Postcondicion: n < 0 ==> (n = n * -1) 
			    /\ n >= 0 ==> (n = n)}
    End;
    
    (* Funcion que calcula la distancia ente un usuario y una habitacion *)

    Function Distancia(jugadorTurno : usuario ; Habitacion : lugar): integer;
    Begin
	    {Precondicion: True}

	    {Postcondicion: Distancia = \Habitacion.x - jugadorTurno.x\  
			    + \Habitacion.y - jugadorTurno.y\}
    End;
    
    (* Procedimiento que permite mover a los jugadores *)  

    Procedure Mover (var jugadorTurno : usuario; // Usurio o Computadora.
			 n: integer;    // Lo que saco con el dado.
			 Habitacion : array of lugar);
    Begin
	    {Pre: n >= 1 /\ n <= 6}
	
	    {Post: (%exits i \ 0 <= i <= 8 : jugadorTurno.x = Habitacion[i].x 
				    /\ jugadorTurno.y = Habitacion[i].y
				    /\ jugadorTurno.donde = Habitacion[i].nombre)}
    End;
    
    (* Proceso para sospechar *)

    Procedure sospecha_usuario( var sospech : mazo; var sospechaON : boolean; 
				var jugadorTurno : usuario ; 
				var jugadores : array of usuario; phainicio : cartas );

	Procedure Refutar ( var jugadorTurno : usuario; sospech : mazo;
			    var muestro : integer ; var k : integer);
	Begin
	
	    {Precondicion: (%existe i : 0 <= i <= 5 :
		(%exist j : 0 <= j <= 2 
		    : sospech = jugadores[i].mano[j] )) }

	    {Postcondicion: sospechaON == !( (%exist a :
		0 <= a <= 2 : carta[a] = sospech.arma) \/
		(%exist b : 0 <= b <= 2 /\ a <> b : 
		    carta[b] = sospech.habt ) \/
		(%exist c : 0 <= c <= 2 /\ c <> a /\ b <> c :
		    carta[c] = sospech.prj ) ) }
	End;

    Procedure Descarte ( Var jugadorTurno : usuario; 
                         sospech : mazo; jugadores : Array of usuario);
    Begin
        {precondicion: sospechaON == False }

        {Postcondicion: (%exist x : 0 <= x <= 20 - jugadorTurno.conta : 
                        (%first y : jugadorTurno.posicion < y <= 5 /\ 
                        0 <= y < jugadorTurno.posicion : 
                        (% exist z : 0 <= z <= 2 : 
                        jugadorTurno.lista[x] = jugadores[y].mano[z] ) ) ) 
                        /\ jugadorTurno.conta >= 0 /\ jugadorTurno.conta <= 20}
    End;

    Begin
	(* Elegir arma a sospechar *)

	(* Elegir personaje a sospechar *)

    	{Precondicion: jugadorTurno == ( % exist x : 0 <= x <= 5 : jugadores[x] }
    
	(* Mover el personaje al lugar de la sospecha *)

	(* Match de las cartas *)

	    {Postcondicion: sospechaON == !( % Exist x : 0 <= x <= 5 : 
			    ( % exist y : 0 <= y <= 2 : sospech = jugadores[x].mano[y] ))}

    End;

    Procedure Sospecha_computadora( var sospech : mazo ;var sospechaON : boolean; 
                                    var jugadorTurno : usuario ; 
                                    var jugadores : array of usuario; 
                                        phainicio : cartas );

	Procedure Refutar ( var jugadorTurno : usuario; sospech : mazo;
			    var muestro : integer ; var k : integer);
	Begin
		
	    {Precondicion: (%existe i : 0 <= i <= 5 :
		(%exist j : 0 <= j <= 2 
		    : sospech = jugadores[i].mano[j] )) }

	    {Postcondicion: sospechaON == !( (%exist a :
		0 <= a <= 2 : jugadores[0].mano.[a] = sospech.arma) \/
		(%exist b : 0 <= b <= 2 /\ a <> b : 
		    jugadores[0].mano[b] = sospech.habt ) \/
		(%exist c : 0 <= c <= 2 /\ c <> a /\ b <> c :
		    jugadores[0].mano[c] = sospech.prj ) ) }
	End;

    Procedure Descarte ( Var jugadorTurno : usuario; 
                         sospech : mazo; jugadores : Array of usuario);
    Begin
        {precondicion: sospechaON == False }

        {Postcondicion: (%exist x : 0 <= x <= 20 - jugadorTurno.conta : 
                        (%first y : jugadorTurno.posicion < y <= 5 /\ 
                        0 <= y < jugadorTurno.posicion : 
                        (% exist z : 0 <= z <= 2 : 
                        jugadorTurno.lista[x] = jugadores[y].mano[z] ) ) ) 
                        /\ jugadorTurno.conta >= 0 /\ jugadorTurno.conta <= 20}

    End;

    Begin

	(* Computadora elegira arma a sospechar *)
	(* Computadora elegira personaje a sospechar *)

	    {Precondicion: jugadorTurno == ( % exist x : 0 <= x <= 5 : jugadores[x] }

	(* Mover el personaje al lugar de la sospecha *)

	(* Match de las cartas *)
	    (* Si el usuario tiene una carta de la sospecha *)

	    {Postcondicion: sospechaON == !( % Exist x : 0 <= x <= 5 : 
			    ( % exist y : 0 <= y <= 2 : sospech = jugadores[x].mano[y] ))}

    End;

    (* Proceso para Acusar *)

    Procedure Acusacion_usuario( var jugadorTurno : usuario; sobre : mazo);
    Var 
	acus : mazo; // Variables que almacenaran la acusasion del jugador
    Begin
	    
	    (* Usuario acusa *)

		{Precondicion: sospechaON == true }  
	    (* Verificacion de la acusacion *) 

	    (* Pierde el jugador o Gana y se Termina el juego *)
	    {Postcondicion: jugadorTurno.vida == ( acus.arma = sobre.arma /\
			    acus.prj = sobre.prj /\ acus.habt = acus.habt ) }
    End;	


    Procedure Acusacion_computadora( var jugadorTurno : usuario; sobre : mazo);
    Begin
	    
	    (* Computador acusa *)
    
		{Precondicion: sospechaON == true }  
	    (* Verificacion de la acusacion *) 


	    (* Pierde el jugador o Gana y se Termina el juego *)
	    {Postcondicion: jugadorTurno.vida == ( acus.arma = sobre.arma /\
			    acus.prj = sobre.prj /\ acus.habt = acus.habt ) }
    End;	

    (* Mover personaje *)

    Procedure MoverSospechoso (sospech : mazo ; var jugadores : Array of usuario ; 
                               acus : mazo );

    Begin
        {Precondicion: True }

        {Postcondiccion: (%exist z : 0 <= z <= 5 : 
                        sospech.habt = jugadores[z].donde \/ acus.habt = jugadores[z].donde) }
            
    End;

    (* Procedimiento que elimina un personaje si falla la acusacion *)

    Procedure Eliminar ( var jugadorTurno : usuario; acus : mazo; sobre : mazo);
 
    Begin
        {Precondicion: True }


        {Postcondicion: jugadorTurno.vida == ( ( acus.arma = sobre.arma ) /\ 
                    ( acus.prj = sobre.prj ) /\ ( acus.habt = sobre.habt ) )}

    End;
    
    (* Proceso que verifica y finaliza el juego *)

    Procedure Fin ( jugadores : Array of usuario; juegoFIN : boolean);
    Begin
        {Precondicion: True }

        {Postcondicion: juegoFIN == !( jugadores[0].vida == false \/
                        ( acus.arma = sobre.arma /\ acus.habt = sobre.habt
                            /\ acus.prj = sobre.prj ) \/
                        (%forall z : 1 <= z <= 5 : jugadores[z].vida == false ) )}

    End;

    (* Procedimiento que del turno *)

    Procedure Turno ( var jugadorTurno : usuario; habitacion : Array of lugar;
                      phainicio : cartas; var jugadores : Array of usuario; 
                      var sospech : mazo; var acus : mazo; juegoFIN : boolean);
    Begin
	    {Precondicion: jugadorTurno.vida == true }

	    (* Emulacion de Dado *)
	    (* El jugador va a moverse *)
	    (* El jugador realiza una sospecha *)
	    (* El jugador realiza una acusacion *)
	    (* Fin de su turno *) 

	    {Postcondicion: jugadorTurno.vida == ( ( acus.arma = sobre.arma ) /\ 
                    ( acus.prj = sobre.prj ) /\ ( acus.habt = sobre.habt ) )} 
    End;

Var
    
    habitacion : Array[0..8] of lugar; 	// Arreglo de las habitaciones.
    jugadores         : Array[0..5] of usuario;     // Arreglo de Jugadores. 
                                                    // jugadores[0]:Usuario.
    
    
    phainicio : cartas; 	// Arreglo con todas las cartas del juego.
    sobre   : mazo; 	// Variable que contiene los hechos reales.
       
    i	    : integer; // Variables para Iteracion y contadores.
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    TurnoConta    : integer; // Contador de los Turnos.
    
    juegoFIN : boolean; // Booleano para terminar el juego.
    
    sospecha   : mazo; 		// Variable para realizar sospechas.
    acus       : mazo; 		// Variable para realizar acusaciones.
    ultimoJ    : integer;       // Variable que determina el numero de jugadores.
    
Begin


End.
