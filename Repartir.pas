Program Repartir;

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

VAR

    Var
    (* 
     * Personajes: 0 al 5
     * Habitaciones: del 6 al 14
     * Armas: 15 20 
    *)
    phaInicio : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);

    repartir   : Array[0..20] of integer = (0,1,2,3,4,5,6,7,8,9,10,11,12,
						13,14,15,16,17,18,19,20);

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    
    
    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario
    
    i,j,co  : integer; // Variables para Iteracion y contadores.
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    Turno   : integer; // Contador de los Turnos.
    
    moverA : h;
    sospecha : sbr; // variable para realizar sospechas
    

    sospechaON : boolean;
    SioNo : boolean;


    Procedure Repartir (var jugador : array of user; phaInicio : cartas);
    Var 
	co1 : integer;
	co2 : integer;
    Begin
    
	co1 := 0;
	co2 := 0;
	While (co1 < 18) Do
	Begin
	    For i := 0 To ultimoJ Do
	    Begin
		jugador[i].mano[co2] := phaInicio[repartir[co1]];
		co1 := co1 + 1;
	    End;
	    co2 := co2 + 1;
	End;

    End;
    
    
    
    
BEGIN


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

END.









