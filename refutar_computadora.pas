Procedure Refuta_computadora ( carta : Array of pha; var jugadorTurno : usuario;
                                k : integer; quien : integer; m : integer;
                                n : integer; h : integer);
Var
    muestro : integer; // Variable que determina que carta mostrar.
                               

Begin

muestro := Aleatorio(0,k-1);
Case muestro of
    0 :
    Begin
        If jugadorTurno.usuario Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[8]);
        End
        Else
        Begin
            Writeln('Jugador',quien,' Muestra una carta a Jugador'
                ,jugadorTurno.posicion);
        End;
        If ( carta[0] = sospech.arma ) 
        and ( m-1 <= 5 - jugadorTurno.conta.arma) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,'arma');
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
        End;
        If ( carta[0] = sospech.prj ) 
        and ( n-1 <= 5 - jugadorTurno.conta.prj) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,'prj');
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;
        If ( carta[0] = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
            jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
        End;
    End;
    1 :
    Begin
        If jugadorTurno.usuario Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[8]);
        End
        Else
        Begin
            Writeln('Jugador',quien,' Muestra una carta a Jugador'
                ,jugadorTurno.posicion);
        End;
        If ( carta[1] = sospech.arma ) 
        and ( m - 1 <= 5 - jugadorTurno.conta.arma) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,'arma');
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
        End;
        If ( carta[1] = sospech.prj ) 
        and ( n - 1 <= 5 - jugadorTurno.conta.prj ) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,'prj');
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;
        If ( carta[1] = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
            jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
        End;
    End;
    2 :
    Begin
        If jugadorTurno.usuario Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[8]);
        End
        Else
        Begin
            Writeln('Jugador',quien,' Muestra una carta a Jugador'
                ,jugadorTurno.posicion);
        End;
        If ( carta[2] = sospech.arma ) 
        and ( m - 1 <= 5 - jugadorTurno.conta.arma ) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,'arma');
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
        End;
        If ( carta[2] = sospech.prj ) 
        and ( n - 1 <= 5 - jugadorTurno.conta.prj ) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,'prj');
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;
        If ( carta[2] = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
            jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
        End;
    End; 
    3 :
    Begin
        If jugadorTurno.usuario Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[8]);
        End
        Else
        Begin
            Writeln('Jugador',quien,' Muestra una carta a Jugador'
                ,jugadorTurno.posicion);
        End;
        If ( carta[3] = sospech.arma ) 
        and ( m-1 <= 5 - jugadorTurno.conta.arma) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,'arma');
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
        End;
        If ( carta[3] = sospech.prj ) 
        and ( n-1 <= 5 - jugadorTurno.conta.prj) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,'prj');
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;
        If ( carta[3] = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
            jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
        End;
    End;
    4 :
    Begin
        If jugadorTurno.usuario Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[8]);
        End
        Else
        Begin
            Writeln('Jugador',quien,' Muestra una carta a Jugador'
                ,jugadorTurno.posicion);
        End;
        If ( carta[4] = sospech.arma ) 
        and ( m - 1 <= 5 - jugadorTurno.conta.arma) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,'arma');
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
        End;
        If ( carta[4] = sospech.prj ) 
        and ( n - 1 <= 5 - jugadorTurno.conta.prj ) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,'prj');
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;
        If ( carta[4] = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
            jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
        End;
    End;
    5 :
    Begin
        If jugadorTurno.usuario Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[8]);
        End
        Else
        Begin
            Writeln('Jugador',quien,' Muestra una carta a Jugador'
                ,jugadorTurno.posicion);
        End;
        If ( carta[5] = sospech.arma ) 
        and ( m - 1 <= 5 - jugadorTurno.conta.arma ) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,'arma');
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
        End;
        If ( carta[5] = sospech.prj ) 
        and ( n - 1 <= 5 - jugadorTurno.conta.prj ) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,'prj');
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;
        If ( carta[5] = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
            jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
        End;
    End;
    6 :
    Begin
        If jugadorTurno.usuario Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[8]);
        End
        Else
        Begin
            Writeln('Jugador',quien,' Muestra una carta a Jugador'
                ,jugadorTurno.posicion);
        End;
        If ( carta[6] = sospech.arma ) 
        and ( m - 1 <= 5 - jugadorTurno.conta.arma) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,'arma');
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
        End;
        If ( carta[6] = sospech.prj ) 
        and ( n - 1 <= 5 - jugadorTurno.conta.prj ) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,'prj');
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;
        If ( carta[6] = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
            jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
        End;
    End;
    7 :
    Begin
        If jugadorTurno.usuario Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[8]);
        End
        Else
        Begin
            Writeln('Jugador',quien,' Muestra una carta a Jugador'
                ,jugadorTurno.posicion);
        End;
        If ( carta[7] = sospech.arma ) 
        and ( m - 1 <= 5 - jugadorTurno.conta.arma ) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,'arma');
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
        End;
        If ( carta[7] = sospech.prj ) 
        and ( n - 1 <= 5 - jugadorTurno.conta.prj ) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,'prj');
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;
        If ( carta[7] = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
            jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
        End;
    End;
    8 :
    Begin
        If jugadorTurno.usuario Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[8]);
        End
        Else
        Begin
            Writeln('Jugador',quien,' Muestra una carta a Jugador'
                ,jugadorTurno.posicion);
        End;
        If ( carta[8] = sospech.arma ) 
        and ( m - 1 <= 5 - jugadorTurno.conta.arma ) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,'arma');
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
        End;
        If ( carta[8] = sospech.prj ) 
        and ( n - 1 <= 5 - jugadorTurno.conta.prj ) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,'prj');
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;
        If ( carta[8] = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
            jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
        End;
    End;
