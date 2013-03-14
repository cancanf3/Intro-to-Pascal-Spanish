(* Este es el Proyecto Serio *)
Program CLUE;

Type 
 
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
	contadores = Record // Variable contadora de descarte para las pc 
        arma : integer;
        habt : integer;
        prj  : integer;
      cartas : integer;
    sospecha : integer;
               End;
    lista_cartas = Record
        arma : armas;
        habt : habts;
        prj  : prjs; 
                   End;
    {ordinales = Record // Guarda los ordinales de las sospechas de computadoras
        arma : integer;
        habt : integer;
        prj  : integer;}

    user =  Record
		x : integer;
		y : integer;
		usuario : boolean;
        vida : boolean;
        mano : Array[0..2] of pha;
		donde : h;
		peon  : p;  // Ficha que usa para jugar
		lista : lista_cartas;  // Lista de cartas
        conta : contadores;
     posicion : integer;
     sospecha : Array[0..323] of sbr; 
        
            End;
  
   (* Funcion que hace swap para descartar de la lista *)

    Procedure Swap_descarte(var player : user; n : integer; 
                                m : integer; k : integer);
    Var
	tmp1 : a;
    tmp2 : h;
    tmp3 : p;
    Begin
        Case k of 
            0 :
            Begin
	            tmp1 := player.lista.arma[n];
	            player.lista.arma[n] := player.lista.arma[m];
	            player.lista.arma[m] := tmp1;
            End;
            2 :
            Begin
	            tmp2 := player.lista.habt[n];
	            player.lista.habt[n] := player.lista.habt[m];
	            player.lista.habt[m] := tmp2;
            End;
            1 :
            Begin
	            tmp3 := player.lista.prj[n];
	            player.lista.prj[n] := player.lista.prj[m];
	            player.lista.prj[m] := tmp3;
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
    
    (* Proceso para Seleccionar Personaje *)
    Procedure SeleccionPersonaje(phaInit : cartas; 
				 var player : Array of user;
				 ultimoJ : integer);
    Var
	i : integer;
	repartir: Array[0..5] of integer = (0,1,2,3,4,5);
    Begin
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

	For i:= 0 To ultimoJ Do
	Begin
	    player[i+1].peon := phaInit[repartir[i]];
	    writeln('Jugador ', i + 2, ' Selecciona a: ', player[i+1].peon);
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
 
    Procedure decision (var SioNo : boolean);
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
    Function Distancia(player : user ; Habitacion : lugar): integer;
    Begin
	Distancia := VA(Habitacion.x - player.x) 
		     + VA(Habitacion.y - player.y);
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
	Case n Of // Case de los numeros del Dado (1..6)
	    1    :  
		Begin
		    Writeln('Debe permanecer en su posicion: ', player.donde);
		    Exit;
		End;
	    2..6 : 
		Begin
		    If player.usuario then // Caso Usuario
 		    Begin
			co := 0;
			writeln('Habitaciones Alcanzables');
			For i := 0 To 8 Do
			Begin
			    If Distancia(player,Habitacion[i]) <= n Then
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
			
			player.x := Habitacion[eleccion[moverA - 1]].x;
			player.y := Habitacion[eleccion[moverA - 1]].y;
			player.donde := Habitacion[eleccion[moverA - 1]].nombre;
			writeln('Ahora se encuentra en: ', player.donde);
			
		    End 
		    Else
		    Begin // Caso computadora
			For i := 0 To 8 Do
			Begin
			    If Distancia(player,Habitacion[i]) <= n Then
			    Begin 
				writeln(Habitacion[i].nombre, ' es alcanzable');
				Habitacion[i].alcanzable := True;
			    End;
			End;
		    
			i := Aleatorio(0,8);
			While (Habitacion[i].nombre = player.donde) And Not habitacion[i].alcanzable Do
			Begin
			    i := Aleatorio(0,8);
			End;
			
			player.donde := Habitacion[i].nombre;
			player.x := Habitacion[i].x;
			player.y := Habitacion[i].y;
			writeln('Computadora se movio a: ', player.donde);
			(* 
			 * En la linea de Arriba podemos poner algo como
			 * writeln(player.peon, '(Computadora ', player.posicion, ') ', ' Se movio a: ', player.donde);'
			 *
			*)
		    End;
		End; // Del caso 2..6
	End; // Del Case completo
    End; // Procedure

