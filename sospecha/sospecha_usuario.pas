Procedure sospecha_Usuario( var sospechaON : boolean; var jugadorTurno : usuario ; 
                            var jugadores : array of usuario; 
                            phaInicio : cartas; var sospech : sbr; 
                            ultimoJ : integer; var sospecha.conta : integer;
                            var sospecha_lista : Array of sbr;
                            );

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
quien := 0;
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
    Match_cartas(carta,jugadorTurno,jugadores,sospechaON,k,quien,humano);

    (* Refutacion *)

    Refuta_computadora(carta,jugadorTurno,k,quien,m,n,h);

    (* Descarte de sospecha *)

    Descarte_sospecha(sospecha_lista,sospechaON,sospech,sospecha.conta);
End;

