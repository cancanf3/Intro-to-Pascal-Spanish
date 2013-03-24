(* Este es el Proyecto Serio *)
PROGRAM CLUE;

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
	
    contadores = Record // Variable contadora de descarte para las jugadores 
	arma : integer;
	habt : integer;
	prj  : integer;
	cartas : integer;
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
	mano : cartas;
	donde : h;
	peon  : p;  // Ficha que usa para jugar
	lista : lista_cartas;  // Lista de cartas
	conta : contadores;
	posicion : integer; 
    End;
  
    
    (* Permite ingresar el numero de Computadoras *)
    Procedure NComputadoras(var ultimoJ : integer);
    Var 
	s : string;
	codigo : word;
    Begin
	s := 'Ingrese el numero de computadoras contra las que desea jugar (2-5): ';
	Repeat
	Begin
	    write(s);
	    {$IOCHECKS OFF}
	    read(ultimoJ);
	    {$IOCHECKS ON}
	    codigo := ioResult; 
	    s := 'Opcion no valida, elija entre 2 y 5 computadoras: ';
	End
	Until (ultimoJ < 6) And (ultimoJ > 1) And (codigo = 0);
    End;
    
    
    (* Inicializacion de variables *)
    Procedure Inicializa (var phaInicio : cartas;
			    ultimoJ : integer;
			    var habitacion : array of lugar;
			    var jugadores : Array of user;
			    var Turn : integer;
			    var SioNo : boolean;
			    var juegoActivo : boolean;
			    var sospecha_conta : integer);
    Var 
    
	i, j : integer;
	x, y : integer;
	co : integer;
        
    Begin
	(* Habitaciones *)
	co := 0;
	For i := 6 To 14 Do
	Begin
	    habitacion[co].nombre := phaInicio[i];
	    habitacion[co].alcanzable := False;
	    co := co + 1;
	End;
	
	co := 0;
	y  := 0;
	For i := 0 To 2 Do
	Begin
	    x := 0;
	    For j := 0 to 2 Do
	    Begin
		habitacion[co].x := x;
		habitacion[co].y := y;
		x := x + 2;
		co := co + 1;
	    End;
	    y := y + 2;
	End;
	
	juegoActivo := True;
	SioNo := True; // Variable del procedimiento decision
	Turn := 0;
	sospecha_conta := 0;
	
	For i := 0 to ultimoJ Do // Inicializo a todos los jugadores
	Begin
	    jugadores[i].conta.arma := 0;
	    jugadores[i].conta.habt := 0;
	    jugadores[i].conta.prj  := 0;
	    jugadores[i].conta.cartas := -1;
	    jugadores[i].x := 2;
	    jugadores[i].y := 2;
	    jugadores[i].usuario := False;
	    jugadores[i].donde := Vestibulo;
	    jugadores[i].posicion := i;
	    jugadores[i].vida := True;
	    For j := 0 To 5 Do
	    Begin
		jugadores[i].lista.arma[j] := phaInicio[j + 15 ];
	    End;
	    For j := 0 To 5 Do
	    Begin
		jugadores[i].lista.prj[j] := phaInicio[j];
	    End;
	    For j := 0 To 8 Do
	    Begin
		jugadores[i].lista.habt[j] := phaInicio[j + 6 ];
	    End;
	End;
	
	For i := ultimoJ + 1 To 5 Do // Descarto las computadoras que no juegan
	Begin
	    jugadores[i].vida := False;
	End;
	
	
	jugadores[0].usuario := True; // Determinar que el jugador jugadores[0] es el Usuario
    
    End;
   
   (* Funcion que hace swap para descartar de la lista *)

    Procedure Swap_descarte(var jugador : user; n : integer; 
                                m : integer; k : integer);
    Var
	tmp1 : a;
	tmp2 : h;
	tmp3 : p;
    Begin
        Case k of 
            0 :
            Begin
	            tmp1 := jugador.lista.arma[n];
	            jugador.lista.arma[n] := jugador.lista.arma[m];
	            jugador.lista.arma[m] := tmp1;
            End;
            2 :
            Begin
	            tmp2 := jugador.lista.habt[n];
	            jugador.lista.habt[n] := jugador.lista.habt[m];
	            jugador.lista.habt[m] := tmp2;
            End;
            1 :
            Begin
	            tmp3 := jugador.lista.prj[n];
	            jugador.lista.prj[n] := jugador.lista.prj[m];
	            jugador.lista.prj[m] := tmp3;
            End;
        End;
    End;
 

    Procedure Swap (var n : integer; var m : integer);
    Var
	tmp : integer;
    Begin
	tmp := n;
	n := m;
	m := tmp;
    End;   
    
    
    
    (* Funcion que genera numeros aleatorios en un rango dado *)
    Function Aleatorio(inicio : integer; tope : integer) : integer;
    Var 
	amplitud : integer;
    Begin
	amplitud := (tope - inicio) + 1;
	Aleatorio := Random(amplitud) + inicio;
    End;
    
    
    (* Funcion que emula un dado *)
    Function Dado () : integer;
    Begin
	Dado := Aleatorio(1,6);
    End;
    
    
    
    
    
    (* Proceso para Seleccionar Personaje *)
    Procedure SeleccionPersonaje(phaInicio : cartas; 
				 var jugadores : Array of user;
				 ultimoJ : integer);
    Var
	i : integer;
	s : string;
	repartir: Array[0..5] of integer = (0,1,2,3,4,5);
	codigo : word;
    Begin
	writeln('Seleccione un personaje ingresando el numero correspondiente.');
	For i := 0 To 5 Do
	Begin
	    Writeln(i+1, '.- ', phaInicio[i]);
	End;
	
	s := 'Seleccion: ';
	Repeat
	Begin
	    write(s);
	    {$IOCHECKS OFF}
	    read(i);
	    {$IOCHECKS ON}
	    codigo := ioResult; 
	    s := 'Opcion no valida, intente de nuevo: '
	End
	Until (i < 7) And (i > 0) And (codigo = 0);
		
	jugadores[0].peon := phaInicio[i-1];
	writeln('El personaje seleccionado fue: ', jugadores[0].peon);
	writeln;
	
	(* Asignamos los personajes a las Computadoras *)
	Swap(repartir[i-1], repartir[5]);
	
	For i:= 1 To ultimoJ Do
	Begin
	    jugadores[i].peon := phaInicio[repartir[i-1]];
	    writeln('Jugador ', i + 1, ' Selecciona a: ', jugadores[i].peon);
	End;
    End;
    
    
    
    (* Proceso que elije las cartas del sobre y reparte las demas *)
    Procedure AsignarCartas (phaInicio : cartas;
			      var jugadores : array of user; 
			      var sobre : sbr; 
			      ultimoJ : integer);
    Var 
    	repartir   : Array[0..20] of integer = (0,1,2,3,4,5,6,7,8,9,10,11,12,
						    13,14,15,16,17,18,19,20);
	n,x,y,z : integer;
	i,j : integer;
	co : integer;
    Begin
    	(* Se seleccionan los hechos reales *)
	x := Aleatorio(0,5);
	sobre.prj := phaInicio[x];
	y := Aleatorio(6,14);
	sobre.habt := phaInicio[y];
	z := Aleatorio(15,20);
	sobre.arma := phaInicio[z];
	
	(* Muevo las variables a las tres posiciones finales para 
	    no repartir las cartas del sobre *)
	Swap(repartir[z], repartir[20]);
	Swap(repartir[y], repartir[19]);
	Swap(repartir[x], repartir[18]);
	
	(* Aqui hago Shuffle del arreglo de todas las cartas 
	    excluyendo las del sobre *)
	For i := 17 Downto 1 Do
	Begin
	    n := Aleatorio(0,i);
	    Swap(repartir[i], repartir[n]);
	End;
	writeln;
    
	(* Reparto las cartas dependiendo del numero de jugadores *)
	co := 0;
	j := 0;
	While (co < 18) Do
	Begin
	    i := 0;
	    While (i < ultimoJ + 1) And (co < 18) Do
	    Begin
		jugadores[i].mano[j] := phaInicio[repartir[co]];
