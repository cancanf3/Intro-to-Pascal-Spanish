PROGRAM SOSPECHA;



Procedure Match_cartas ( Var carta : Array of sbr ; jugadorTurno : user ;
                         jugadores : Array of user ; var sospechaON : boolean ;
                         var k : integer ; var quien : integer;
                         var humano : boolean; ultimoj : integer;
                         sospech : sbr );
Var
    i,j : integer; // Contadores
  
Begin

If  not ( jugadorTurno.usuario ) Then
Begin

    For i := ( jugadorTurno.posicion + 1 ) to ultimoj Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].conta.cartas  Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j].arma := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.prj ) Then 
                Begin    
                    carta[j].prj := sospech.prj;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.habt ) Then
                Begin
                    carta[j].habt := sospech.habt;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
            End;
        End;
    End;      
            
    For i := 0 to ( jugadorTurno.posicion - 1 ) Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].conta.cartas Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j].arma := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.prj ) Then 
                Begin    
                    carta[j].prj := sospech.prj;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.habt ) Then
                Begin
                    carta[j].habt := sospech.habt;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End; 
                If ( sospechaON = false ) and ( jugadores[i].usuario ) Then
                Begin
                    humano := True
                End;
            End;
        End;
    End;
End
Else
Begin
    For i := ( jugadorTurno.posicion + 1 ) to ultimoj Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].conta.cartas Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j].arma := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.prj ) Then 
                Begin    
                    carta[j].prj := sospech.prj;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.habt ) Then
                Begin
                    carta[j].habt := sospech.habt;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
            End;
        End;
    End;
End;
End;

Procedure Refuta_Usuario ( carta : Array of sbr; Var jugadorTurno : user;
                           sospech : sbr; k : integer; 
                           m : integer; n : integer; h : integer);
Var
    i : integer; // Variable para iterar.
    s : string; // Variable de mensajes.
    l : integer; // Variable de lectura robusta.
Begin
    Writeln('En tu mano hay ',k,
        ' cartas que se sospechan, cual quieres mostrar?');
    For i := 0 to (k-1) Do
    Begin
        If ( carta[i].arma = sospech.arma ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].arma);
        End;

        If ( carta[i].prj = sospech.prj ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].prj);
        End;

        If ( carta[i].habt = sospech.habt ) Then
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
    Until ( n > 0 ) and ( n < (k + 1) );

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
        jugadorTurno.conta.habt := jugadorTurno.conta.habt + 1;
    End;
End;

Procedure Swap_descarte(var jugador : user; n : integer; 
                            m : integer; k : integer);
Var
tmp1 : a;
tmp2 : h;
tmp3 : p;
Begin
    Case k of 
        0 :
        Begin
            tmp1 := jugador.lista.arma[n];
            jugador.lista.arma[n] := jugador.lista.arma[m];
            jugador.lista.arma[m] := tmp1;
        End;
        2 :
        Begin
            tmp2 := jugador.lista.habt[n];
            jugador.lista.habt[n] := jugador.lista.habt[m];
            jugador.lista.habt[m] := tmp2;
        End;
        1 :
        Begin
            tmp3 := jugador.lista.prj[n];
            jugador.lista.prj[n] := jugador.lista.prj[m];
            jugador.lista.prj[m] := tmp3;
        End;
    End;
End;
 
