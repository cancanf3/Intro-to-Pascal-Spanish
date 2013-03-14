Program sospecha;

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
	descarte = Record // Variable contadora de descarte para las jugadores 
        arma : integer;
        habt : integer;
        prj  : integer;
               End;
    lista_cartas = Record
        arma : armas;
        habt : habts;
        prj  : prjs; 
                   End;	

    usuario =  Record
		x : integer;
		y : integer;
		usuario : boolean;
        vida : boolean;
        mano : array[0..2] of pha;
		donde : h;
		peon  : p;  // Ficha que usa para jugar
		lista : lista_cartas;  // Lista de cartas
        conta : descarte;
     posicion : integer;
        
            End;
 
    (* Funcion que genera numeros aleatorios en un rango dado *)
    Function Aleatorio(inicio : integer; tope : integer) : integer;
    Var 
	amplitud : integer;
    Begin
	amplitud := (tope - inicio) + 1;
	Aleatorio := Random(amplitud) + inicio;
    End;

Procedure sospecha( var sospechaON : boolean; var jugadorTurno : usuario ; 
                    var jugadores : array of usuario; phaInicio : cartas; 
                        sospech : sbr; ultimoJ : integer);
Var
    h,n,m,l : integer; // variables que permiten programacion robusta
    s : string; // Variable que muestra mensaje al usuario
    k : integer; // determina cuantas cartas son sospechadas por mano
    carta : Array[0..2] of pha; // Arreglo que guarda las cartas sospechadas
    i,j,co : integer; // Contadores 
    humano : boolean; // determina si el usuario ha mostrado una carta
    quien  : integer; // Determina que jugador hizo match de las cartas
Begin