//		writeln('Jugador', i,j, '   Carta: ', jugadores[i].mano[j]);    Probar Funcion
		jugadores[i].conta.cartas := jugadores[i].conta.cartas + 1;
		co := co + 1;
		i := i + 1;
	    End;
	    j := j + 1;
	End;
    End;
    
        
    
    
    (* Funcion que calcula el valor absoluto de un entero dado *)
    Function VA(n : integer): integer;
    Begin
	If n < 0 Then
	Begin
	    VA := n * -1;
	End
	Else
	Begin
	    VA := n;
	End;
    End;
    
    (* Funcion para preguntas del tipo (s/n) al usuario *)
 
    Procedure Decision (var SioNo : boolean);
    Var
	YN : char;
	n : integer;
    Begin
        Repeat
        Begin
            readln(YN);
            SioNo := true;
            n := 0;
        	Case YN of
        	    's','y' :
        		Begin
        		    SioNo := true;
                    n := 1;
        		End;
        	    'n'     :
        		Begin
        		    SioNo := false;
                    n := 1;
        		End;
            End;
        End
        Until ( n = 1 );
    End;  


    (* Funcion que calcula la distancia ente un usuario y una habitacion *)
    Function Distancia(jugador : user ; Habitacion : lugar): integer;
    Begin
	Distancia := VA(Habitacion.x - jugador.x) 
		     + VA(Habitacion.y - jugador.y);
    End;
    
    
    (* Procedimiento que permite mover a los jugadores *)   
    Procedure Mover (var jugador : user; // Usurio o Computadora.
			 n: integer;    // Lo que saco con el dado.
			 Habitacion : array of lugar);
    Var
	eleccion : Array[0..8] of integer; // Ayuda para Habts. Alcanzables.
	moverA : integer; // Eleccion del Usuario.
	co, i  : integer; // Contadores.
    Begin
	Case n Of // Case de los numeros del Dado (1..6)
	    1    :  
	    Begin
		Writeln('Debe permanecer en su posicion: ', jugador.donde);
		Exit;
	    End;
	    2..6 : 
	    Begin
		If jugador.usuario then // Caso Usuario
		Begin
		    co := 0;
		    writeln('Habitaciones Alcanzables');
		    For i := 0 To 8 Do
		    Begin
			If Distancia(jugador,Habitacion[i]) <= n Then
			Begin 
			    Habitacion[i].alcanzable := True;
			    writeln(co + 1,'.- ', Habitacion[i].nombre, ' es alcanzable.'); 
			    eleccion[co] := i;
			    co := co + 1;
			End;
		    End;
		    
		    write('Ingrese el numero correspondiente: ');
		    read(moverA);
		    (* Verificacion de la Entrada del Usuario *)
		    While (MoverA > co) Or (MoverA < 1) Do
		    Begin
			writeln('Numero Ingresado no valido');
			write('Intente de nuevo: ');
			read(MoverA);
		    End;
		    
		    jugador.x := Habitacion[eleccion[moverA - 1]].x;
		    jugador.y := Habitacion[eleccion[moverA - 1]].y;
		    jugador.donde := Habitacion[eleccion[moverA - 1]].nombre;
		    writeln('Ahora se encuentra en: ', jugador.donde);
		    
		End 
		Else
		Begin // Caso computadora
		    For i := 0 To 8 Do
		    Begin
			If Distancia(jugador,Habitacion[i]) <= n Then
			Begin 
			    writeln(Habitacion[i].nombre, ' es alcanzable');
			    Habitacion[i].alcanzable := True;
			End;
		    End;
		
		    i := Aleatorio(0,8);
		    While (Habitacion[i].nombre = jugador.donde) And Not habitacion[i].alcanzable Do
		    Begin
			i := Aleatorio(0,8);
		    End;
		    
		    jugador.donde := Habitacion[i].nombre;
		    jugador.x := Habitacion[i].x;
		    jugador.y := Habitacion[i].y;
		    writeln('Computadora se movio a: ', jugador.donde);
		    (* 
			* En la linea de Arriba podemos poner algo como
			* writeln(jugador.peon, '(Computadora ', jugador.posicion, ') ', ' Se movio a: ', jugador.donde);'
			*
		    *)
		End;
	    End; // Del caso 2..6
	End; // Del Case completo
    End; // Procedure

    
    
    (* Procedimiento que mueve a un sospechoso/acusado *)
    Procedure MoverSospechoso (sospeAcu : sbr; // Acusacion o Sospecha realizada
				ultimoJ : integer; // Numero de Computadoras
				jugador : user; // Jugador que Sopecho/Acuso 
				var jugadores : array of user);
    Var
	i : integer;
    Begin
	
	For i := 0 To ultimoJ Do
	Begin
	    If (jugadores[i].peon = sospeAcu.prj) 
		And jugadores[i].vida 
		And (i <> jugador.posicion) Then
	    Begin
		writeln('Posicion del que realiza la sospecha: ', jugador.donde);
		writeln('Posicion previa del sospechoso: ', jugadores[i].donde);
		jugadores[i].x := jugador.x;
		jugadores[i].y := jugador.y;
		jugadores[i].donde := jugador.donde;
		writeln('Movi al jugador(', i + 1, ') a la posicion del jugador(', jugador.posicion + 1,'): ', jugadores[i].donde);
	    End;
	
	    If (jugadores[i].peon = sospeAcu.prj) 
		And (i = jugador.posicion) Then
	    Begin
		writeln('Jugador(', jugador.posicion + 1, ') se acusa a si mismo! :0');
	    End;
	End;
    End;

    
    (* Repartir Cartas al eliminar a un jugador *)
    Procedure RepartirEliminado (var jugador : user;
				    var jugadores : array of user;
				    ultimoJ : integer);
    Var 
	i  : integer;
	co : integer;
    Begin
	co := 0;
	i := jugador.posicion + 1;	
	While (co < jugador.conta.cartas) Do
	Begin
	    While (i < ultimoJ + 1) And (co < jugador.conta.cartas) Do
	    Begin
		jugadores[i].conta.cartas := jugadores[i].conta.cartas + 1;
		jugadores[i].mano[jugadores[i].conta.cartas] := jugador.mano[co];
