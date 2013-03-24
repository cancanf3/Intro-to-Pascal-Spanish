Procedure Turno(phaInicio : Array of cartas; var habitacion : Array of lugar;
                sobre : sbr; var partida : text; var Turn : integer;
                var jugadores : Array of usuario; var sospech : sbr;
                var acus : sbr; ultimoJ : integer; var sospechaConta : integer; 
                Var sospechaLista : Array of sbr; var SioNo : boolean;
                var juegoActivo : boolean; var sospechaON : boolean;
                var jugadorTurno : sbr );

var
    i,j,co : integer; // Contadores
    n : integer; // Valor del dado
Begin

    (* Se calcula el dado *)

    n := Aleatorio(1,6);

    (* Mover al jugador *)

    Mover(jugadorTurno,n,habitacion);

    (* Jugador del Turno hace la sospecha *)

    If ( jugadorTurno.usuario ) Then
    Begin
        Writeln;
        Writeln('Deseas realizar una sospecha?');
        Writeln;
        Decision(SioNO);

        If SioNo Then
        Begin
            sospecha_Usuario(sospechaON,jugadorTurno,jugadores,phaInicio,
                            sospech,ultimoJ,sospechaConta,sospechaLista);
        End;
    End
    Else
    Begin
        Writeln;
        Writeln('El Jugador',jugadorTurno.posicion);
        Writeln('va a realizar una sospecha');
        Writeln;
    
        sospecha_computadora(sospechaON,jugadorTurno,jugadores,phaInicio,
                            sospech,ultimoJ,sospechaConta,sospechaLista);
    End;

    (* Jugador del Turno hace la Acusacion *)
    
    If ( jugadorTurno.usuario ) Then
    Begin
        Writeln;
        Writeln('Deseas realizar una acusacion?');
        Writeln;
        Decision(SioNo);

        If SioNo Then
        Begin
            Acusacion_Usuario(acus,jugadorTurno,sobre,cartas,
                              juegoActivo,jugadores,ultimoJ);
        End;
    End
    Else
    Begin
        If (jugadorTurno.posicion = 1 ) and (jugadorTurno.conta.arma = 6 ) and 
           (jugadorTurno.conta.prj = 6 ( jugadorTurno.conta.habt = 8 ) Then
        Begin
                
            Acusacion_Computadora(jugadorTurno,sobre,phaInicio,sospech,
                                  sospechaConta,sospechaLista,jugadores,
                                  sospechaON,ultimoJ,juegoActivo,acus);

        End;
        
        If ( sospechaConta > 100 ) and ( jugadorTurno.posicion <> 1 ) Then
        Begin

        n := Aleatorio(0,1);

        If ( n = 1) Then
        Begin
            SioNo := True; 
        End
        Else
        Begin
            SioNo := False;
        End;

        












