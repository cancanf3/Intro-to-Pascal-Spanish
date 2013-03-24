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



Procedure Acusacion_Usuario( var acus : sbr; var jugadorTurno : user; sobre : sbr;
                            phaInicio : cartas; var juegoActivo : boolean;
                            var jugadores : Array of user );
Var 
    i : integer; // Variable de iteracion.
    n,m,h : integer; // Variable que permite lectura robusta
Begin

    (* Acusacion del Personaje *)
    Writeln('Quien Mato a Mr.Black? ');
    Writeln;

    Writeln('Personajes descartados'); 
    Writeln;
    For i := ( 5 - jugadorTurno.conta.prj ) to 5 Do
    Begin
        Writeln(jugadorTurno.lista.prj[i]);
    End;
    Writeln;
    Writeln('Personajes Para Acusar ');
    Writeln;
    For i := 0  to 5 Do
    Begin
        Writeln(i+1,'.- ',phaInicio[i]);
    End;
    Repeat
    Begin
        Writeln;
        Writeln(' Elige una opcion: ');
        Readln(n);
    End
    Until ( n < 7 ) and ( n > 0 );

    acus.prj := phaInicio[n-1];
    MoverSospechoso(acus);
    (* Acusacion del arma *)

    Writeln;
    Writeln('Que arma se uso para asesinarlo? ');
    Writeln;
    Writeln('Armas descartadas ');
    Writeln;
    For i := ( 5 - jugadorTurno.conta.arma ) to 5 Do
    Begin
        Writeln(jugadorTurno.lista.arma[i]);
    End;
    Writeln;
    Writeln('Armas para acusar');
    For i := 15 to 20 Do
    Begin
        Writeln( i - 14,'.- ',phaInicio[i]);
    End;
    Repeat
    Begin
        Writeln;
        Writeln(' Elige una opcion');
        Readln(m);
    End
    Until ( n < 7 ) and ( n > 0 ); 

    acus.arma := phaInicio[m+14];

    (* Acusacion de la habitacion *)

    Writeln;
    Writeln('En que lugar crees que ocurrio el asesinato?' );
    Writeln;
    Writeln('Habitaciones descartadas ');
    Writeln;
    For i := ( 8 - jugadorTurno.conta.habt ) to 8 Do
    Begin
        Writeln(jugadorTurno.lista.habt[i]);
    End;
    Writeln;
    Writeln('Habitaciones donde acusar ');
    For i := 6 to 14 Do
    Begin
        Writeln(i - 5,'.- ',phaInicio[i]);
    End;
    Repeat
    Begin
        Writeln;
        Writeln(' Elige una opcion ');
        Readln(h);
    End
    Until ( h > 0 ) and ( h < 10 );
    
    acus.habt := phaInicio[h+5];

    (* Verificacion de la acusacion *)
        
    Eliminar(jugadorTurno,acus,sobre);
    Fin(jugadores,sobre,acus,juegoActivo);


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


BEGIN

ultimoj := 5;
sobre.prj := phaInicio[2];
sobre.habt := phaInicio[13];
sobre.arma := phaInicio[17];



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
 
Acusacion_Usuario(acus,jugadores[0],sobre,phaInicio,juegoActivo,jugadores);

Writeln('Vida del jugador',jugadores[0].vida);
Writeln;
Writeln(juegoActivo);
Writeln('Arma',acus.arma);
Writeln('prj',acus.prj);
Writeln('habt',acus.habt);
Writeln(sobre.arma);
Writeln(sobre.prj);
Writeln(sobre.habt);
END.

