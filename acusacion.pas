Procedure Acusacion_Usuario( var jugadorTurno : usuario; sobre : sbr;
                        phaInicio : cartas);
Var 
    acus : sbr; // Variables que almacenaran la acusasion del jugador.
    i : integer; // Variable de iteracion.
    n : integer; // Variable que permite lectura robusta
Begin

    (* Acusacion del Personaje *)
    Writeln(' Quien Mato a Mr.Black? ');

    Writeln('Personajes descartados'); 
    For i := 0 to ( 5 - jugadorTurno.conta.prj ) Do
    Begin
        Writeln(jugadorTurno.lista.prj[i]);
    End;
    Writeln('Personajes Para Acusar ');
    For i := 0  to 5 Do
    Begin
        Writeln(i+1,'.- ',phaInicio[i]);
    End;
    Repeat
    Begin
        Readln(n);
    End
    Until ( n < 7 ) and ( n > 0 );

    acus.prj := phaInicio[n-1];

    (* Acusacion del arma *)

    Writeln(' Que arma se uso para asesinarlo? ');

    Writeln(' Armas descartadas ');
    For i := 0 to ( 5 - jugadorTurno.conta.arma ) Do
    Begin
        Writeln(jugadorTurno.lista.arma[i]);
    End;
    Writeln(' Armas para acusar');
    For i := 15 to 20 Do
    Begin
        Writeln( i - 14,'.- ',phaInicio[i]);
    End;
    Repeat
    Begin
        Readln(m);
    End
    Until ( n < 7 ) and ( n > 0 ); 

    acus.arma := phaInicio[m+14];

    (* Acusacion de la habitacion *)

    Writeln(' En que lugar crees que ocurrio el asesinato?' );

    Writeln('Habitaciones descartadas ');
    For i := 0 to 8 Do
    Begin
        Writeln(jugadorTurno.lista.habt[i]);
    End;
    Writeln(' Habitaciones donde acusar ');
    For i := 6 to 14 Do
    Begin
        Writeln(i - 5,'.- ',phaInicio[i]);
    End;
    Repeat
    Begin
        Readln(h);
    End
    Until ( h > 0 ) and ( h < 10 );
    
    acus.habt := phaInicio[h+5];

    (* Verificacion de la acusacion *)

    If ( acus.habt = sobre.habt ) and ( acus.arma = sobre.arma ) 
        and ( acus.prj = sobre.prj ) Then 
    Begin

        
        findejuego;

    End
    Else
    Begin
        jugadorTurno.vida := false;
    End;
End;

Procedure Acusacion_Computadora( var jugadorTurno : usuario; sobre : sbr;
                                 phaInicio : cartas; sospech : sbr
                                 var sospecha.conta : integer;
                                 sospecha_lista : sbr;
                                );
Var 
    acus : sbr; // Variables que almacenaran la acusasion del jugador.
    i : integer; // Variable de iteracion.
    p,a,h : integer; // Permite elegir aleatoriamente la acusacion.
    procede : boolean; // Determina que la acusacion puede proceder.
Begin

    (* Formulacion de la Acusacion *)

    If sospechaON Then
    Begin
        acus.arma := sospech.arma;
        acus.prj := sospech.prj;
        acus.habt := acus.habt;
    End
    Else
    Begin

        Repeat
        Begin

            p := Aleatorio(0,5 - jugadorTurno.conta.prj );
            a := Aleatorio(0,5 - jugadorTurno.conta.arma );
            h := Aleatorio(0,8 - JugadorTurno.conta.habt);
            
            acus.prj := jugadorTurno.lista.prj[p];
            acus.arma := jugadorTurno.lista.arma[a];
            acus.habt := jugadorTurno.lista.habt[h];

            For i := 0 to jugadorTurno.conta.sospecha Do
            Begin
                If ( acus.arma = sospecha_lista[i].arma ) and
                   ( acus.habt = sospecha_lista[i].habt ) and
                   (  acus.prj = sospecha_lista[i].prj  ) Then
                Begin
                    procede := true;
                End;
            End;
        End
        Until ( Procede = true );

        Writeln('Jugador',jugadorTurno.posicion,' ha realizado una acusacion');
        Writeln('Arma elegida: ',acus.arma);
        Writeln('Personaje elegido: ',acus.prj);
        Writeln('Haitacion elegida: ',acus.habt);
    End;

    (* Verificacion de la acusacion *)

    If ( acus.habt = sobre.habt ) and 
       ( acus.arma = sobre.arma ) and 
       ( acus.prj  =  sobre.prj ) Then 
    Begin

        
        findejuego;

    End
    Else
    Begin
        jugadorTurno.vida := false;
        Writeln('Jugador',jugadorTurno.posicion,' ha perdido ');
    End;       




End;