sospechaON := True;
humano := false;

    sospech.habt := jugadorTurno.donde;

    For i := 0 to 8 Do
    Begin
        If (sospech.habt = jugadorTurno.lista.habt[i] ) Then
        Begin
            h := i;
        End;
    End;

    (* Elegir arma a sospechar *)

    Writeln('Armas para sospechar');
    For i := 0 to 5 Do
    Begin
        Writeln(i+1,'.- ',jugadores[0].lista.arma[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - jugadorTurno.conta.arma) to 5 Do
    Begin
        Writeln(jugadores[0].lista.arma[i]);
    End;
   
    s := 'Arma a sospechar';

    (* Lectura Robusta del arma a sospechar *) 
    
    Repeat
    Begin
        Writeln(s);
        Readln(m);
        s := 'Arma incorrecta, Elegir otra vez';
    End
    Until (m < 7 ) and ( m > 0 );

    sospech.arma := phaInicio[ m + 14 ];

    (* Elegir personaje a sospechar *)
  
    Writeln('Personajes no descartados');
    For i := 0 to 5 Do
    Begin
        Writeln(i+1,'.- ',jugadorTurno.lista.prj[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - jugadorTurno.conta.prj) to 5 Do
    Begin
        Writeln(jugadorTurno.lista.prj[i]);
    End;
    
    s := 'Personaje a sospechar: ';

    (* Lectura Robusta del personaje a sospechar *)

    Repeat 
    Begin
        Writeln(s);
        Readln(n);
        s := 'Personaje incorrecto, Elegir otra vez'
    End
    Until ( n < 7 ) and ( n > 0);
    
    sospech.prj := phaInicio [ n - 1];

    (* Mover el personaje al lugar de la sospecha *)

    For i := 1 to 5 Do
    Begin
        If ( sospech.prj = jugadores[i].peon ) Then
        Begin
            jugadores[i].donde := sospech.habt;
        End;
    End;

    (* Match de las cartas *)
   
    k := 0;
    quien := 0;
    For i := ( jugadorTurno.posicion + 1 ) to 5 Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to (* Variable cantidad de cartas por player *) Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j] := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End
                Else 
                Begin    
                    If ( jugadores[i].mano[j] = sospech.prj ) Then
                    Begin
                        carta[j] := sospech.prj;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End
                    Else
                    Begin
                        carta[j] := sospech.habt;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                End;
            End;
        End;
    End;
    Refuta_computadora(carta,jugadorTurno,k,quien,m,n,h);
    If sospechaON Then
    Begin
        For i := 1 to 5 Then
        Begin
            jugadores[i].sospecha[jugadores[i].conta.sospecha].arma 
            := sospech.arma;

            jugadores[i].sospecha[jugadores[i].conta.sospecha].prj 
            := sospech.prj;

            jugadores[i].sospecha[jugadores[i].conta.sospecha].habt 
            := sospech.habt;

            jugadores[i].conta.sospecha := jugadores[i].conta.sospecha + 1;
        End;
    End;
End;

Procedure sospecha_computadora ( var sospechaON : boolean; var jugadorTurno : usuario ; 
                    var jugadores : array of usuario; phaInicio : cartas; 
                        sospech : sbr; ultimoJ : integer);
Var
    h,n,m,l : integer; // variables que permiten programacion robusta
    s : string; // Variable que muestra mensaje al usuario
    k : integer; // determina cuantas cartas son sospechadas por mano
    carta : Array[0..2] of pha; // Arreglo que guarda las cartas sospechadas
    i,j,co : integer; // Contadores 
    humano : boolean; // determina si el usuario ha mostrado una carta
    Begin
    
    
    sospechaON := True;
    humano := false;

    sospech.habt := jugadorTurno.donde;
    For i := 0 to 8 Do
    Begin
        If (sospech.habt = jugadorTurno.lista.habt[i] ) Then
        Begin
            h := i;
        End;
    End;
    (* Computadora elegira arma a sospechar *)

    n := Aleatorio(0,5-jugadorTurno.conta.arma);
    sospech.arma := jugadorTurno.lista.arma[n];
    Writeln('La computadora',jugadorTurno.posicion,
        ' sospecha que el arma usada en el asesinato fue: ',sospech.arma);
    (* Computadora elegira personaje a sospechar *)
    m := Aleatorio(0,5-jugadorTurno.conta.prj);
    sospech.prj := jugadorTurno.lista.arma[m];   
    Writeln('La computadora',jugadorTurno.posicion,
        'sospecha quien mato a Mr.Black fue: ',sospech.prj);
    (* Mover el personaje al lugar de la sospecha *)

    For i := 1 to 5 Do
    Begin
        If ( sospech.prj = jugadores[i].peon ) Then
        Begin
            jugadores[i].donde := sospech.habt;
        End;
    End;

    (* Match de las cartas *)
    k := 0; 
    For i := ( jugadorTurno.posicion + 1 ) to 5 Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to 2 Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j] := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End
                Else 
                Begin    
                    If ( jugadores[i].mano[j] = sospech.prj ) Then
                    Begin
                        carta[j] := sospech.prj;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End
                    Else
                    Begin
                        carta[j] := sospech.habt;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                End;
            End;
        End;
    End;      
            
    For i := 0 to ( jugadorTurno.posicion - 1 ) Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to 2 Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j] := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End
                Else 
                Begin    
                    If ( jugadores[i].mano[j] = sospech.prj ) Then
                    Begin
                        carta[j] := sospech.prj;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End
                    Else
                    Begin
                        carta[j] := sospech.habt;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                End;
                If ( sospechaON = false ) and ( jugadores[i].usuario ) Then
                Begin
                    humano := True
                End;
            End;
        End;
        (* Si el usuario tiene una carta de la sospecha *)

        If ( jugadores[i].usuario ) and (sospechaON = false ) Then
        Begin
            Refuta_Usuario(carta,jugadorTurno,k,m,n,h);
        End
        Else
        Begin    
            If ( sospechaON = false ) and ( humano = false ) Then
            Begin
                Refuta_computadora (carta,jugadorTurno,k,quien,m,n,h);
            End;
        End;
    End;

    If sospechaON Then
    Begin
        For i := 1 to 5 Then
        Begin
            jugadores[i].sospecha[jugadores[i].conta.sospecha].arma 
            := sospech.arma;

            jugadores[i].sospecha[jugadores[i].conta.sospecha].prj 
            := sospech.prj;

            jugadores[i].sospecha[jugadores[i].conta.sospecha].habt 
            := sospech.habt;

            jugadores[i].conta.sospecha := jugadores[i].conta.sospecha + 1;
        End;
    End;
End;

Var
    (* 
     * Personajes: 0 al 5
     * Habitaciones: del 6 al 14
     * Armas: 15 20 
    *)
    phaInicio : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
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
    
    
    jugadores : Array[0..5] of usuario; // Arreglo de Jugadores jugadores[0]:Usuario
    i,j,co  : integer; // Variables para Iteracion y contadores
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
       
    moverA : h;
    

    sospechaON : boolean;
    SioNo : boolean;
Begin
    For i := 0 to 5 Do // Inicializo a todos los jugadores
    Begin
        jugadores[i].conta.arma := 0;
        jugadores[i].conta.habt := 0;
        jugadores[i].conta.prj  := 0;
    	jugadores[i].x := 2;
    	jugadores[i].y := 2;
    	jugadores[i].usuario := False;
    	jugadores[i].donde := Vestibulo;
        jugadores[i].posicion := i;
        For j := 0 to 5 Do
        Begin
            jugadores[i].lista.arma[j] := phaInicio[j + 15 ];
        End;
        For j := 0 to 5 Do
        Begin
            jugadores[i].lista.prj[j] := phaInicio[j];
        End;
        For j := 0 to 8 Do
        Begin
            jugadores[i].lista.habt[j] := phaInicio[j + 6 ];
        End;
    End;

End.



