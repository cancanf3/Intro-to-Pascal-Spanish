Procedure Acusacion( var jugadorTurno : usuario; sobre : sbr;
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

     










End;
