(* Este es el Proyecto Serio *)



Program CLUE;

Type 
    bool = (0..1);

    p   = (Senora Blanco, Senor Verde, Senora Celeste, Profesor Ciruela,
	   Senorita Escarlata, Coronel Mostaza);
    
    h   = (Biblioteca, Cocina, Comedor, Estudio, Vestibulo, Salon, 
           Invernadero, Sala de Baile, Sala de Billar);

    a   = (Candelabro, Cuchillo, Cuerda, Llave Inglesa, Revolver, Tubo);
	   
    ubic =  Record 
		x : integer;
		y : integer;
	    End;
    
    lst  =  Record
		arm : Array[0..5] of a;
		hab : Array[0..8] of h;
		prj : Array[0..5] of p;
		//tachado : bool
	    End;
    
    lugar 
    



    user =  Record
		where : ubic; // Ubicacion x y del usuario
		peon  : prj;  // Ficha que usa para jugar
		lista : lst;  // Lista de cartas
	    End;


Var
    
    usuario : user;
    pc1     : user;
    pc2     : user;
    pc3     : user;
    pc4     : user;
    pc5     : user;
    




Begin 

    For a := 0 to 5 do
    Begin
	writeln(ord(a))
    End;



End.
