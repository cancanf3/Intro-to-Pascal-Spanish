PROGRAM MAtch;

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
        mano : Array[0..8] of pha;
		donde : h;
		peon  : p;  // Ficha que usa para jugar
		lista : lista_cartas;  // Lista de cartas
        conta : contadores;
     posicion : integer; 
        
            End;




Procedure Match_cartas ( Var carta : Array of sbr ; jugadorTurno : user ;
                         jugadores : Array of user ; var sospechaON : boolean ;
                         var k : integer ; var quien : integer;
                         var humano : boolean; ultimoj : integer;
                         sospech : sbr );
Var
    i,j : integer; // Contadores
  
Begin

If  not ( jugadorTurno.usuario ) Then
Begin

    For i := ( jugadorTurno.posicion + 1 ) to ultimoj Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].conta.cartas  Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j].arma := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.prj ) Then 
                Begin    
                    carta[j].prj := sospech.prj;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.habt ) Then
                Begin
                    carta[j].habt := sospech.habt;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
            End;
        End;
    End;      
            
    For i := 0 to ( jugadorTurno.posicion - 1 ) Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].conta.cartas Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j].arma := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.prj ) Then 
                Begin    
                    carta[j].prj := sospech.prj;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.habt ) Then
                Begin
                    carta[j].habt := sospech.habt;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End; 
                If ( sospechaON = false ) and ( jugadores[i].usuario ) Then
                Begin
                    humano := True
                End;
            End;
        End;
    End;
End
Else
Begin
    For i := ( jugadorTurno.posicion + 1 ) to ultimoj Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].conta.cartas Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j].arma := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.prj ) Then 
                Begin    
                    carta[j].prj := sospech.prj;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.habt ) Then
                Begin
                    carta[j].habt := sospech.habt;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
            End;
        End;
    End;
End;
End;

Var
    phaInicio : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    
    
    jugadores : Array[0..5] of user; // Arreglo de jugadores Jugador[0]:Usuario
    
    i,j,co  : integer; // Variables para Iteracion y contadores.
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    Turn   : integer; // Contador de los Turnos.
    
    sospech  : sbr; // variable para realizar sospechas
    acusacion : sbr; // variable para realizar acusaciones
    ultimoJ : integer;
    sospecha_lista : Array[0..323] of sbr;
    sospecha_conta : integer;
    carta : Array[0..5] of sbr;
    quien : integer;
    humano : boolean;
    SioNo : boolean;
    juegoActivo : boolean;
    sospechaON : boolean;
    k : integer; // numero de cartas

BEGIN 
ultimoj := 5; 
Writeln;
For i := 0 to ultimoJ Do // Inicializo a todos los jugadores
	Begin
	    jugadores[i].conta.arma := 0;
	    jugadores[i].conta.habt := 0;
	    jugadores[i].conta.prj  := 0;
	    jugadores[i].conta.cartas := -1;
	    jugadores[i].usuario := False;
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
 
    co := 0;
	j := 0;
	While (co < 18) Do
	Begin
	    i := 0;
	    While (i < ultimoJ + 1) And (co < 18) Do
	    Begin
		jugadores[i].mano[j] := phaInicio[co];
//		writeln('Jugador', i,j, '   Carta: ', jugadores[i].mano[j]);    Probar Funcion
		jugadores[i].conta.cartas := jugadores[i].conta.cartas + 1;
		co := co + 1;
		i := i + 1;
	    End;
	    j := j + 1;
	End;

    sospech.arma := tubo;
    sospech.habt := biblioteca;
    sospech.prj := CoronelMostaza;
    sospechaON := TRUE;
    Writeln(' Sospecha Realizada ');
    Writeln;
    Writeln( sospech.arma ); 
    Writeln;
    Writeln(sospech.habt);
    Writeln;
    Writeln(sospech.prj);
    Writeln;
    
    For i := 0 to ultimoj Do
    Begin
        quien := i;
        Writeln('Estas son las cartas del jugador',Quien);
        For j:= 0 to (jugadores[j].conta.cartas) Do
        Begin
            Writeln(jugadores[i].mano[j]);
            Writeln;
        End;
    End;
    
    Match_cartas(carta,jugadores[1],jugadores,sospechaON,
            k,quien,humano,ultimoJ,sospech); 

    For i:= 0 to ( k - 1) Do
    Begin
        If ( carta[i].arma = sospech.arma ) Then
        Begin
            Writeln(' Arma matchiada ', carta[i].arma);
            Writeln;
        End;
        If ( carta[i].habt = sospech.habt ) Then
        Begin
            Writeln(' habitacion matchiada ', carta[i].habt);
            Writeln;
        End;
        If ( carta[i].prj = sospech.prj ) Then
        Begin
            Writeln(' peronaje matchiado ', carta[i].prj);
            Writeln;
        End;
    End;

    Writeln(k);

END.
