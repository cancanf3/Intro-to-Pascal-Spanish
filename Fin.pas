PROGRAM Fin;

    Procedure Fin(jugadores : array of user;
		   acusacion, sobre : sbr;
		   var juegoActivo : boolean);
    Var
	i : integer;
    Begin
	
	juegoActivo := False
	i := 1;
	While (i < 6) And (juegoActivo = False) Do
	Begin
	    juegoActivo := jugadores[i].vida;
	    i := i + 1;
	End;
	
	If Not jugadores[0].vida Then
	Begin
	    juegoActivo := False;
	End;

	(*
	If acusacion = sobre Then
	Begin
	    juegoActivo := False;
	End;
	*)
	If (acusacion.prj = sobre.prj) 
	    And (acusacion.habt = sobre.habt) 
	    And (acusacion.arma = sobre.arma) Then
	Begin
	    juegoActivo := False;
	End;
	
	
    End;
	


BEGIN






END.


