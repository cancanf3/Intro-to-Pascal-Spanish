Procedure Match_cartas ( Var carta : sbr ; jugadorTurno : user ;
                         jugadores : user ; var sospechaON : boolean ;
                         var k : integer ; var quien : integer
                         var humano : boolean );
Var
    i,j : integer; // Contadores
  
Begin

If  not ( jugadorTurno.usuario ) Then
Begin

    For i := ( jugadorTurno.posicion + 1 ) to ultimoj Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].cnta.cartas Do
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
            For j := 0 to jugadores[i].conta.cartas Do
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
End;
End;

Procedure Refuta_Usuario ( carta : Array of pha; jugadorTurno : usuario;
                           k : integer; m : integer; n : integer; h : integer);
Var
    i : integer; // Variable para iterar.
Begin
    Writeln('En tu mano hay ',k,
        ' cartas que se sospechan, cual quieres mostrar?');
    For i := 0 to 2 Do
    Begin
    Writeln(i + 1,'.- ',carta[i]);
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
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m,0);
        jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
    End;
    If ( carta[l-1] = sospech.prj ) Then
    Begin 
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n,1);
        jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
    End;
    If ( carta[l-1] = sospech.habt ) Then
    Begin 
        Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
        jugadorTurno.conta.prj := jugadorTurno.conta.habt + 1;
    End;
End;

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

Procedure Descarte_sospecha ( var sospecha_lista : Array of sbr; 
                              var sospechaON : boolean; 
                              var sospech : sbr;
                              var sospecha.conta : integer );

Begin
    If not ( sospechaON ) Then
    Begin
        sospecha_lista[sospecha.conta].arma := sospech.arma;
        sospecha_lista[sospecha.conta].prj := sospech.prj;
        sospecha_lista[sospecha.conta].habt := sospech.habt;
        sospecha.conta := sospecha.conta + 1;    
    End;
End;



Procedure sospecha_computadora ( var sospechaON : boolean; 
                                 var jugadorTurno : usuario; 
                                 var jugadores : array of usuario; 
                                 phaInicio : cartas; 
                                 var sospech : sbr; ultimoJ : integer;
                                 var sospecha.conta : integer;
                                 var sospecha_lista : Array of sbr);



Var
    h,n,m,l : integer; // variables que permiten programacion robusta
    s : string; // Variable que muestra mensaje al usuario
    k : integer; // determina cuantas cartas son sospechadas por mano
    carta : Array[0..2] of pha; // Arreglo que guarda las cartas sospechadas
    i,j,co : integer; // Contadores 
    humano : boolean; // determina si el usuario ha mostrado una carta
    quien : integer; // determina quien hace match con las cartas
    Begin
    
    
    sospechaON := True;
    humano := false;
    quien := 0;

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
    Match_cartas(carta,jugadorTurno,jugadores,sospechaON,k,quien,humano);

    (* Refutacion *)

        If ( humano ) and (sospechaON = false ) Then
        Begin
            Refuta_Usuario(carta,jugadorTurno,k,m,n,h);
        End
        Else
        Begin    
            If ( sospechaON = false ) and ( humano = false ) Then
            Begin
                Refuta_computadora(carta,jugadorTurno,k,quien,m,n,h);
            End;
        End;
    End;
    
    (* Descarte de la sospecha *)

    Descarte_sospecha(sospecha_lista,sospechaON,sospech,sospecha.conta);

End;

