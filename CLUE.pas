(* Este es el Proyecto Serio *)
Program CLUE;

    (* Funcion que genera numeros aleatorios en un rango dado *)
    Function Aleatorio(inicio : integer; tope : integer) : integer;
    Var 
	amplitud : integer;
    Begin
	amplitud := (tope - inicio) + 1;
	Aleatorio := Random(amplitud) + inicio;
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
    Function SioNo (): boolean;
    Var 
	YN : char;
    Begin
	read(YN);
	SioNo := true;
	Case YN of
	    's' :
		Begin
		    SioNo := True
		End;
	    'n' :
		Begin
		    SioNo := False
		End;
	    Else
	    Begin
		writeln('Opcion no valida, default es (s)');
	    End;
	End;
	writeln;
    End;
    
    (* Funcion que determina las habitaciones alcanzables con el numero
	obtenido al lanzar el dado *)
    
    (*
    Procedure Alcanzable(n : integer);
    Var 
	i : integer;
    Begin
	Writeln('Habitaciones Alcanzables');
	If n = 1 Then
	Begin
	    Writeln('Debe permanecer en su posicion: ', usuario.donde.nombre);
	    Exit;
	End;
	
	For i := 0 To 8 Do
	Begin
	    If VA(Habitacion[i].x - usuario.donde.x) + VA(Habitacion[i].y - usuario.donde.y) <= n Then
	    Begin
		writeln(Habitacion[i].nombre, ' es alcanzable');
	    End;
	End;
    End;
    *)
  (*  Procedure Acusacion( n : sbr; (*Variable del jugador*));
    Var 
    acus : sbr; // Variables que almacenaran la acusasion del jugador
    Begin
    	
    	acus.h := (* Variable que determina el lugar de la acusacion *)
    	Writeln('A quien desea acusar: ');
	Readln(acus.p);
	Writeln('Que arma se uso para matar a Mr.Black: ');
	Readln(acus.a);
	
	    { pre }  
	If ( acus.p = sobre.p ) And ( acus.a = sobre.a ) And ( acus.h = sobre.h ) Then
	Begin
		Writeln(' El Jugador ',(*Variable que identifica el jugador *),' ha adivinado las cartas del sobre');
		Writeln(' El Juego se da por terminado ');
		Halt;
	End
	Else 
	Begin
		(* Variable booleana del Jugador*) := false;
		If (* jugador = usuario *) Then
		Begin
			Writeln(' Has Fallado en tu acusacion ');
			Writeln(' Has Perdido ');
			Writeln(' Las cartas del sobre son ');
			Writeln(' Asesino: ',sobre.p,' Arma: ', sobre.a,' Lugar: ', sobre.h);
			Halt;
		End;
	End;
    End;	
*)



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
		

    user =  Record
		x : integer;
		y : integer;
		donde : h;
		peon  : p;  // Ficha que usa para jugar
		lista : cartas;  // Lista de cartas
	    End;

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

    repartirPrj: Array[0..5] of integer = (0,1,2,3,4,5);
    repartir   : Array[0..20] of integer = (0,1,2,3,4,5,6,7,8,9,10,11,12,
						13,14,15,16,17,18,19,20);

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    
    usuario : user; // Variable para el Jugador Humano
    pc : Array[0..4] of user; // Arreglo de Jugadores (Computadoras)
    
    i,j,co  : integer; // Variables para Iteracion y contadores
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    tmp     : integer; // Variable de uso temporal
    
    
    moverA : h;
    sospecha : sbr; // variable para realizar sospechas
    YN : char;

    sospechaON : boolean;

