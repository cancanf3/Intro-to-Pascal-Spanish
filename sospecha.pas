Procedure sospecha_Usuario( var sospechaON : boolean; var jugadorTurno : usuario ; 
                            var jugadores : array of usuario; 
                            phaInicio : cartas; var sospech : sbr; 
                            ultimoJ : integer; var sospecha.conta : integer;
                            var sospecha_lista : Array of sbr;
                            );
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

