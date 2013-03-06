Procedure Turno ( var player : user );
Var
decision : integer;
opinion : string;
Begin
 
    Writeln('Se lanza el dado');
    
    (* Emulacion de Dado *)
    n := Aleatorio(1,6);
    Writeln('Al lanzar el dado obtuvo un ', n, '.');
    (* El jugador va a moverse *)

    Mover(n,player);
    (* El jugador realiza una sospecha *)

    sospecha(player.sospecha);
    (* El jugador realiza una acusacion *)

    If not (* Variable que simboliza si la sospecha fue refutada *) Then
    Begin
        If (player.usuario = true ) Then
        Begin
            Repeat
            Begin
              Writeln('Tu sospecha no ha sido refutada');
              Writeln('Deseas realizar una acusacion (si o no): ');
              Read(opinion);
            End
            Until (opinion = 'si') Or ( opinion = 'no' );

            If ( decision = 'si' ) Then
            Begin
                Acusacion;
            End;
        End
        Else // Algoritmo para determinar si una computadora hace una acusacion 
        Begin
            If (player.sospecha > 1 ) Then
            Begin
                decision := Aleatorio(1,2);
                If ( decision = 2) Then
                Begin
                Acusacion;
                End;
            End;
        End;

            
End;
