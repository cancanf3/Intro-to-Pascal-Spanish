program SeleccionPersonaje;

Type 
 
    pha = (SenoraBlanco, SenorVerde, SenoraCeleste, ProfesorCiruela,
	   SenoritaEscarlata, CoronelMostaza, Biblioteca, Cocina, Comedor,
	   Estudio, Vestibulo, Salon, Invernadero, SalaDeBaile, SalaDeBillar,
	   Candelabro, Cuchillo, Cuerda, LlaveInglesa, Revolver, Tubo);
    
    p = SenoraBlanco..CoronelMostaza;
    h = Biblioteca..SalaDeBillar;
    a = Candelabro..Tubo;
    
    cartas= Array[0..20] of pha;
    prjs = Array[0..5] of p;
    habts = Array[0..8] of h;
    armas  = Array[0..5] of a;
	   
    lugar = Record
		nombre : h;
		x : integer;
		y : integer;
		alcanzable : boolean;
	        End;
    
    sbr  =  Record
		arma : a;
		habt : h;
		prj  : p;
	        End;
	descarte = Record // Variable contadora de descarte para las pc 
        arma : integer;
        habt : integer;
        prj  : integer;
               End;
    lista_cartas = Record
        arma : armas;
        habt : habts;
        prj  : prjs; 
                   End;	

    user =  Record
		x : integer;
		y : integer;
		usuario : boolean;
        vida : boolean;
        mano : array[0..2] of pha;
		donde : h;
		peon  : p;  // Ficha que usa para jugar
		lista : lista_cartas;  // Lista de cartas
        conta : descarte;
     posicion : integer;
	    End;
    
    Procedure Swap (var n : integer; var m : integer);
    Var
	tmp : integer;
    Begin
	tmp := n;
	n := m;
	m := tmp;
    End;   



    Procedure SeleccionPersonaje(phaInit : cartas; var player : Array of user);
    Var
	i : integer;
	repartir: Array[0..5] of integer = (0,1,2,3,4,5);
    Begin
	writeln('Seleccione un personaje ingresando el numero correspondiente.');
	For i := 0 To 5 Do
	Begin
	    Writeln(i+1, '.- ', phaInit[i]);
	End;
	
	write('Usuario Selecciona: ');
	read(i);
	While (i > 6) Or (i < 1) Do
	Begin
	    writeln('Numero ingresado no valido');
	    write('Usuario Selecciona: ');
	    read(i);
	End;
	player[0].peon := phaInit[i-1];
	writeln('El personaje seleccionado fue: ', player[0].peon);
	writeln;
	
	(*Codigo que asigna los personajes a las pc's*)
	Swap(repartir[i-1], repartir[5]);

	For i:= 0 To 4 Do
	Begin
	    player[i+1].peon := phaInit[repartir[i]];
	    writeln('Jugador ', i + 2, ' Selecciona a: ', player[i+1].peon);
	End;
	writeln;
    End;

Var
    phaInit : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);


    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario

Begin
    (* Ejemplo de llamada al procedimiento *)
    SeleccionPersonaje(phaInit, pc);


End.