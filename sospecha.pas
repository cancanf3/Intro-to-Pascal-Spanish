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
	tmp : user;
    Begin
        Case k of 
            'arma' :
            Begin
	            tmp := player.lista.arma[n];
	            player.lista.arma[n] := player.lista.arma[m];
	            player.lista.arma[m] := tmp;
            End;
            'habt' :
            Begin
	            tmp := player.lista.habt[n];
	            player.lista.habt[n] := player.lista.habt[m];
	            player.lista.habt[m] := tmp;
            End;
            'prj' :
            Begin
	            tmp := player.lista.prj[n];
	            player.lista.prj[n] := player.lista.prj[m];
	            player.lista.prj[m] := tmp;
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
    n,m,l : integer; // variables que permiten programacion robusta
    s : string; // Variable que muestra mensajer al usuario
    k : integer; // determina cuantas cartas son sospechadas por mano
    carta : Array[0..2] of pha; // Arreglo que guarda las cartas sospechadas
    i,j,co : integer; // Contadores 

Begin

If ( player.usuario ) Then
Begin
    sospech.habt := player.donde;

    (* Elegir arma a sospechar *)

    Writeln('Armas no descartadas');
    For i := 0 to ( 5 - player.conta.arma ) Do
    Begin
        Writeln(i+1,'.- ',pc[0].lista.arma[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - player.conta.arma) to 5 Do
    Begin
        Writeln(pc[0].lista.arma[i]);
    End;
   
    s := 'Arma a sospechar: ';
   
    Repeat
    Begin
        Writeln(s);
        Readln(m);
        s := 'Arma incorrecta, Elegir otra vez';
    End
    Until (m < 7  - player.conta.prj ) and ( m > 0 );

    sospech.arma := phaInit[ m + 15 ];

    (* Elegir personaje a sospechar *)
  
    Writeln('Personajes no descartados');
    For i := 0 to ( 5 - player.conta.prj ) Do
    Begin
        Writeln(i+1,'.- ',player.lista.prj[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - player.conta.prj) to 5 Do
    Begin
        Writeln(player.lista.prj[i]);
    End;
    
    s := 'Personaje a sospechar: ';
    Repeat 
    Begin
        Writeln(s);
        Readln(n);
        s := 'Personaje incorrecto, Elegir otra vez'
    End
    Until ( n < 7 - player.conta.prj) and ( n > 0);
    
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
        End;

        muestro := Aleatorio(0,k);
        Case muestro of
            0 :
            Begin
                Writeln(' Computadora',pc[i].posicion,' te muestra '
                        ,carta[0]);
                If ( carta[0] = sospech.arma ) Then
                Begin
                    Swap_descarte(player.lista.arma[5-player.conta.arma]
                                    ,player.lista.arma[m]);
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[0] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player.lista.prj[5-player.conta.prj]
                                    ,player.lista.prj[m]);
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[0] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player.lista.habt[8-player.conta.habt]
                                    ,player.lista.habt[m]);
                    player.conta.prj := player.conta.habt + 1;
                End;
            End;
            1 :
            Begin
                Writeln(' Computadora',pc[i].posicion,' te muestra '
                        ,carta[1]);
                If ( carta[1] = sospech.arma ) Then
                Begin
                    Swap_descarte(player.lista.arma[5-player.conta.arma]
                                    ,player.lista.arma[m]);
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[1] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player.lista.prj[5-player.conta.prj]
                                    ,player.lista.prj[m]);
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[1] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player.lista.habt[8-player.conta.habt]
                                    ,player.lista.habt[m]);
                    player.conta.prj := player.conta.habt + 1;
                End;
            End;
            2 :
            Begin
                Writeln(' Computadora',pc[i].posicion,' te muestra '
                        ,carta[2]);
                If ( carta[2] = sospech.arma ) Then
                Begin
                    Swap_descarte(player.lista.arma[5-player.conta.arma]
                                    ,player.lista.arma[m]);
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[2] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player.lista.prj[5-player.conta.prj]
                                    ,player.lista.prj[m]);
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[2] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player.lista.habt[8-player.conta.habt]
                                    ,player.lista.habt[m]);
                    player.conta.prj := player.conta.habt + 1;
                End;
            End;
        End;
    End;
