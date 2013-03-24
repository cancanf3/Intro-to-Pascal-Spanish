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
