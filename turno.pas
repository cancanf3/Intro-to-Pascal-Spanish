Procedure Turno ( var player : user; habitacion : Array of lugar );
Var
    decision : integer;
    opinion : boolean;
    n : integer;
Begin
 
    Writeln('Se lanza el dado');
    
    (* Emulacion de Dado *)
    n := Aleatorio(1,6);
    Writeln('Al lanzar el dado obtuvo un ', n, '.');
    (* El jugador va a moverse *)

    Mover(player,n,habitacion);
    (* El jugador realiza una sospecha *)

    sospecha(player.sospecha,);
    (* El jugador realiza una acusacion *)

    If not (* Variable que simboliza si la sospecha fue refutada *) Then
    Begin
        If (player.usuario = true ) Then
        Begin
              Writeln('Tu sospecha no ha sido refutada');
              Writeln('Deseas realizar una acusacion (s/n): ';
        End
        
            If ( SioNo ) Then
            Begin
                Acusacion;
            End;
        End
        Else // Algoritmo para determinar si una computadora hace una acusacion 
        Begin
            If (player.sospecha = 1 ) Then
            Begin
                 Acusacion;
            End;
        End;
            
End;
