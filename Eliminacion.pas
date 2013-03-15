PROGRAM Eliminacion;


    Procedure Eliminar(var jugador : user;
			acusacion : sbr;
			sobre : sbr);
    Begin
	If (acusacion.prj <> sobre.prj) 
	    Or (acusacion.habt <> sobre.habt ) 
	    Or (acusacion.arma <> sobre.arma ) Then
	Begin
	    jugador.vida := False;
	End
    End;




VAR




BEGIN



END.