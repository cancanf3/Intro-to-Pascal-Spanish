PROGRAM prueba_refuta_compu;

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

Function Aleatorio(inicio : integer; tope : integer) : integer;
Var 
amplitud : integer;
Begin
amplitud := (tope - inicio) + 1;
Aleatorio := Random(amplitud) + inicio;
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
 

Procedure Refuta_computadora ( carta : Array of sbr; var jugadorTurno : user;
                                k : integer; quien : integer; m : integer;
                                n : integer; h : integer; sospech : sbr);
Var
    muestro : integer; // Variable que determina que carta mostrar.
                               

Begin

    muestro := Aleatorio(0,k-1);
    If jugadorTurno.usuario Then
    Begin
        If ( sospech.arma = carta[muestro].arma ) Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[muestro].arma);
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,0);
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;

        End;

        If ( sospech.habt = carta[muestro].habt ) Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[muestro].habt);
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,1);
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
 
        End;

        If ( sospech.prj = carta[muestro].prj ) Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[muestro].prj);
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
            jugadorTurno.conta.habt := jugadorTurno.conta.habt + 1;
 
        End;
    End
    Else
    Begin
        Writeln('Jugador',quien,' Muestra una carta a Jugador'
            ,jugadorTurno.posicion,' La carta es: ');
    End;
    If ( carta[muestro].arma = sospech.arma ) 
    and ( m-1 <= 5 - jugadorTurno.conta.arma) Then
    Begin
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,0);
        jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
    End;
    If ( carta[muestro].prj = sospech.prj ) 
    and ( n-1 <= 5 - jugadorTurno.conta.prj) Then
    Begin 
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,1);
        jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
    End;
    If ( carta[muestro].habt = sospech.habt ) 
    and ( h <= 8 - jugadorTurno.conta.habt ) Then
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
    quien : integer;



BEGIN
Randomize();
carta[0].arma := revolver;
carta[1].prj := SenorVerde;
carta[2].habt := Salon;
sospech.arma := revolver;
sospech.prj := SenorVerde;
sospech.habt := Salon;
ha := 5; 
ma := 5;
na := 2;
ultimoj := 5;
Writeln;
quien := 4;
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
Refuta_computadora(carta,jugadores[1],k,quien,ma,na,ha,sospech);

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

