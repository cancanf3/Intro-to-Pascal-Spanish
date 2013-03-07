Procedure sospecha( var sospechaON : boolean; var player : user ; 
                    var pc : array of user; phaInit : cartas );
Var
    sospech : sbr;
    muestro : integer;
    n : integer;
    m : integer;
    s : string;
    cartas : Array[0..2] of pha;

Begin

If ( player.usuario ) Then
Begin
    sospech.habt := player.donde;

    (* Elegir arma a sospechar *)

    Writeln('Armas no descartadas');
    For i := 0 to ( 5 - pc.conta.arma ) Do
    Begin
        Writeln(i+1,'.- ',pc[0].lista.arma[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - pc.conta.arma) to 5 Do
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
                End
                Else 
                Begin    
                    If ( pc[i].mano[j] = sospech.prj ) Then
                    Begin
                        carta[j] := sospech.prj;
                        sospechaON := false;
                    End
                    Else ( pc[i].mano[j] = sospech.habt ) Then
                    Begin
                        carta[j] := sospech.habt;
                        sospechaON := false;
                    End;
                End;
            End;
        End;

        muestro := Aleatorio(0,2);
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
    Writeln('La computadora',player.posicion,' sospecha que el arma usada
             en el asesinato fue: ',sospech.arma);
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
                End
                Else 
                Begin    
                    If ( pc[i].mano[j] = sospech.prj ) Then
                    Begin
                        carta[j] := sospech.prj;
                        sospechaON := false;
                    End
                    Else ( pc[i].mano[j] = sospech.habt ) Then
                    Begin
                        carta[j] := sospech.habt;
                        sospechaON := false;
                    End;
                End;
            End;
        End;

        muestro := Aleatorio(0,2);
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
                  computadora',player.posocion);
    End;   






