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


