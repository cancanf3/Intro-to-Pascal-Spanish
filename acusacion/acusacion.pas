Procedure Acusacion_Usuario( var acus : sbr; var jugadorTurno : user; sobre : sbr;
                            phaInicio : cartas; var juegoActivo : boolean;
                            var jugadores : Array of user );
Var 
    i : integer; // Variable de iteracion.
    n,m,h : integer; // Variable que permite lectura robusta
Begin

    (* Acusacion del Personaje *)
    Writeln('Quien Mato a Mr.Black? ');
    Writeln;

    Writeln('Personajes descartados'); 
    Writeln;
    For i := ( 5 - jugadorTurno.conta.prj ) to 5 Do
    Begin
        Writeln(jugadorTurno.lista.prj[i]);
    End;
    Writeln;
    Writeln('Personajes Para Acusar ');
    Writeln;
    For i := 0  to 5 Do
    Begin
        Writeln(i+1,'.- ',phaInicio[i]);
    End;
    Repeat
    Begin
        Writeln;
        Writeln(' Elige una opcion: ');
        Readln(n);
    End
    Until ( n < 7 ) and ( n > 0 );

    acus.prj := phaInicio[n-1];
    MoverSospechoso(acus);
    (* Acusacion del arma *)

    Writeln;
    Writeln('Que arma se uso para asesinarlo? ');
    Writeln;
    Writeln('Armas descartadas ');
    Writeln;
    For i := ( 5 - jugadorTurno.conta.arma ) to 5 Do
    Begin
        Writeln(jugadorTurno.lista.arma[i]);
    End;
    Writeln;
    Writeln('Armas para acusar');
    For i := 15 to 20 Do
    Begin
        Writeln( i - 14,'.- ',phaInicio[i]);
    End;
    Repeat
    Begin
        Writeln;
        Writeln(' Elige una opcion');
        Readln(m);
    End
    Until ( n < 7 ) and ( n > 0 ); 

    acus.arma := phaInicio[m+14];

    (* Acusacion de la habitacion *)

    Writeln;
    Writeln('En que lugar crees que ocurrio el asesinato?' );
    Writeln;
    Writeln('Habitaciones descartadas ');
    Writeln;
    For i := ( 8 - jugadorTurno.conta.habt ) to 8 Do
    Begin
        Writeln(jugadorTurno.lista.habt[i]);
    End;
    Writeln;
    Writeln('Habitaciones donde acusar ');
    For i := 6 to 14 Do
    Begin
        Writeln(i - 5,'.- ',phaInicio[i]);
    End;
    Repeat
    Begin
        Writeln;
        Writeln(' Elige una opcion ');
        Readln(h);
    End
    Until ( h > 0 ) and ( h < 10 );
    
    acus.habt := phaInicio[h+5];

    (* Verificacion de la acusacion *)
        
    Eliminar(jugadorTurno,acus,sobre);
    Fin(jugadores,sobre,acus,juegoActivo);


End;

