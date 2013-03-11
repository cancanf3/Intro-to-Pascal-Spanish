Program Mover;

Type
    pha = (SenoraBlanco, SenorVerde, SenoraCeleste, ProfesorCiruela,
	   SenoritaEscarlata, CoronelMostaza, Biblioteca, Cocina, Comedor,
	   Estudio, Vestibulo, Salon, Invernadero, SalaDeBaile, SalaDeBillar,
	   Candelabro, Cuchillo, Cuerda, LlaveInglesa, Revolver, Tubo);
    
    p = SenoraBlanco..CoronelMostaza;
    h = Biblioteca..SalaDeBillar;
    a = Candelabro..Tubo;
    
    cartas= Array[0..20] of pha;
    armas = Array[0..5] of a;
    habts = Array[6..14] of h;
    prjs  = Array[15..20] of p;

    user =  Record
		x : integer;
		y : integer;
		donde : h;
		usuario : boolean; 
		peon  : p;  // Ficha que usa para jugar
		lista : cartas;  // Lista de cartas
	    End;
    
    lugar = Record
		nombre : h;
		x : integer;
		y : integer;
		alcanzable : boolean;	
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
    
    (* Funcion que genera numeros aleatorios en un rango *)
    Function Aleatorio(inicio : integer; tope : integer) : integer;
    Var 
	amplitud : integer;
	
    Begin
	amplitud := (tope - inicio) + 1;
	Aleatorio := Random(amplitud) + inicio;
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
    
    phaInit : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);
    
    Habitacion : Array[0..8] of lugar;
    pc : Array[0..5] of user;
    
    i,j,co  : integer; // Variables para Iteracion y contadores
    n,m,x,y,z : integer; // Variables de usos multiples: swap, etc.
    
    
Begin
    Randomize();
    
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
    
    For i := 0 To 8 Do
    Begin
	writeln(habitacion[i].nombre, habitacion[i].x, habitacion[i].y);
    End;
    
    For i := 0 To 5 Do 
    Begin
	pc[i].x := 2;
	pc[i].y := 2;
	pc[i].usuario := False;
	pc[i].donde := Vestibulo;
    End;
    pc[0].usuario := True;
    writeln;

    (* Ejemplo de un uso normal de esta funcion *)
    For i := 0 To 100 Do
    Begin
	n := Aleatorio(1,6);
	m := Aleatorio(1,5);
	writeln('Ubicacion Previa: ', pc[m].donde, ' (', pc[m].x,', ', pc[m].y, ').');
	writeln;
	writeln('Llamada de la funcion == Mover(pc[', m, '], ', n, ', habitacion)');
	Mover(pc[m], n, habitacion);
	writeln;
    End;
    
    
End.


