Begin 
    writeln;
    Randomize();
    
    (* Inicializo las Habitaciones con sus ubicaciones *)
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
    
    (* Verificacion de Datos de las Habitaciones *)
    For i := 0 To 8 Do
    Begin
	writeln(habitacion[i].nombre, ' (', habitacion[i].x, ', ', habitacion[i].y, ').');
    End;
    writeln;
    
    (* Con esta seccion de codigo el usuario selecciona el personaje 
	que usara en el juego *)
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
    usuario.peon := phaInit[i-1];
    writeln('El personaje seleccionado fue: ', usuario.peon);
  
    writeln;
    
    (*Codigo que asigna los personajes a las pc's*)
    tmp := repartirPrj[i-1];
    repartirPrj[i-1] := repartirPrj[5];
    repartirPrj[5] := tmp;
    
    For i:= 0 To 4 Do
    Begin
	pc[i].peon := phaInit[repartirPrj[i]];
	writeln('pc', i, ' agarro a: ', pc[i].peon);
    End;
    writeln;
    
    (* Aqui se seleccionan los hechos reales y se reparten las cartas *)
    
    (* Seleccion del Asesino *)
    x := Aleatorio(0,5);
    writeln(x);
    sobre.prj := phaInit[x];
    
    (* Seleccion de la Habitacion donde se produjo el asesinato *)
    y := Aleatorio(6,14);
    writeln(y);
    sobre.habt := phaInit[y];
    
    (* Seleccion del arma con la que se cometio el asesinato *)
    z := Aleatorio(15,20);
    writeln(z);
    sobre.arma := phaInit[z];
    
    writeln;
      
    (* Swapeo las variables a las tres posiciones finales para 
	no repartir las cartas del sobre *)
    tmp := repartir[z];
    repartir[z] := repartir[20];
    repartir[20] := tmp;
    write('El Arma es: ', sobre.arma);
    writeln;
        
    tmp := repartir[y];
    repartir[y] := repartir[19];
    repartir[19] := tmp;
    write('La Habitacion es: ', sobre.habt);
    writeln;

    tmp := repartir[x];
    repartir[x] := repartir[18];
    repartir[18] := tmp;
    write('El Asesino es: ', sobre.prj);
    writeln;
    
    (* Aqui hago Shuffle del arreglo de todas las cartas 
	excluyendo las del sobre *)
    For i := 17 Downto 1 Do
    Begin
	n := Aleatorio(0,i);
	tmp := repartir[i];
	repartir[i] := repartir[n];
	repartir[n] := tmp;
    End;
    writeln;
    
    (* Aqui asigno las cartas al usuario *)
    co := 0;
    For i := 0 To 2 Do
    Begin
	usuario.lista[i] := phaInit[repartir[co]];
	co := co + 1;
	writeln('Usuario', i, ' ', usuario.lista[i]);
    End;
    writeln;    
    
    (* Aqui asigno las cartas a las computadoras *)
    For i := 0 To 4 Do
    Begin
	For j := 0 To 2 Do
	Begin
	    pc[i].lista[j] := phaInit[repartir[co]];
	    co := co + 1;
	    // Esto para explicarle a Pena
	    // writeln('pc', i, j, ' ', pc[i].lista[j]);
	End;
    End;
    
    
    (*
     * Aqui comienza el juego
     * el primer turno es del usuario y luego 
     * cada una de las computadoras
     *)
    
    (* Inicializo Posiciones, todos comienzan desde el centro*)
    sospechaON := false;
    
    usuario.x := 2;
    usuario.y := 2;
    usuario.donde := Vestibulo;
    For i := 0 To 4 Do
    Begin
	pc[i].x := 2;
	pc[i].y := 2;
	pc[i].donde := Vestibulo;
    End;
    writeln;
    
    (* 
     *	Turno del Usuario 
     *)
    writeln('Turno del Usuario');
    writeln;
    write('Presione <Enter> para lanzar el dado');
    read(YN);
        
     
    (* Emulacion de Dado *)
    n := Aleatorio(1,6);
    writeln('Al lanzar el dado obtuvo un ', n, '.');
    writeln;
    
    (* Calculo de Habitaciones Alcanzables *)
    Writeln('Habitaciones Alcanzables');
    writeln;
    
    Case n Of
	1    :  
	    Begin
		Writeln('Debe permanecer en su posicion: ', usuario.donde);
	    End;
	2..6 :  
	    Begin
		For i := 0 To 8 Do
		Begin
		    If VA(Habitacion[i].x - usuario.x) + 
			    VA(Habitacion[i].y - usuario.y) <= n Then
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
			usuario.x := Habitacion[i].x;
			usuario.y := Habitacion[i].y;
			usuario.donde := Habitacion[i].nombre;
			writeln('Ahora se encuentra en: ', usuario.donde);
		    End
		    Else If (moverA = Habitacion[i].nombre) 
			And Not Habitacion[i].alcanzable Then
		    Begin
			writeln('Habitacion no alzanzable se quedara en: ', 
				    usuario.donde);
		    End;
		
		End;
		
	    End; // Del caso 2..6
    End; // Del Case completo
    
    
    (*
     * Codigo para realizar una sospecha
     *
     *)
    
    write('Desea realizar una sospecha desde, ', usuario.donde, ' (s/n): ');
            
    If SioNo Then
    Begin
	
	sospechaON := true;
	
	writeln('A que personaje desea acusar?');
	For i := 0 To 5 Do
	Begin
	    writeln(phaInit[i]);
	End;
	write('Usuario sospecha de: ');
	read(sospecha.prj);
	writeln;
	
	sospecha.habt := usuario.donde;

	writeln('Con que arma?');
	For i := 15 To 20 Do
	Begin
	    writeln(phaInit[i]);
	End;
	write('Con: ');
	read(sospecha.arma);
	writeln;
	
	writeln('La sospecha realizada es');
	writeln(sospecha.prj, ', en: ', sospecha.habt, ', con: ', sospecha.arma);
	
    End
    Else
    Begin
	writeln('Ok.. no acuses mamahuevo/va');
    End;
    writeln;
	
    If sospechaON Then
    Begin
	i := 0;
	While sospecha.prj <> pc[i].peon Do
	Begin
	    i := i + 1;
	End;
	writeln('Moviendo a ', pc[i].peon, ' a ', sospecha.habt);
	pc[i].donde := sospecha.habt;
    End;
    
    
    

    
    
    
    
    
    
    
    
  
  
    writeln;
    readln;
End.
