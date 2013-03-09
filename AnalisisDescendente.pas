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
	{Postcondicion: (%forall pc[i] \ 0 < i <= 5 : (%existis \ } 
    
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

Procedure Turno ( var player : user; habitacion : Array of lugar; SioNo : boolean );
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
