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



Procedure MoverSospechoso (sospeAcu : sbr; // Acusacion o Sospecha realizada
				ultimoJ : integer; // Numero de Computadoras
				var jugador : user; // Jugador que Sopecho/Acuso 
				var jugadores : array of user);
    Var
	i : integer;
    Begin
	
	For i := 0 To ultimoJ Do
	Begin
	    If (jugadores[i].peon = sospeAcu.prj) 
		And jugadores[i].vida  Then
	    Begin
		writeln('Posicion del que realiza la sospecha: ', jugador.donde);
		writeln('Posicion previa del sospechoso: ', jugadores[i].donde);
		jugadores[i].x := jugador.x;
		jugadores[i].y := jugador.y;
		jugadores[i].donde := jugador.donde;
		writeln('Movi al jugador(', i + 1, ') a la posicion del jugador(', jugador.posicion + 1,'): ', jugadores[i].donde);
	    End;
	
	End;
    End;

Procedure Eliminar(var jugador : user;
			acusacion : sbr;
			sobre : sbr);
    Begin
	If (acusacion.prj <> sobre.prj) 
	    Or (acusacion.habt <> sobre.habt ) 
	    Or (acusacion.arma <> sobre.arma ) Then
	Begin
	    jugador.vida := False;
	End
    End;
    
Procedure Fin(jugadores : array of user;
              acusacion: sbr; sobre : sbr;
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

Function Aleatorio(inicio : integer; tope : integer) : integer;
    Var 
	amplitud : integer;
    Begin
	amplitud := (tope - inicio) + 1;
	Aleatorio := Random(amplitud) + inicio;
    End;



Procedure Acusacion_Computadora( var jugadorTurno : user; sobre : sbr;
                                 phaInicio : cartas; sospech : sbr;
                                 var sospecha_conta : integer;
                                 sospecha_lista : Array of sbr; 
                                 jugadores : Array of user;
                                 sospechaON : boolean; ultimoj : integer;
                                 var juegoActivo : boolean; var acus : sbr);
Var 
    i : integer; // Variable de iteracion.
    p,a,h : integer; // Permite elegir aleatoriamente la acusacion.
    procede : boolean; // Determina que la acusacion puede proceder.
Begin

    (* Formulacion de la Acusacion *)

    If sospechaON Then
    Begin
        acus.arma := sospech.arma;
        acus.prj := sospech.prj;
        acus.habt := sospech.habt;
    End
    Else
    Begin
        procede := True;
        Repeat
        Begin
        
        If not procede Then
        Begin
            p := Aleatorio(0,5 - jugadorTurno.conta.prj );
            a := Aleatorio(0,5 - jugadorTurno.conta.arma );
            h := Aleatorio(0,8 - JugadorTurno.conta.habt);

            acus.prj := jugadorTurno.lista.prj[p];
            acus.arma := jugadorTurno.lista.arma[a];
            acus.habt := jugadorTurno.lista.habt[h];
        End;            
            For i := 0 to sospecha_conta Do
            Begin
                If ( acus.arma = sospecha_lista[i].arma ) and
                   ( acus.habt = sospecha_lista[i].habt ) and
                   (  acus.prj = sospecha_lista[i].prj  ) Then
                Begin
                    procede := false;
                    Writeln('lo logra',sospecha_conta);
                End
                Else
                Begin
                    procede := true;
                End;

            End;
        End
        Until ( procede = true );

        MoverSospechoso(acus,ultimoj,jugadorTurno,jugadores);
        Writeln; 
        Writeln('Jugador',jugadorTurno.posicion + 1,' ha realizado una acusacion');
        Writeln;
        Writeln('Arma elegida: ',acus.arma);
        Writeln;
        Writeln('Personaje elegido: ',acus.prj);
        Writeln;
        Writeln('Haitacion elegida: ',acus.habt);
    End;

    (* Verificacion de la acusacion *)
    
    Eliminar(jugadorTurno,acus,sobre);
    Fin(jugadores,acus,sobre,juegoActivo);
    

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
    acus : sbr; // variable para realizar acusaciones
    ultimoJ : integer;
    sospecha_lista : Array[0..323] of sbr;
    sospecha_conta : integer;
    carta : Array[0..5] of sbr;
    ha,ma,na : integer;
    SioNo : boolean;
    juegoActivo : boolean;
    k : integer;
    quien : integer;
    sospechaON : boolean;


BEGIN
randomize;
ultimoj := 5;
sobre.prj := phaInicio[2];
sobre.habt := phaInicio[13];
sobre.arma := phaInicio[17];
sospecha_conta := 1;
sospecha_lista[0].prj := phaInicio[3];
sospecha_lista[0].habt := phaInicio[14];
sospecha_lista[0].arma := phaInicio[18];
sospechaON := False;
juegoActivo := True;
sospecha_conta := 0;
acus.prj := phaInicio[3];
acus.habt := phaInicio[14];
acus.arma := phaInicio[18];
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

For i := 0 to ultimoJ Do // Inicializo a todos los jugadores
	Begin
	    jugadores[i].conta.arma := 0;
	    jugadores[i].conta.habt := 0;
	    jugadores[i].conta.prj  := 0;
	    jugadores[i].conta.cartas := -1;
        jugadores[i].peon := phaInicio[i];
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
 
Acusacion_Computadora(jugadores[0],sobre,phaInicio,sospech,sospecha_conta,
                      sospecha_lista,jugadores,sospechaON,
                      ultimoj,juegoActivo,acus);

Writeln('Vida del jugador',jugadores[0].vida);
Writeln;
Writeln(juegoActivo);
Writeln('Arma ',acus.arma);
Writeln('prj ',acus.prj);
Writeln('habt ',acus.habt);
Writeln(sobre.arma);
Writeln(sobre.prj);
Writeln(sobre.habt);
for i := 0 to ultimoj Do
Begin
    Writeln(jugadores[i].peon,'.-',i);
End;
END.

