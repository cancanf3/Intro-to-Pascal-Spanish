Procedure Refuta_computadora ( carta : Array of pha; var jugadorTurno : usuario;
                                k : integer; quien : integer; m : integer;
                                n : integer; h : integer);
Var
    muestro : integer; // Variable que determina que carta mostrar.
                               

Begin

    muestro := Aleatorio(0,k-1);

    If jugadorTurno.usuario Then
    Begin
        Writeln('Jugador',quien,' te muestra ',carta[muestro]);
    End
    Else
    Begin
        Writeln('Jugador',quien,' Muestra una carta a Jugador'
            ,jugadorTurno.posicion,' La carta es: ',carta[muestro]);
    End;
    If ( carta[muestro] = sospech.arma ) 
    and ( m-1 <= 5 - jugadorTurno.conta.arma) Then
    Begin
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,0);
        jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
    End;
    If ( carta[muestro] = sospech.prj ) 
    and ( n-1 <= 5 - jugadorTurno.conta.prj) Then
    Begin 
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,1);
        jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
    End;
    If ( carta[muestro] = sospech.habt ) 
    and ( h <= 8 - jugadorTurno.conta.habt ) Then
    Begin 
        Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
        jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
    End;
End;
    
