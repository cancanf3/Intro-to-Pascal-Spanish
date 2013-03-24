Procedure Turno(phaInicio : Array of cartas; var habitacion : Array of lugar;
                sobre : sbr; var partida : text; var Turn : integer;
                var jugadores : Array of usuario; var sospech : sbr;
                var acus : sbr; ultimoJ : integer; var sospechaConta : integer; 
                Var sospechaLista : Array of sbr; var SioNo : boolean;
                var juegoActivo : boolean; var sospechaON : boolean;
                var jugadorTurno : sbr );

var
    i,j,co : integer; // Contadores
    dado : integer; // Valor del dado

Begin

    (* Se calcula el dado *)

    dado := Aleatorio(1,6);

    (* Mover al jugador *)

    Mover(jugadorTurno,dado,habitacion);

    (* jugador del Turno hace la sospecha *)

    If ( jugadorTurno.usuario ) Then
    Begin
        Writeln;
        Writeln('Deseas realizar una sospecha?');
        Writeln;
        Decision(SioNO);
    End;

    If SioNo Then
    Begin
       SioNo  
        
