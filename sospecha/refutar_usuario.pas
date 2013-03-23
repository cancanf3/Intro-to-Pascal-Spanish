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
 
Procedure Refuta_Usuario ( carta : Array of sbr; jugadorTurno : user;
                           sospech : sbr; k : integer; 
                           m : integer; n : integer; h : integer);
Var
    i : integer; // Variable para iterar.
    s : string; // Variable de mensajes.
    l : integer; // Variable de lectura robusta.
Begin
    Writeln('En tu mano hay ',k,
        ' cartas que se sospechan, cual quieres mostrar?');
    For i := 0 to 2 Do
    Begin
        If ( carta[i].arma = carta[i].arma ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].arma);
        End;

        If ( carta[i].prj = carta[i].prj ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].prj);
        End;

        If ( carta[i].habt = carta[i].habt ) Then
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
    Until ( n > 0 ) and ( n < 4 );

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
        jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
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
    
    sospecha  : sbr; // variable para realizar sospechas
    acusacion : sbr; // variable para realizar acusaciones
    ultimoJ : integer;
    sospecha_lista : Array[0..323] of sbr;
    sospecha_conta : integer;
   
    SioNo : boolean;
    juegoActivo : boolean;




BEGIN


END.
