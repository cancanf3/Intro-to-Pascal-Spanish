PROGRAM leerArchivoTexto;

TYPE 
 
    pha = (SenioraBlanco, SeniorVerde, SenioraCeleste, ProfesorCiruela,
	   SenioritaEscarlata, CoronelMostaza, Biblioteca, Cocina, Comedor,
	   Estudio, Vestibulo, Salon, Invernadero, SalaDeBaile, SalaDeBillar,
	   Candelabro, Cuchillo, Cuerda, LlaveInglesa, Revolver, Tubo);
    
    p = SenioraBlanco..CoronelMostaza;
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

    Procedure leerPalabra(
	    var partida	:text;
	    var palabra	:string
    );
    Var
	    caracter	: char;
    Begin
	palabra := '';
	read(partida,caracter);
	if caracter = '	' then
	Begin
	    bullshit := True;
	End;
	
	While (caracter <> '	') And (caracter <> #10) Do 
	Begin
	    palabra := palabra + caracter;
	    writeln('leyendo ', palabra);
	    read(partida,caracter);			
	End;
    End;
	
    Function Indice(const aStr : string) : integer;
    Const
	phaStr : Array[pha] of string = ('SenioraBlanco', 'SeniorVerde', 'SenioraCeleste', 'ProfesorCiruela',
	'SenioritaEscarlata', 'CoronelMostaza', 'Biblioteca', 'Cocina', 'Comedor', 'Estudio',
	'Vestibulo', 'Salon', 'Invernadero', 'SalaDeBaile', 'SalaDeBillar', 'Candelabro',
	'Cuchillo', 'Cuerda', 'LlaveInglesa', 'Revolver', 'Tubo');
    Var
	aPHA : pha;
    Begin
	Indice := -1;
	For aPHA := SenioraBlanco to Tubo do
	Begin
	    If (aStr = phaStr[aPHA]) then
	    Begin
		Indice := Ord(aPHA);
		Break;
	    End;
	End;
    End;




VAR

    phaInicio : cartas = (SenioraBlanco, SeniorVerde, SenioraCeleste,
			ProfesorCiruela, SenioritaEscarlata, 
			CoronelMostaza, Biblioteca, Cocina, 
			Comedor, Estudio, Vestibulo, Salon, 
			Invernadero, SalaDeBaile, SalaDeBillar,
			Candelabro, Cuchillo, Cuerda, 
			LlaveInglesa, Revolver, Tubo);

    habitacion : Array[0..8] of lugar;
    sobre   : sbr; // Variable que contiene los hechos reales
    partida : text;
    jugadores : Array[0..5] of usuario; // Arreglo de jugadores Jugador[0]:Usuario
    palabra : array[0..20] of string;
    tmp : integer;
    ultimoJ : integer;
    i, j, k : integer;
    esta, bullshit	: boolean;
    iPHA : pha;
    co, x, y: integer;
               
BEGIN 
    co := 0;
    For i := 6 To 14 Do
    Begin
	habitacion[co].nombre := phaInicio[i];
	habitacion[co].alcanzable := False;
	co := co + 1;
    End;
    
    bullshit := false;
    co := 0;
    y  := 0;
    For i := 0 To 2 Do
    Begin
	x := 0;
	For j := 0 to 2 Do
	Begin
	    habitacion[co].x := x;
	    habitacion[co].y := y;
	    x := x + 2;
	    co := co + 1;
	End;
	y := y + 2;
    End;
    
    
    
    writeln;
    writeln('Lectura de un partida');
    writeln;
    
    assign(partida,'Partida.txt');
    reset(partida);
    
    readln(partida, ultimoJ);
    ultimoJ := ultimoJ - 1;

    i := 0;
    While not eoln(partida) Do
    Begin
	leerPalabra(partida,palabra[i]);
	i := i + 1;
    End;
    readln(partida);
    
    sobre.prj := phaInicio[Indice(palabra[0])];
    sobre.arma := phaInicio[Indice(palabra[1])];
    sobre.habt := phaInicio[Indice(palabra[2])];
    
    
    For i := 0 To ultimoJ Do
    Begin
    	For j := 0 To 2 Do
	Begin
	    leerPalabra(partida,palabra[j]);
	End;

	jugadores[i].peon := phaInicio[Indice(palabra[0])];
	jugadores[i].vida := palabra[1] = 'activo';
	jugadores[i].donde := phaInicio[Indice(palabra[2])];
	
	For j := 0 To 8 Do
	Begin
	    If habitacion[j].nombre = jugadores[i].donde Then
	    Begin
		jugadores[i].x := habitacion[j].x;
		jugadores[i].y := habitacion[j].y;
	    End;
	End;
	readln(partida, jugadores[i].conta.cartas, tmp); // tmp == descartadas
	
	For j := 0 To jugadores[i].conta.cartas - 1 Do
	Begin
	    leerPalabra(partida,palabra[j]);
	    jugadores[i].mano[j] := phaInicio[Indice(palabra[j])];
	End;
	readln(partida);
	
	writeln('-----------------------------------------------------------------------------------------');
	writeln(palabra[0]);
	
	For j := 0 To tmp - 1 Do
	Begin
	    leerPalabra(partida,palabra[j]);
	    Case Indice(palabra[j]) Of
		0..5   :
		Begin
		    jugadores[i].lista.prj[5 - jugadores[i].conta.prj] := phaInicio[Indice(palabra[j])];
		    jugadores[i].conta.prj := jugadores[i].conta.prj + 1;
		End;
		6..14  :
		Begin
		    jugadores[i].lista.habt[8 - jugadores[i].conta.habt] := phaInicio[Indice(palabra[j])];
		    jugadores[i].conta.habt := jugadores[i].conta.habt + 1;
		End;
		15..20 :
		Begin
		    jugadores[i].lista.arma[5 - jugadores[i].conta.arma] := phaInicio[Indice(palabra[j])];
		    jugadores[i].conta.arma := jugadores[i].conta.arma + 1;
		End;
	    End;
	End;
	if bullshit then
	begin
	    readln(partida);
	end;
	
	co := 0;
	For j := 0 To 5 Do
	Begin
	    k := 0;
	    esta := False;
	    While (k < 6) And not esta Do
	    Begin
		If (phaInicio[j] = jugadores[i].lista.prj[k]) Then
		Begin
		    esta := True;
		End;
		k := k + 1;
	    End;
	    If not esta Then
	    Begin
		jugadores[i].lista.prj[co] := phaInicio[j];
		writeln('-----------Entre---------');
		co := co + 1;
	    End;
	End;
	
	co := 0;
	For j := 6 To 14 Do
	Begin
	    k := 0;
	    esta := False;
	    While (k < 9) And not esta Do
	    Begin
		If (phaInicio[j] = jugadores[i].lista.habt[k]) Then
		Begin
		    esta := True;
		End;
		k := k + 1;
	    End;
	    If not esta Then
	    Begin
		jugadores[i].lista.habt[co] := phaInicio[j];
		writeln('-----------Entre---------');
		co := co + 1;
	    End;
	End;
	
	co := 0;
	For j := 0 To 5 Do
	Begin
	    k := 0;
	    esta := False;
	    While (k < 6) And not esta Do
	    Begin
		If (phaInicio[j] = jugadores[i].lista.arma[k]) Then
		Begin
		    esta := True;
		End;
		k := k + 1;
	    End;
	    If not esta Then
	    Begin
		jugadores[i].lista.arma[co] := phaInicio[j];
		writeln('-----------Entre---------');
		co := co + 1;
	    End;
	End;
	
    End;
		
    close(partida);
    
    writeln('cerre el archivo! todo bien! :)');
    
END.