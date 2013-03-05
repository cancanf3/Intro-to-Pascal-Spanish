 (*  Procedure Acusacion( n : sbr; (*Variable del jugador*));
    Var 
    acus : sbr; // Variables que almacenaran la acusasion del jugador
    Begin
    	
    	acus.h := (* Variable que determina el lugar de la acusacion *)
    	Writeln('A quien desea acusar: ');
	Readln(acus.p);
	Writeln('Que arma se uso para matar a Mr.Black: ');
	Readln(acus.a);
	
	    { pre }  
	If ( acus.p = sobre.p ) And ( acus.a = sobre.a ) And ( acus.h = sobre.h ) Then
	Begin
		Writeln(' El Jugador ',(*Variable que identifica el jugador *),' ha adivinado las cartas del sobre');
		Writeln(' El Juego se da por terminado ');
		Halt;
	End
	Else 
	Begin
		(* Variable booleana del Jugador*) := false;
		If (* jugador = usuario *) Then
		Begin
			Writeln(' Has Fallado en tu acusacion ');
			Writeln(' Has Perdido ');
			Writeln(' Las cartas del sobre son ');
			Writeln(' Asesino: ',sobre.p,' Arma: ', sobre.a,' Lugar: ', sobre.h);
			Halt;
		End;
	End;
    End;	
*)


