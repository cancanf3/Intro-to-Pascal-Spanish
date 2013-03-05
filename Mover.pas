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
    
    
    Procedure Mover (var player : user; n: integer; Habitacion : array of lugar);
						   
    Var
	moverA : h;
	i : integer;
    Begin

	Case n Of
	    1    :  
		Begin
		    Writeln('Debe permanecer en su posicion: ', player.donde);
		    Exit;
		End;
	    2..6 :
		If player.usuario then
		Begin
		    Begin
			For i := 0 To 8 Do
			Begin
			    If VA(Habitacion[i].x - player.x) + 
				    VA(Habitacion[i].y - player.y) <= n Then
			    Begin 
				writeln(Habitacion[i].nombre, ' es alcanzable');
				Habitacion[i].alcanzable := True;
			    End;
			End;

			write('A cual de las posibles habitaciones desea ir: ');
			
			readln(moverA);
			For i := 0 To 8 Do
			Begin
			    If (moverA = Habitacion[i].nombre) 
				And Habitacion[i].alcanzable Then
			    Begin
				player.x := Habitacion[i].x;
				player.y := Habitacion[i].y;
				player.donde := Habitacion[i].nombre;
				writeln('Ahora se encuentra en: ', player.donde);
			    End
			    Else If (moverA = Habitacion[i].nombre) 
				And Not Habitacion[i].alcanzable Then
			    Begin
				writeln('Habitacion no alzanzable se quedara en: ', 
					    player.donde);
			    End;
		End // If del usuario
		
		Else
		    
		
		
		
		Begin // Caso computadora
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		End;
		    
		    End;
		End; // Del caso 2..6
	End; // Del Case completo
    End;

Var
    
    phaInit : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);
    
    habitacion : Array[0..8] of lugar;
    pc : Array[0..5] of user;
    
    i,j,co  : integer; // Variables para Iteracion y contadores
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    
    
Begin

    co := 0;
    For i := 6 To 14 Do
    Begin
	habitacion[co].nombre := phaInit[i];
	habitacion[co].alcanzable := False;
	co := co + 1;
    End;
    
    co := 0;
    x  := 0;
    For i := 0 To 2 Do
    Begin
	y := 0;
	For j := 0 to 2 Do
	Begin
	    habitacion[co].x := x;
	    habitacion[co].y := y;
	    y := y + 2;
	    co := co + 1;
	End;
	x := x + 2;
    End;
    
    pc[0].usuario := True;
    For i := 0 To 5 Do 
    Begin
	pc[i].x := 2;
	pc[i].y := 2;
	pc[i].usuario := False;
	pc[i].donde := Vestibulo;
    End;
    writeln;



    writeln(pc[0].donde);
    Mover(pc[0], 4, habitacion);
    writeln(pc[0].donde);

    






End.


