//		writeln('Jugador', i,j, '   Carta: ', jugadores[i].mano[j]);    Probar Funcion
		co := co + 1;
		i := i + 1;
	    End;
	End;
		
	While (co < jugador.conta.cartas) Do
	Begin
	    i := 0;
	    While (i < ultimoJ + 1) And (co < jugador.conta.cartas) Do
	    Begin
		jugadores[i].conta.cartas := jugadores[i].conta.cartas + 1;
		jugadores[i].mano[jugadores[i].conta.cartas] := jugador.mano[co];
// 		writeln('Jugador', i,j, '   Carta: ', jugadores[i].mano[j]);    Probar Funcion
		co := co + 1;
		i := i + 1;
	    End;
	End;
	writeln(co);
	jugador.conta.cartas := 0;
    End;
    
    
    (* Procedimiento que elimina jugadores segun sus acusaciones *)
    Procedure Eliminar(var jugador : user;
			var jugadores : Array of user;
			acusacion : sbr;
			sobre : sbr;
			ultimoJ : integer);
    Begin
	If (acusacion.prj <> sobre.prj) 
	    Or (acusacion.habt <> sobre.habt ) 
	    Or (acusacion.arma <> sobre.arma ) Then
	Begin
	    writeln('El jugador', jugador.posicion + 1, ' ha muerto :(.'); 
	    jugador.vida := False;
	End;
	RepartirEliminado(jugador,jugadores,ultimoJ);
    End;
    
    
    
    
    (* Proceso que permite guardar la partida pra retomarla luego *)
    Procedure Guardar (jugadores : Array of user;
			ultimoJ : integer;
			sobre : sbr;
			var partida : text);
    Var 
	i,j  : integer;
	tmp1 : integer;
	tmp2 : integer;
    Begin
	Assign(partida,'Partida.txt');
	Rewrite(partida);

	writeln(partida, ultimoJ + 1);
	writeln(partida, sobre.prj, ' ', sobre.arma, ' ', sobre.habt);
	
	For i := 0 To ultimoJ Do
	Begin
	    
	    write(partida, jugadores[i].peon, ' ');
	    If jugadores[i].vida Then
	    Begin
		write(partida, 'activo ');
	    End
	    Else
	    Begin
		write(partida, 'eliminado ');
	    End;
	    (* Hasta aqui la escritura esta bien *)
	    tmp1 := 0;
	    tmp2 := 0;
	    tmp1 := jugadores[i].conta.arma + jugadores[i].conta.habt + jugadores[i].conta.prj;
	    tmp2 := 21 - tmp1;
	    
	    writeln(partida, jugadores[i].donde, ' ');
	    
	    (* Cartas que posee el jugador *)
	    For j := 0 To jugadores[i].conta.cartas Do
	    Begin
		write(partida, jugadores[i].mano[j], ' ');
	    End;
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
	    writeln(partida);
	End;
	writeln(partida, jugadores[jugadores[i].posicion + 1].peon); 
	Close(partida);
    End;
    
    
    (* Procedimiento que chequea si el juego debe terminar *)
    Procedure Fin(jugadores : array of user;
		   acusacion, sobre : sbr;
		   var juegoActivo : boolean);
    Var
	i : integer;
    Begin
	
	(* Chequeo si alguna computadora sigue viva *)
	juegoActivo := False;
	i := 1;
	While (i < 6) And (juegoActivo = False) Do
	Begin
	    juegoActivo := jugadores[i].vida;
	    i := i + 1;
	End;
	
	(* Chequeo si el usuario fallo haciendo una acusacion *)
	If Not jugadores[0].vida Then
	Begin
	    juegoActivo := False;
	End;

	(* Chequeo si se realizo una acusacion correcta *)
	If (acusacion.prj = sobre.prj) 
	    And (acusacion.habt = sobre.habt) 
	    And (acusacion.arma = sobre.arma) Then
	Begin
	    juegoActivo := False;
	End;
	
    End;
    
    
    