Var
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

    repartir   : Array[0..20] of integer = (0,1,2,3,4,5,6,7,8,9,10,11,12,
						13,14,15,16,17,18,19,20);

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    
    
    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario
    
    i,j,co  : integer; // Variables para Iteracion y contadores.
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    Turn   : integer; // Contador de los Turnos.
    
    
    moverA : h;
    sospecha : sbr; // variable para realizar sospechas
    ultimoJ : integer;

    sospechaON : boolean;
    SioNo : boolean;

BEGIN
    writeln;
    Randomize();
    
    (*
     * Inicializacion de Variables 
     *)
    
    (* Inicializo las Habitaciones con sus ubicaciones *)
    co := 0;
    For i := 6 To 14 Do
    Begin
	habitacion[co].nombre := phaInit[i];
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
    
    SioNo := True; // Variable del procedimiento decision
    sospechaON := False;

    For i := 0 to 5 Do // Inicializo a todos los jugadores
    Begin
        pc[i].conta.arma := 0;
        pc[i].conta.habt := 0;
        pc[i].conta.prj  := 0;
    	pc[i].x := 2;
    	pc[i].y := 2;
    	pc[i].usuario := False;
    	pc[i].donde := Vestibulo;
        pc[i].posicion := i;
        For j := 0 to 5 Do
        Begin
            pc[i].lista.arma[j] := phaInit[j + 15 ];
        End;
        For j := 0 to 5 Do
        Begin
            pc[i].lista.prj[j] := phaInit[j];
        End;
        For j := 0 to 8 Do
        Begin
            pc[i].lista.habt[j] := phaInit[j + 6 ];
        End;
    End;
    pc[0].usuario := True; // Determinar que el jugador pc[0] es el Usuario

    (* 
     * Con este Procedimiento el usuario selecciona el personaje 
     * que usara en el juego y se aginan los demas a las computadoras
     *)
    SeleccionPersonaje(phaInit, pc,ultimoJ);
    writeln;
    
    (* Aqui se seleccionan los hechos reales y se reparten las cartas *)
    
    (* Seleccion del Asesino *)
    x := Aleatorio(0,5);
    sobre.prj := phaInit[x];
    
    (* Seleccion de la Habitacion donde se produjo el asesinato *)
    y := Aleatorio(6,14);
    sobre.habt := phaInit[y];
    
    (* Seleccion del arma con la que se cometio el asesinato *)
    z := Aleatorio(15,20);
    sobre.arma := phaInit[z];
    writeln;

    (* Swapeo las variables a las tres posiciones finales para 
	no repartir las cartas del sobre *)
    Swap(repartir[z], repartir[20]);
    writeln('El Arma es: ', sobre.arma);
    
    Swap(repartir[y], repartir[19]);
    writeln('La Habitacion es: ', sobre.habt);
    
    Swap(repartir[x], repartir[18]);
    writeln('El Asesino es: ', sobre.prj);
        
    
    (* Aqui hago Shuffle del arreglo de todas las cartas 
	excluyendo las del sobre *)
    For i := 17 Downto 1 Do
    Begin
	n := Aleatorio(0,i);
	Swap(repartir[i], repartir[n]);
    End;
    writeln;
        
    (* Aqui repatimos las cartas *)
    co := 0;
    For i := 0 To 5 Do
    Begin
	For j := 0 To 2 Do
	Begin
	    pc[i].mano[j] := phaInit[repartir[co]];
	    co := co + 1;
	End;
    End;
    
    (*
     * Ejemplo de la estructura de los turnos
     *
     *)
    While True Do
    Begin
	For i := 0 to 5
	Begin
	    
	    (*
	     * Los procedimientos Mover, Sospecha y Acusacion van dentro 
	     * de Turno, por lo que el programa seria una sola llamada a 
	     * Turno para cada jugador
	     *)
	    	    
	    (*
	    Turno(p[i]);
		
		n := Aleatorio(1,6);
		Mover(pc[i], n, habitacion);
		Sospecha(sospechaON,p[i],pc,phaInit);
		Acusacion(p[i],sobre);
	    *)
	End;
	Turno := Turno + 1;
    End;
     
    writeln;

END.
