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
	descarte = Record // Variable contadora de descarte para las pc 
        arma : integer;
        habt : integer;
        prj  : integer;
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
        mano : array[0..2] of pha;
		donde : h;
		peon  : p;  // Ficha que usa para jugar
		lista : lista_cartas;  // Lista de cartas
        conta : descarte;
     posicion : integer;
        
            End;
 
    Procedure Swap_descarte(var player : user; n : integer; 
                                m : integer; k : string);
    Var
	tmp1 : a;
    tmp2 : h;
    tmp3 : p;
    Begin
        Case k of 
            'arma' :
            Begin
	            tmp1 := player.lista.arma[n];
	            player.lista.arma[n] := player.lista.arma[m];
	            player.lista.arma[m] := tmp1;
            End;
            'habt' :
            Begin
	            tmp2 := player.lista.habt[n];
	            player.lista.habt[n] := player.lista.habt[m];
	            player.lista.habt[m] := tmp2;
            End;
            'prj' :
            Begin
	            tmp3 := player.lista.prj[n];
	            player.lista.prj[n] := player.lista.prj[m];
	            player.lista.prj[m] := tmp3;
            End;
        End;
    End;
    (* Funcion que genera numeros aleatorios en un rango dado *)
    Function Aleatorio(inicio : integer; tope : integer) : integer;
    Var 
	amplitud : integer;
    Begin
	amplitud := (tope - inicio) + 1;
	Aleatorio := Random(amplitud) + inicio;
    End;

Procedure sospecha( var sospechaON : boolean; var player : user ; 
                    var pc : array of user; phaInit : cartas );
Var
    sospech : sbr; // Variable que guarda la sospecha
    muestro : integer; // Variable que permite determinar que carta mostrar
    h,n,m,l : integer; // variables que permiten programacion robusta
    s : string; // Variable que muestra mensajer al usuario
    k : integer; // determina cuantas cartas son sospechadas por mano
    carta : Array[0..2] of pha; // Arreglo que guarda las cartas sospechadas
    i,j,co : integer; // Contadores 

Begin

sospechaON := True;