End
Else
Begin
    sospech.habt := player.donde;
    (* Computadora elegira arma a sospechar *)

    n := Aleatorio(0,5-player.conta.arma);
    sospech.arma := player.lista.arma[n];
    Writeln('La computadora',player.posicion,
        ' sospecha que el arma usada en el asesinato fue: ',sospech.arma);
    (* Computadora elegira personaje a sospechar *)
    m := Aleatorio(0,5-player.conta.prj);
    sospech.prj := player.lista.arma[m];   
    Writeln('La computadora',player.posicion,' sospecha quien mato
             a Mr.Black fue: ',sospech.prj);
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
        End;

        muestro := Aleatorio(0,k);
        Case muestro of
            0 :
            Begin
                If ( carta[0] = sospech.arma ) Then
                Begin
                    Swap_descarte(player.lista.arma[5-player.conta.arma]
                                    ,player.lista.arma[m]);
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[0] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player.lista.prj[5-player.conta.prj]
                                    ,player.lista.prj[m]);
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[0] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player.lista.habt[8-player.conta.habt]
                                    ,player.lista.habt[m]);
                    player.conta.prj := player.conta.habt + 1;
                End;
            End;
            1 :
            Begin
                If ( carta[1] = sospech.arma ) Then
                Begin
                    Swap_descarte(player.lista.arma[5-player.conta.arma]
                                    ,player.lista.arma[m]);
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[1] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player.lista.prj[5-player.conta.prj]
                                    ,player.lista.prj[m]);
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[1] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player.lista.habt[8-player.conta.habt]
                                    ,player.lista.habt[m]);
                    player.conta.prj := player.conta.habt + 1;
                End;
            End;
            2 :
            Begin
                If ( carta[2] = sospech.arma ) Then
                Begin
                    Swap_descarte(player.lista.arma[5-player.conta.arma]
                                    ,player.lista.arma[m]);
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[2] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player.lista.prj[5-player.conta.prj]
                                    ,player.lista.prj[m]);
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[2] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player.lista.habt[8-player.conta.habt]
                                    ,player.lista.habt[m]);
                    player.conta.prj := player.conta.habt + 1;
                End;
            End;
        End;
        Writeln(' La computadora',pc[i].posicion,' Le muestra una carta a la
                  computadora',player.posicion);
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
        End;

        (* Si el usuario tiene una carta de la sospecha *)

        If ( pc[i].usuario ) Then
        Begin
            Writeln('En tu mano hay ',k,' cartas que se sospechan, cual quieres
                     mostrar?');
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
                Swap_descarte(player.lista.arma[5-player.conta.arma]
                                ,player.lista.arma[m]);
                player.conta.arma := player.conta.arma + 1;
            End;
            If ( carta[l-1] = sospech.prj ) Then
            Begin 
                Swap_descarte(player.lista.prj[5-player.conta.prj]
                                ,player.lista.prj[m]);
                player.conta.prj := player.conta.prj + 1;
            End;
            If ( carta[l-1] = sospech.habt ) Then
            Begin 
                Swap_descarte(player.lista.habt[8-player.conta.habt]
                                ,player.lista.habt[m]);
                player.conta.prj := player.conta.habt + 1;
            End;
        End;
        muestro := Aleatorio(0,k);
        Case muestro of
            0 :
            Begin
                If ( carta[0] = sospech.arma ) Then
                Begin
                    Swap_descarte(player.lista.arma[5-player.conta.arma]
                                    ,player.lista.arma[m]);
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[0] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player.lista.prj[5-player.conta.prj]
                                    ,player.lista.prj[m]);
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[0] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player.lista.habt[8-player.conta.habt]
                                    ,player.lista.habt[m]);
                    player.conta.prj := player.conta.habt + 1;
                End;
            End;
            1 :
            Begin
                If ( carta[1] = sospech.arma ) Then
                Begin
                    Swap_descarte(player.lista.arma[5-player.conta.arma]
                                    ,player.lista.arma[m]);
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[1] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player.lista.prj[5-player.conta.prj]
                                    ,player.lista.prj[m]);
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[1] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player.lista.habt[8-player.conta.habt]
                                    ,player.lista.habt[m]);
                    player.conta.prj := player.conta.habt + 1;
                End;
            End;
            2 :
            Begin
                If ( carta[2] = sospech.arma ) Then
                Begin
                    Swap_descarte(player.lista.arma[5-player.conta.arma]
                                    ,player.lista.arma[m]);
                    player.conta.arma := player.conta.arma + 1;
                End;
                If ( carta[2] = sospech.prj ) Then
                Begin 
                    Swap_descarte(player.lista.prj[5-player.conta.prj]
                                    ,player.lista.prj[m]);
                    player.conta.prj := player.conta.prj + 1;
                End;
                If ( carta[2] = sospech.habt ) Then
                Begin 
                    Swap_descarte(player.lista.habt[8-player.conta.habt]
                                    ,player.lista.habt[m]);
                    player.conta.prj := player.conta.habt + 1;
                End;
            End;
        End;
        Writeln(' La computadora',pc[i].posicion,' Le muestra una carta a la
                  computadora',player.posicion);
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
 
Begin

End.