VAR
    (* 
     * Personajes: 0 al 5
     * Habitaciones: del 6 al 14
     * Armas: 15 20 
    *)
    phaInicio : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    partida : Text;
    
    jugadores : Array[0..5] of user; // Arreglo de jugadores Jugador[0]:Usuario
    
    i,j,co  : integer; // Variables para Iteracion y contadores.
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    Turn   : integer; // Contador de los Turnos.
    
    sospecha  : sbr; // variable para realizar sospechas
    acusacion : sbr; // variable para realizar acusaciones
    ultimoJ : integer;
    sospecha_lista : Array[0..323] of sbr;
    sospecha_conta : integer;
   
    SioNo : boolean;
    juegoActivo : boolean;
    
    
BEGIN
    writeln;
    Randomize();
    
    (* Ingresa el Numero de Computadoras *)
    NComputadoras(ultimoJ);
    
    Inicializa(phaInicio, ultimoJ, habitacion, jugadores, Turn, SioNo, juegoActivo, sospecha_conta);
    
    (* 
     * Con este Procedimiento el usuario selecciona el personaje 
     * que usara en el juego y se aginan los demas a las computadoras
     *)
    
    SeleccionPersonaje(phaInicio, jugadores,ultimoJ);
    writeln;
    
    (* Se Asignan las cartas al sobre y se reparten las demas a los jugadores *)
    AsignarCartas(phaInicio, jugadores, sobre,  ultimoJ);
    writeln;
    
    (*
     * Ejemplo de como llamar a Mover sospechoso 
     *)
    // MoverSospechoso(sospecha,ultimoJ,jugadores[i],jugadores);
    
    
    
    
    
    
    (*
     * Ejemplo de la estructura de los turnos
     *
     *)
//     While juegoActivo Do
//     Begin
// 	For i := 0 to 5
// 	Begin
	    
	    (*
	     * Los procedimientos Mover, Sospecha y Acusacion van dentro 
	     * de Turno, por lo que el programa seria una sola llamada a 
	     * Turno para cada jugador
	     *)
	    	    
	    (*
	    Turno(p[i]);
		
		n := Aleatorio(1,6);
		Mover(jugadores[i], n, habitacion);
		Sospecha(sospechaON,p[i],jugadores,phaInicio);
		Acusacion(p[i],sobre);
	    *)
// 	End;
// 	Turno := Turno + 1;
//     End;
//      
//     writeln;
    Guardar(jugadores, ultimoJ, sobre, partida);

    


END.
