Procedure Acusacion( var player : user; sobre : sbr);
Var 
    acus : sbr; // Variables que almacenaran la acusasion del jugador
    Begin
    	
        acus.habt := player.donde

        If ( player.usuario = False ) Then
        Begin
        (* Algoritmo para acusar en funcion de descarte *)

        End
        Else
        Begin
            Writeln('A quien desea acusar: ');
	        Readln(acus.prj);
	        Writeln('Que arma se uso para matar a Mr.Black: ');
            Readln(acus.arma);
        End;
	
	    { pre }  

	If ( acus.prj = sobre.prj ) And ( acus.arma = sobre.arma ) 
       And ( acus.habt = sobre.habt ) Then
	Begin
		Writeln(' El Jugador ',player.peon,' ha adivinado las cartas del sobre');
		Writeln(' El Juego se da por terminado ');
		Halt;
	End
	Else 
	Begin
		player.vida := false;
		If ( player.usuario = true ) Then
		Begin
			Writeln(' Has Fallado en tu acusacion ');
			Writeln(' Has Perdido ');
			Writeln(' Las cartas del sobre son ');
			Writeln(' Asesino: ',sobre.prj,' Arma: ', sobre.arma,' Lugar: ', sobre.habt);
			Halt;
		End;
	End;
End;	

