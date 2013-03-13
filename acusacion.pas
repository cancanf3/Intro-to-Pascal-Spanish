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

    Writeln('


End;
