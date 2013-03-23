PROGRAM PRueba_refutausuario;

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
 
Procedure Refuta_Usuario ( carta : Array of sbr; Var jugadorTurno : user;
                           sospech : sbr; k : integer; 
                           m : integer; n : integer; h : integer);
Var
    i : integer; // Variable para iterar.
    s : string; // Variable de mensajes.
    l : integer; // Variable de lectura robusta.
Begin
    Writeln('En tu mano hay ',k,
        ' cartas que se sospechan, cual quieres mostrar?');
    For i := 0 to (k-1) Do
    Begin
        If ( carta[i].arma = sospech.arma ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].arma);
        End;

        If ( carta[i].prj = sospech.prj ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].prj);
        End;

        If ( carta[i].habt = sospech.habt ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].habt);
        End;
    End;
    s := 'elige el numero de la carta a mostrar';
    Repeat
    Begin
        Writeln(s);
        Read(l);
        S := ' te equivocaste, elige otra vez';
    End
    Until ( n > 0 ) and ( n < (k + 1) );

    If ( carta[l-1].arma = sospech.arma ) Then
    Begin
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m,0);
        jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
    End;
    If ( carta[l-1].prj = sospech.prj ) Then
    Begin 
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n,1);
        jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
    End;
    If ( carta[l-1].habt = sospech.habt ) Then
    Begin 
        Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
        jugadorTurno.conta.habt := jugadorTurno.conta.habt + 1;
    End;
End;


VAR
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
    ha,ma,na : integer;
    SioNo : boolean;
    juegoActivo : boolean;
    k : integer;



BEGIN
carta[0].arma := revolver;
carta[1].prj := SenorVerde;
carta[2].habt := Salon;
sospech.arma := revolver;
sospech.prj := SenorVerde;
sospech.habt := Salon;
ha := 5; 
ma := 4;
na := 1;
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
    k := 3;

Refuta_Usuario(carta,jugadores[1],sospech,k,ma,na,ha);

Writeln('El jugador 1 mostrara sus lista de descartas');
Writeln;
Writeln(jugadores[1].lista.arma[5]);
Writeln;
Writeln(jugadores[1].lista.prj[5]);
Writeln;
Writeln(jugadores[1].lista.habt[8]);
Writeln;

Writeln(jugadores[1].conta.arma,jugadores[1].conta.prj,jugadores[1].conta.habt);


END.
