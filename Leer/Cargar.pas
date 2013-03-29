PROGRAM leerArchivoTexto;

TYPE 
 
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
	prj  : p;
	arma : a;
	habt : h;
	
    End;
	
    contadores = Record // Variable contadora de descarte para las jugadores 
	arma : integer;
	habt : integer;
	prj  : integer;
	cartas : integer;
    End;
    
    lista_cartas = Record
	arma : armas;
	habt : habts;
	prj  : prjs; 
    End;

    usuario =  Record
	x : integer;
	y : integer;
	usuario : boolean;
	vida : boolean;
	mano : cartas;
	donde : h;
	peon  : p;  // Ficha que usa para jugar
	lista : lista_cartas;  // Lista de cartas
	conta : contadores;
	posicion : integer; 
    End;

	procedure leerPalabra(
		var partida	:text;
		var palabra	:string
	);
	Var
		caracter	: char;
		tmp 		: string;
	begin
		tmp := '';
		read(partida,caracter);
		while caracter <> ' ' do 
		begin
			tmp := tmp + caracter;
			read(partida,caracter);
		end;
		palabra := tmp;
	end;

VAR

    phaInicio : cartas = (SenoraBlanco, SenorVerde, SenoraCeleste,
			ProfesorCiruela, SenoritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    partida : Text;
    jugadores : Array[0..5] of usuario; // Arreglo de jugadores Jugador[0]:Usuario
    palabra : string;
    ultimoJ : integer;
    i : integer;
BEGIN 
    {$I-} 
    writeln;
    writeln('Lectura de un partida');
    writeln;
    
    assign(partida,'Partida.txt');
    reset(partida);
    
    (* Lectura de la primera linea (Numero de Jugadores) *)
    readln(partida, ultimoJ);
    while not eoln(partida) do
    begin
	leerPalabra(partida, palabra);
	writeln(palabra);
    end;
   
    readln(partida,sobre.prj, sobre.arma, sobre.habt);
    
    writeln('holaquemas');

    close(partida);  
    
    ultimoJ := ultimoJ - 1;
    writeln(ultimoJ);
    Writeln(sobre.prj, sobre.arma, sobre.habt);
    {$I+} 
END.