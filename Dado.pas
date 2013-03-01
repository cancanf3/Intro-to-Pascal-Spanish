(* 
	Funcion que simula el Dado. Random(n) 
    Genera numeros random del 0 hasta n-1
*)

Program Dado;

    (* 
	    Declaracion de la funcion, lo unico que se
	ve medio raro es que no le paso nada como
	parametro 
    *)
    Function Dado() : integer;
    Begin
	Dado := Random(6) + 1;
    End;
  
Begin
    Randomize(); // Esto es necesario para que los numeros cambien
    
    Writeln;
    
    Writeln(Dado); // Esta seria un ejemplo de la llamada en nuestro codigo
    
    Writeln;
End.