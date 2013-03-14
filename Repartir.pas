Program ReparteCartas;

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
        mano : array[0..8] of pha;
		donde : h;
		peon  : p;  // Ficha que usa para jugar
		lista : lista_cartas;  // Lista de cartas
        conta : descarte;
     posicion : integer;
        
            End;

VAR

    
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

    

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    
    
    pc : Array[0..5] of user; // Arreglo de Jugadores pc[0]:Usuario
    
    i,j,co  : integer; // Variables para Iteracion y contadores.
    n,x,y,z : integer; // Variables de usos multiples: swap, etc.
    Turno   : integer; // Contador de los Turnos.
    
    moverA : h;
    sospecha : sbr; // variable para realizar sospechas
    
    ultimoJ : integer;
    sospechaON : boolean;
    SioNo : boolean;

    Function Aleatorio(inicio : integer; tope : integer) : integer;
    Var 
	amplitud : integer;
    Begin
	amplitud := (tope - inicio) + 1;
	Aleatorio := Random(amplitud) + inicio;
    End;
    
    Procedure Swap (var n : integer; var m : integer);
    Var
	tmp : integer;
    Begin
	tmp := n;
	n := m;
	m := tmp;
    End;   
    Procedure RepartirCartas (var jugador : array of user; phaInicio : cartas; ultimoJ: integer);
    Var 
	co : integer;
	i,j : integer;
    Begin
    
	co := 0;
	j := 0;
	While (co < 18) Do
	Begin
	    i := 0;
	    While (i < ultimoJ + 1) And (co < 18) Do
	    Begin
		jugadores[i].mano[j] := phaInicio[repartir[co]];
        jugadores[i].conta.cartas := jugadores[i].conta.cartas + 1;
		co := co + 1;
		i := i + 1;
	    End;
	    j := j + 1;
	End;

    End;
    
    
    
    
BEGIN

    
    
    Procedure AsignarCartas (var jugador : array of user; var sobre : sbr; phaInicio : cartas; ultimoJ : integer);
    Var 
    
    repartir   : Array[0..20] of integer = (0,1,2,3,4,5,6,7,8,9,10,11,12,
						13,14,15,16,17,18,19,20);
    x,y,z : integer;
    i : integer;
    Begin
    
	(* Seleccion del Asesino *)
	x := Aleatorio(0,5);
	sobre.prj := phaInicio[x];

	(* Seleccion de la Habitacion donde se produjo el asesinato *)
	y := Aleatorio(6,14);
	sobre.habt := phaInicio[y];

	(* Seleccion del arma con la que se cometio el asesinato *)
	z := Aleatorio(15,20);
	sobre.arma := phaInicio[z];
	writeln;

	(* Swapeo las variables a las tres posiciones finales para 
	    no repartir las cartas del sobre *)
	Swap(repartir[z], repartir[20]);
	writeln('El Arma es: ', sobre.arma);

	Swap(repartir[y], repartir[19]);
	writeln('La Habitacion es: ', sobre.habt);

	Swap(repartir[x], repartir[18]);
	writeln('El Asesino es: ', sobre.prj);
	    

	(* Aqui hago Shuffle del arreglo de todas las cartas 
	    excluyendo las del sobre *)
	For i := 17 Downto 1 Do
	Begin
	    n := Aleatorio(0,i);
	    Swap(repartir[i], repartir[n]);
	End;
	writeln;
    
    End;
    
    
    
    
    
    
    
    
    
    
    

END.








