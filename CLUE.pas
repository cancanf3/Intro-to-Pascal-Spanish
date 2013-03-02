(* Este es el Proyecto Serio *)



Program CLUE;

Type 
    // bool = 0..1;

    p   = (SenoraBlanco, SenorVerde, SenoraCeleste, ProfesorCiruela,
	   SenoritaEscarlata, CoronelMostaza);
    
    h   = (Biblioteca, Cocina, Comedor, Estudio, Vestibulo, Salon, 
           Invernadero, SalaDeBaile, SalaDeBillar);

    a   = (Candelabro, Cuchillo, Cuerda, LlaveInglesa, Revolver, Tubo);
    
    armas = Array[0..5] of a;
    habts = Array[0..8] of h;
    prjs  = Array[0..5] of p;
	   
    ubic =  Record 
		x : integer;
		y : integer;
	    End;
    
    lst  =  Record
		arma : armas;
		habt : habts;
		prj  : prjs;
		//tachado : bool
	    End;
    
    
    lugar = Record
		cual : h;
		coord: ubic;
	    End;
    


    user =  Record
		where : ubic; // Ubicacion x y del usuario
		peon  : p;  // Ficha que usa para jugar
		lista : lst;  // Lista de cartas
	    End;


Var
    
    
    usuario : user;
    pc1     : user;
    pc2     : user;
    pc3     : user;
    pc4     : user;
    pc5     : user;
    armasInit : array[0..5] of a = (Candelabro, Cuchillo, Cuerda, LlaveInglesa, 
				    Revolver, Tubo);
				    
    habtsInit : array[0..8] of h = (Biblioteca, Cocina, Comedor, Estudio, 
				    Vestibulo, Salon, Invernadero, SalaDeBaile, 
				    SalaDeBillar);
				    
    prjsInit : array[0..5] of p  = (SenoraBlanco, SenorVerde, SenoraCeleste, 
				    ProfesorCiruela, SenoritaEscarlata, 
				    CoronelMostaza);
    i 	    : integer;


Begin 
    writeln;

    (* Con esta seccion de codigo el usuario selecciona el personaje 
	que usara en el juego *)
    writeln('Seleccione un personaje ingresando el numero correspondiente.');
    For i := 0 to 5 do
    Begin
	Writeln(i+1, '.- ', prjsInit[i]);
    End;
    
    write('Usuario Selecciona: ');
    read(i);
    While (i > 6) or (i < 1) do
    Begin
	writeln('Numero ingresado no valido');
	write('Usuario Selecciona: ');
	read(i);
    End;
    usuario.peon := prjsInit[i-1];
    writeln('El personaje seleccionado fue: ', usuario.peon);
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    writeln;
End.
