Procedure Refuta_Usuario ( carta : Array of pha; jugadorTurno : usuario;
                           k : integer; m : integer; n : integer; h : integer);
Var
    i : integer; // Variable para iterar.
Begin
    Writeln('En tu mano hay ',k,
        ' cartas que se sospechan, cual quieres mostrar?');
    For i := 0 to 2 Do
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
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m,'arma');
        jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
    End;
    If ( carta[l-1] = sospech.prj ) Then
    Begin 
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n,'prj');
        jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
    End;
    If ( carta[l-1] = sospech.habt ) Then
    Begin 
        Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,'habt');
        jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
    End;
End;