If ( player.usuario ) Then
Begin
    sospech.habt := player.donde;

    For i := 0 to 8 Do
    Begin
        If (sospech.habt = player.lista.habt[i] ) Then
        Begin
            h := i;
        End;
    End;

    (* Elegir arma a sospechar *)

    Writeln('Armas para sospechar');
    For i := 0 to 5 Do
    Begin
        Writeln(i+1,'.- ',pc[0].lista.arma[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - player.conta.arma) to 5 Do
    Begin
        Writeln(pc[0].lista.arma[i]);
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

    sospech.arma := phaInit[ m + 14 ];

    (* Elegir personaje a sospechar *)
  
    Writeln('Personajes no descartados');
    For i := 0 to 5 Do
    Begin
        Writeln(i+1,'.- ',player.lista.prj[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - player.conta.prj) to 5 Do
    Begin
        Writeln(player.lista.prj[i]);
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
    
    sospech.prj := phaInit [ n - 1];

    (* Mover el personaje al lugar de la sospecha *)

    For i := 1 to 5 Do
    Begin
        If ( sospech.prj = pc[i].peon ) Then
        Begin
            pc[i].donde := sospech.habt;
        End;
    End;

    (* Match de las cartas *)
   
    k := 0;
    For i := ( player.posicion + 1 ) to 5 Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to 2 Do
            Begin
                If ( pc[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j] := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                End
                Else 
                Begin    
                    If ( pc[i].mano[j] = sospech.prj ) Then
                    Begin
                        carta[j] := sospech.prj;
                        sospechaON := false;
                        k := k + 1;
                    End
                    Else
                    Begin
                        carta[j] := sospech.habt;
                        sospechaON := false;
                        k := k + 1;
                    End;
                End;
            End;
            muestro := Aleatorio(0,k-1);
            Case muestro of
                0 :
                Begin
                    Writeln(' Computadora',pc[i].posicion,' te muestra '
                            ,carta[0]);
                    If ( carta[0] = sospech.arma ) 
                    and ( m-1 <= 5 - player.conta.arma) Then
                    Begin
                        Swap_descarte(player,5-player.conta.arma,m-1,'arma');
                        player.conta.arma := player.conta.arma + 1;
                    End;
                    If ( carta[0] = sospech.prj ) 
                    and ( n-1 <= 5 - player.conta.prj) Then
                    Begin 
                        Swap_descarte(player,5-player.conta.prj,n-1,'prj');
                        player.conta.prj := player.conta.prj + 1;
                    End;
                    If ( carta[0] = sospech.habt ) 
                    and ( h <= 8 - player.conta.habt ) Then
                    Begin 
                        Swap_descarte(player,8-player.conta.habt,h,'habt');
                        player.conta.prj := player.conta.habt + 1;
                    End;
                End;
                1 :
                Begin
                    Writeln(' Computadora',pc[i].posicion,' te muestra '
                            ,carta[1]);
                    If ( carta[1] = sospech.arma ) 
                    and ( m - 1 <= 5 - player.conta.arma) Then
                    Begin
                        Swap_descarte(player,5-player.conta.arma,m-1,'arma');
                        player.conta.arma := player.conta.arma + 1;
                    End;
                    If ( carta[1] = sospech.prj ) 
                    and ( n - 1 <= 5 - player.conta.prj ) Then
                    Begin 
                        Swap_descarte(player,5-player.conta.prj,n-1,'prj');
                        player.conta.prj := player.conta.prj + 1;
                    End;
                    If ( carta[1] = sospech.habt ) 
                    and ( h <= 8 - player.conta.habt ) Then
                    Begin 
                        Swap_descarte(player,8-player.conta.habt,h,'habt');
                        player.conta.prj := player.conta.habt + 1;
                    End;
                End;
                2 :
                Begin
                    Writeln(' Computadora',pc[i].posicion,' te muestra '
                            ,carta[2]);
                    If ( carta[2] = sospech.arma ) 
                    and ( m - 1 <= 5 - player.conta.arma ) Then
                    Begin
                        Swap_descarte(player,5-player.conta.arma,m-1,'arma');
                        player.conta.arma := player.conta.arma + 1;
                    End;
                    If ( carta[2] = sospech.prj ) 
                    and ( n - 1 <= 5 - player.conta.prj ) Then
                    Begin 
                        Swap_descarte(player,5-player.conta.prj,n-1,'prj');
                        player.conta.prj := player.conta.prj + 1;
                    End;
                    If ( carta[2] = sospech.habt ) 
                    and ( h <= 8 - player.conta.habt ) Then
                    Begin 
                        Swap_descarte(player,8-player.conta.habt,h,'habt');
                        player.conta.prj := player.conta.habt + 1;
                    End;
                End;
            End;
        End;
    End;
End
Else
Begin
    sospech.habt := player.donde;
    For i := 0 to 8 Do
    Begin
        If (sospech.habt = player.lista.habt[i] ) Then
        Begin
            h := i;
        End;
    End;
    (* Computadora elegira arma a sospechar *)

    n := Aleatorio(0,5-player.conta.arma);
    sospech.arma := player.lista.arma[n];
    Writeln('La computadora',player.posicion,
        ' sospecha que el arma usada en el asesinato fue: ',sospech.arma);
    (* Computadora elegira personaje a sospechar *)
    m := Aleatorio(0,5-player.conta.prj);
    sospech.prj := player.lista.arma[m];   
    Writeln('La computadora',player.posicion,
        'sospecha quien mato a Mr.Black fue: ',sospech.prj);
    (* Mover el personaje al lugar de la sospecha *)

    For i := 1 to 5 Do
    Begin
        If ( sospech.prj = pc[i].peon ) Then
        Begin
            pc[i].donde := sospech.habt;
        End;
    End;

    (* Match de las cartas *)
    k := 0; 
    For i := ( player.posicion + 1 ) to 5 Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to 2 Do
            Begin
                If ( pc[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j] := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                End
                Else 
                Begin    
                    If ( pc[i].mano[j] = sospech.prj ) Then
                    Begin
                        carta[j] := sospech.prj;
                        sospechaON := false;
                        k := k + 1;
                    End
                    Else
                    Begin
                        carta[j] := sospech.habt;
                        sospechaON := false;
                        k := k + 1;
                    End;
                End;
            End;

            muestro := Aleatorio(0,k-1);
            Case muestro of
                0 :
                Begin
                    If ( carta[0] = sospech.arma ) Then
                    Begin
                        Swap_descarte(player,5-player.conta.arma,m,'arma');
                        player.conta.arma := player.conta.arma + 1;
                    End;
                    If ( carta[0] = sospech.prj ) Then
                    Begin 
                        Swap_descarte(player,5-player.conta.prj,n,'prj');
                        player.conta.prj := player.conta.prj + 1;
                    End;
                    If ( carta[0] = sospech.habt ) Then
                    Begin 
                        Swap_descarte(player,8-player.conta.habt,h,'habt');
                        player.conta.prj := player.conta.habt + 1;
                    End;
                End;
                1 :
                Begin
                    If ( carta[1] = sospech.arma ) Then
                    Begin
                        Swap_descarte(player,5-player.conta.arma,m,'arma');
                        player.conta.arma := player.conta.arma + 1;
                    End;
                    If ( carta[1] = sospech.prj ) Then
                    Begin 
                        Swap_descarte(player,5-player.conta.prj,n,'prj');
                        player.conta.prj := player.conta.prj + 1;
                    End;
                    If ( carta[1] = sospech.habt ) Then
                    Begin 
                        Swap_descarte(player,8-player.conta.habt,h,'habt');
                        player.conta.prj := player.conta.habt + 1;
                    End;
                End;
                2 :
                Begin
                    If ( carta[2] = sospech.arma ) Then
                    Begin
                        Swap_descarte(player,5-player.conta.arma,m,'arma');
                        player.conta.arma := player.conta.arma + 1;
                    End;
                    If ( carta[2] = sospech.prj ) Then
                    Begin 
                        Swap_descarte(player,5-player.conta.prj,n,'prj');
                        player.conta.prj := player.conta.prj + 1;
                    End;
                    If ( carta[2] = sospech.habt ) Then
                    Begin 
                        Swap_descarte(player,8-player.conta.habt,h,'habt');
                        player.conta.prj := player.conta.habt + 1;
                    End;
                End;
            End;
            Writeln(' La computadora',pc[i].posicion,
                ' Le muestra una carta a la computadora',player.posicion);
        End;
    End;

    For i := 0 to ( player.posicion - 1 ) Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to 2 Do
            Begin
                If ( pc[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j] := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                End
                Else 
                Begin    
                    If ( pc[i].mano[j] = sospech.prj ) Then
                    Begin
                        carta[j] := sospech.prj;
                        sospechaON := false;
                        k := k + 1;
                    End
                    Else
                    Begin
                        carta[j] := sospech.habt;
                        sospechaON := false;
                        k := k + 1;
                    End;
                End;
            End;

        (* Si el usuario tiene una carta de la sospecha *)

            If ( pc[i].usuario ) and (sospechaON <> true ) Then
            Begin
                Writeln('En tu mano hay ',k,
                    ' cartas que se sospechan, cual quieres mostrar?');
                For co := 0 to 2 Do
                Begin
                Writeln(co + 1,'.- ',carta[co]);
                End;
                s := 'elige el numero de la carta a mostrar';
                Repeat
                Begin
                    Writeln(s);
                    Read(l);
                    S := ' te equivocaste, elige otra vez';
                End
                Until ( n > 0 ) and ( n < 4 );

                If ( carta[l-1] = sospech.arma ) Then
                Begin
                    Swap_descarte(player,5-player.conta.arma,m,'arma');
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[l-1] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player,5-player.conta.prj,n,'prj');
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[l-1] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player,8-player.conta.habt,h,'habt');
                    player.conta.prj := player.conta.habt + 1;
                End;
            End
            Else
            Begin
                muestro := Aleatorio(0,k-1);
                Case muestro of
                    0 :
                    Begin
                        Writeln(' Computadora',pc[i].posicion,' te muestra '
                                ,carta[0]);
                        If ( carta[0] = sospech.arma ) Then
                        Begin
                            Swap_descarte(player,5-player.conta.arma,m,'arma');
                            player.conta.arma := player.conta.arma + 1;
                        End;
                        If ( carta[0] = sospech.prj ) Then
                        Begin 
                            Swap_descarte(player,5-player.conta.prj,n,'prj');
                            player.conta.prj := player.conta.prj + 1;
                        End;
                        If ( carta[0] = sospech.habt ) Then
                        Begin 
                            Swap_descarte(player,8-player.conta.habt,h,'habt');
                            player.conta.prj := player.conta.habt + 1;
                        End;
                    End;
                    1 :
                    Begin
                        Writeln(' Computadora',pc[i].posicion,' te muestra '
                                ,carta[1]);
                        If ( carta[1] = sospech.arma ) Then
                        Begin
                            Swap_descarte(player,5-player.conta.arma,m,'arma');
                            player.conta.arma := player.conta.arma + 1;
                        End;
                        If ( carta[1] = sospech.prj ) Then
                        Begin 
                            Swap_descarte(player,5-player.conta.prj,n,'prj');
                            player.conta.prj := player.conta.prj + 1;
                        End;
                        If ( carta[1] = sospech.habt ) Then
                        Begin 
                            Swap_descarte(player,8-player.conta.habt,h,'habt');
                            player.conta.prj := player.conta.habt + 1;
                        End;
                    End;
                    2 :
                    Begin
                        Writeln(' Computadora',pc[i].posicion,' te muestra '
                                ,carta[2]);
                        If ( carta[2] = sospech.arma ) Then
                        Begin
                            Swap_descarte(player,5-player.conta.arma,m,'arma');
                            player.conta.arma := player.conta.arma + 1;
                        End;
                        If ( carta[2] = sospech.prj ) Then
                        Begin 
                            Swap_descarte(player,5-player.conta.prj,n,'prj');
                            player.conta.prj := player.conta.prj + 1;
                        End;
                        If ( carta[2] = sospech.habt ) Then
                        Begin 
                            Swap_descarte(player,8-player.conta.habt,h,'habt');
                            player.conta.prj := player.conta.habt + 1;
                        End;
                    End;
                End;
                Writeln(' La computadora',pc[i].posicion,
                    ' Le muestra una carta a la computadora',player.posicion);
            End;
        End;
    End;
End;
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
    
    
    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario
    i,j,co  : integer; // Variables para Iteracion y contadores
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
       
    moverA : h;
    

    sospechaON : boolean;
    SioNo : boolean;
Begin
    For i := 0 to 5 Do // Inicializo a todos los jugadores
    Begin
        pc[i].conta.arma := 0;
        pc[i].conta.habt := 0;
        pc[i].conta.prj  := 0;
    	pc[i].x := 2;
    	pc[i].y := 2;
    	pc[i].usuario := False;
    	pc[i].donde := Vestibulo;
        pc[i].posicion := i;
        For j := 0 to 5 Do
        Begin
            pc[i].lista.arma[j] := phaInit[j + 15 ];
        End;
        For j := 0 to 5 Do
        Begin
            pc[i].lista.prj[j] := phaInit[j];
        End;
        For j := 0 to 8 Do
        Begin
            pc[i].lista.habt[j] := phaInit[j + 6 ];
        End;
    End;

End.



