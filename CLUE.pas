(*
 *
 * CLUE.pas
 *
 * Es un programa hecho bajo las especificaciones del proyecto 
 * de Algoritmos 1 basado en el juego CLUE
 * Contiene los tipos de datos, funciones con sus 
 * especificaciones y esquema general del juego.
 *
 * Autores:
 *  Jose Pena
 *  Jose Pascarella
 *
 * Ultima Modificacion: 
 *  01 / 04 2013
 *
 *)
PROGRAM CLUE;

TYPE 

    pha = (SenioraBlanco, SeniorVerde, SenioraCeleste, ProfesorCiruela,
    SenioritaEscarlata, CoronelMostaza, Biblioteca, Cocina, Comedor,
    Estudio, Vestibulo, Salon, Invernadero, SalaDeBaile, SalaDeBillar,
    Candelabro, Cuchillo, Cuerda, LlaveInglesa, Revolver, Tubo);
    
    p = SenioraBlanco..CoronelMostaza;
    h = Biblioteca..SalaDeBillar;
    a = Candelabro..Tubo;
    
    cartas = Array[0..20] of pha;
    prjs   = Array[0..5] of p;
    habts  = Array[0..8] of h;
    armas  = Array[0..5] of a;
    
    lugar      = Record
	    nombre     : h;
	    x          : integer;
	    y          : integer;
        alcanzable : boolean;
    End;
    
    sbr  =  Record
	    arma : a;
	    habt : h;
	    prj  : p;
    End;
	
    contadores = Record // Variable contadora de descarte para las jugadores 
	    arma       : integer;
	    habt       : integer;
	    prj        : integer;
	    cartas     : integer;
    End;
    
    lista_cartas = Record
	    arma         : armas;
	    habt         : habts;
	    prj          : prjs; 
    End;

    usuario  =  Record
	    x        : integer;
	    y        : integer;
	    usuario  : boolean;
	    vida     : boolean;
	    mano     : cartas;
	    donde    : h;
	    peon     : p;  // Ficha que usa para jugar
	    lista    : lista_cartas;  // Lista de cartas
	    conta    : contadores;
	    posicion : integer; 
    End;
  
  
   (* Procedimiento para evitar el runtime error en lectura de enteros *)
Procedure LecturaRobusta(
            Var Variable : integer;
            r            : string; // Primer mensaje para el usuario
            s            : string; // Mensaje al fallar
            inicio       : integer;
            tope         : integer);
Var 
    codigo : word;

Begin
    Repeat
Begin
    Writeln(r);
    {$IOCHECKS OFF}
    read(Variable);
    {$IOCHECKS ON}
    codigo := ioResult; 
    r := s;
End
Until (Variable < tope + 1) And (Variable > inicio - 1) And (codigo = 0);
End;

    (* Procedimiento que permite al usuario tomar decisiones *)
Procedure Decision (Var SioNo : boolean);
Var
    YN : integer;
    n  : integer;
    r  : string;
    s  : string;
{Pre:
True
}
{Post:
(SioNo == True) \/ (Siono == False)
}	
Begin
    Writeln('1.- Si');
    Writeln;
    Writeln('2.- No');
    Writeln;
    r := 'Eliga una opcion ';
    s := 'Error! Eliga otra vez';
    Repeat
    Begin
        LecturaRobusta(YN,r,s,1,2); 
        n := 0;
        Case YN of
        1:
            Begin
            SioNo := True;
            n := 1;
            End;
        2:
            Begin
            SioNo := False;
            n := 1;
            End;
        End;
    End
    Until ( n = 1 );
End;  

    (* Procedimiento que contiene las instrucciones del juego *)
Procedure Instrucciones ();
{Pre:
True
}
{Post;
True
}
    
Begin
Writeln('Este programa es una simulacion del juego de Clue o Sospecha.');
Writeln();
Writeln('Usted podra elejir jugar con 2 a 5 computadoras contra las cuales competira por encontrar el Asesino del Senor del Black',
'el lugar del crimen y el arma con la que se realizo. La mecanica del juego es la siguiente');



Writeln('	Reglas del Juego');
Writeln('1. El usuario elige una identidad que corresponde a uno de los personajes del juego.  Al resto de los');
Writeln('	    jugadores (que son de la máquina) se el asigna cualquiera de las identidates restantes');
Writeln('2. Sin que ninguno de los jugadores vea,  se elige al azar un trio de cartas.  Una carta de personaje,  que será el');
Writeln('  criminal, otra carta de entre las armas, que será el objeto agresor y otra de entre las habitaciones que será el lugar');
Writeln(' del crimen. Estas tres tarjetas se guardan ocultas en un sobre. El resto de las tarjetas se juntan, se revuelven y se');
Writeln('reparten uniformemente entre los jugadores sin que sobren cartas.');
Writeln('3. Los jugadores pueden hacer una lista de todas las cartas del juego e ir marcando las que les tocaron y que desde');
Writeln('luego no son las que están en el sobre.');
Writeln('4. Los jugadores se enumeran según el turno que le corresponde en el juego, siguiendo el sentido de las agujas del');
Writeln('reloj y dándole el primer turno al usuVario');
Writeln('	    5. Al inicio del juego, todos los peones que represetan a los personajes escogidos por los jugadores, se ubican en la');
Writeln('habitación del centro del tablero, desde allí iniciarán el juego.');
Writeln('6. Se lanza el dado, y según la posición actual y el número arrojado por el dado se escoge entre las habitaciones a la');
Writeln('que puede llegar, incluyendo la misma habitación actual. No es permitido quedarse en los pasillos, sino que debe');
Writeln('escogerse siempre una habitación.  Para llegar a una habitación no es imprescindible obtener una puntuación');
Writeln('exacta.');
Writeln('7. Una vez ubicado en una habitación, el jugador puede hacer la sospecha. La sospecha incluye el lugar en donde se');
Writeln('encuentra,  el arma y personaje.  El peón del  personaje que se incluya en la sospecha se traslada al cuarto');
Writeln('sugerido. El peón movido desde su habitación para que se formule una sospecha no regresa, después, a');
Writeln('su punto de origen; continúa su juego a partir de la nueva posición sobre el tablero de juego.');
Writeln('8. El jugador a la izquierda de quien formuló la sospecha, debe refutar la sospecha. Para ello, revisa en');
Writeln('sus cartas si tiene alguna de las que mencionó el participante.  De ser así, se la enseña sólo al que');
Writeln('preguntó sin que los otros jugadores puedan verlo, para que éste la elimine de su lista, ya que seguramente no');
Writeln('será esa la que este dentro del sobre. Si tiene más de una tarjeta de las que se mencionaron en la sospecha, solo');
Writeln('tiene que enseñar una, la que elija.'); 
Writeln('9. Si un jugador no puede refutar la sospecha, por no tener ninguna de las cartas, al jugador que se encuentra a la');
Writeln('izquierda de éste le corresponde entonces refutar la sospecha. Asi sucesivamente hasta que haya un jugador que');
Writeln('refuta la sospecha o ninguno de los jugadores diferentes al que formulo la sospecha haya podido refutarla.');
Writeln('10. Si un jugador hace una sospecha y ninguno de los otros jugadores puede refutarla; el jugador puede hacer una');
Writeln('acusación. De ser así, el jugador comprueba la validez de la misma mirando las cartas del sobre. Si es incorrecta,');
Writeln('queda eliminado del juego (ya que conoce la solución al mismo). Si es correcta, las cartas se muestran al resto de');
Writeln('los participantes.');
Writeln('11. El juego termina cuando un jugador hace una acusación que se comprueba correcta, en este caso ese jugador se');
Writeln('declara ganador. En caso que el usuario sea eliminado, por haber hecho una falsa acusación, se declara ganador a');
Writeln('la máquina y termina el juego. Si todos los jugadores, excepto el usuario, son eliminados por falsa acusación, el');
Writeln('juego termina y el  usuario se declara ganador');
readln;
End;

(* Procedimiento que la bienvenida al usuario *)
Procedure Bienvenida ();
{Pre:
True
}
{Post;
True
}
Begin
    Writeln('    ,o888888o.    8 8888      8 8888      88 8 8888888888 ',
            '         8 8888      88    d888888o.   8 888888888o   ');
    Writeln('   8888     `88.  8 8888      8 8888      88 8 8888       ',
            '         8 8888      88  .`8888:` `88. 8 8888    `88. ');
    Writeln(',8 8888       `8. 8 8888      8 8888      88 8 8888       ',
            '         8 8888      88  8.`8888.   Y8 8 8888     `88 ');
    Writeln('88 8888           8 8888      8 8888      88 8 8888       ',
            '         8 8888      88  `8.`8888.     8 8888     ,88 ');
    Writeln('88 8888           8 8888      8 8888      88 8 88888888888',
            '8        8 8888      88   `8.`8888.    8 8888.   ,88  ');
    Writeln('88 8888           8 8888      8 8888      88 8 8888       ',
            '         8 8888      88    `8.`8888.   8 8888888888   ');
    Writeln('88 8888           8 8888      8 8888      88 8 8888       ',
            '         8 8888      88     `8.`8888.  8 8888    `88. ');
    Writeln('`8 8888       .8` 8 8888      ` 8888     ,8P 8 8888       ',
            '         ` 8888     ,8P 8b   `8.`8888. 8 8888      88 ');
    Writeln('   8888     ,88`  8 8888        8888   ,d8P  8 8888       ',
            '           8888   ,d8P  `8b.  ;8.`8888 8 8888    ,88  ');
    Writeln('    `8888888P`    8 888888888888 `Y88888P    8 88888888888',
            '8           `Y88888P`    `Y8888P ,88P` 8 888888888P   ');
Writeln;
    Writeln('Bienvenido a Clue USB!');
    Writeln();

End;

    (* Procedimiento que Imprime el tablero *)
Procedure TableroClue ();
{Pre:
True
}
{Post;
True
}
Begin
    Writeln(' _________________________________________________________',
            '_____________________________________________________  ');
            
    Writeln('/                     |                      |            ',
            '         |                      |                    \ ');
    Writeln('|                     |______________________|            ',
            '         |______________________|                     |');
    Writeln('|                                                         ',
            '                                                      |');
            
    Writeln('|      Biblioteca                                    Cocin',
            'a                                       Comedor       |');                  
    Writeln('|                      ________      ________             ',
            '          ________      ________                      |');
    Writeln('|                     |        |    |        |            ',
            '         |        |    |        |                     |');
    Writeln('|_______       _______|        |    |        |_______     ',
            '  _______|        |    |        |_______       _______|');
    Writeln('|       |     |                |    |                |    ',
            ' |                |    |                |     |       |');
    Writeln('|       |     |________________|    |________________|    ',
            ' |________________|    |________________|     |       |');
    Writeln('|       |                                                 ',
            '                                              |       |');
    Writeln('|       |                                                 ',
            '                                              |       |');
    Writeln('|       |      ________________      ________________     ',
            '  ________________      ________________      |       |');
    Writeln('|       |     |                |    |                |    ',
            ' |                |    |                |     |       |');
    Writeln('|_______|     |_______         |    |         _______|    ',
            ' |_______         |    |         _______|     |_______|');
    Writeln('|                     |        |    |        |            ',
            '         |        |    |        |                     |');
    Writeln('|                     |________|    |________|            ',
            '         |________|    |________|                     |');
    Writeln('|                                                         ',
            '                                                      |');
    Writeln('|       Estudio                                     Vestib',
            'ulo                                      Salon        |');
    Writeln('|                      ________      ________             ',
            '          ________      ________                      |');
    Writeln('|                     |        |    |        |            ',
            '         |        |    |        |                     |');
    Writeln('|_______       _______|        |    |        |_______     ',
            '  _______|        |    |        |_______       _______|');
    Writeln('|       |     |                |    |                |    ',
            ' |                |    |                |     |       |');
    Writeln('|       |     |________________|    |________________|    ',
            ' |________________|    |________________|     |       |');
    Writeln('|       |                                                 ',
            '                                              |       |');
    Writeln('|       |                                                 ',
            '                                              |       |');
    Writeln('|       |      ________________      ________________     ',
            '  ________________      ________________      |       |');
    Writeln('|       |     |                |    |                |    ',
            ' |                |    |                |     |       |');
    Writeln('|_______|     |_______         |    |         _______|    ',
            ' |_______         |    |         _______|     |_______|');
    Writeln('|                     |        |    |        |            ',
            '         |        |    |        |                     |');
    Writeln('|                     |________|    |________|            ',
            '         |________|    |________|                     |');
    Writeln('|                                                         ',
            '                                                      |');
    Writeln('|     Invernadero                                   SalaDe',
            'Baile                                 SalaDeBillar    |');
    Writeln('|                      ______________________             ',
            '          ______________________                      |');
    Writeln('|                     |                      |            ',
            '         |                      |                     |');
    Writeln('\_____________________|______________________|____________',
            '_________|______________________|____________________/ ');
    
End;
    
    (* Procedimiento de preparacion para el Usuario *)
Procedure Introduccion(Var SioNo : boolean);
{Pre:
`True
}
{Post:
True
}
Begin
Bienvenida;
Writeln('Desea leer las instrucciones?');
Writeln('La partida se va a guardar automaticamente', 
        'en el archivo ./Partida.txt');
Decision(SioNo);
    If SioNo Then
    Begin
        Instrucciones;
        Write('Presione <ENTER>');
        Readln;
    End
    Else
    Begin
        Readln;
    End;
    
    writeln;
    writeln('Este es el tablero de juego!');
    TableroClue;
    Writeln('Bien! Juguemos!');
    Write('Presione <ENTER>');
    readln;
End;
    
Procedure leerPalabra(
    var partida	:text;
    var palabra	:string;
    var saltoLinea : boolean
);
Var
    caracter	: char;
Begin
palabra := '';
read(partida,caracter);
saltoLinea := false;
While (caracter <> '	') And (caracter <> #10) And (caracter <> ' ') Do 
Begin
    palabra := palabra + caracter;
    read(partida,caracter);
End;
if (caracter = #10) then
Begin
    saltoLinea := True;
End;
writeln('Lei  ------>  (', palabra, ')');
End;
    
Function Indice(const aStr : string) : integer;
Const
phaStr : Array[pha] of string = ('SenioraBlanco', 'SeniorVerde',
                'SenioraCeleste', 'ProfesorCiruela',
                'SenioritaEscarlata', 'CoronelMostaza',
                'Biblioteca', 'Cocina', 'Comedor', 
                'Estudio',	'Vestibulo', 'Salon',
                'Invernadero', 'SalaDeBaile',
                'SalaDeBillar', 'Candelabro', 'Cuchillo',
                'Cuerda', 'LlaveInglesa', 'Revolver',
                'Tubo');
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
    
Procedure Cargar(phaInicio : cartas;
        habitacion : Array of lugar;
        var jugadores : Array of usuario;
        var sobre : sbr;
        var ultimoJ : integer;
        var turnoActual : integer);
Var
i, j, k : integer;
co : integer;
partida : text;
palabra : array[0..20] of string;
tmp : integer;
esta : boolean; 
saltoLinea	: boolean;
Begin
writeln;
writeln('Lectura de un partida');
writeln;

assign(partida,'Partida.txt');
reset(partida);

readln(partida, ultimoJ);
ultimoJ := ultimoJ - 1;

writeln;
writeln('(************************************************)');
writeln('(*             NUMERO DE COMUTADORAS            *)');
writeln('(*                   ',ultimoJ, '                  *)');
writeln('(************************************************)');
writeln;

For i := 0 To 2 Do
Begin
    leerPalabra(partida, palabra[i], saltoLinea);
End;
readln(partida);

sobre.prj := phaInicio[Indice(palabra[0])];
sobre.arma := phaInicio[Indice(palabra[1])];
sobre.habt := phaInicio[Indice(palabra[2])];

writeln;
writeln('(************************************************)');
writeln('(*                 HECHOS REALES                *)');
writeln('(*     ', sobre.prj,' ', sobre.arma, ' ', sobre.habt, '    *)');
writeln('(************************************************)');
writeln;

For i := 0 To ultimoJ Do
Begin

    jugadores[i].posicion := i;
    For j := 0 To 2 Do
    Begin
    leerPalabra(partida, palabra[j], saltoLinea);
    End;

    jugadores[i].peon := phaInicio[Indice(palabra[0])];
    jugadores[i].vida := palabra[1] = 'activo';
    jugadores[i].donde := phaInicio[Indice(palabra[2])];
    
    
    writeln;
    writeln('(************************************************)');
    writeln('(*      JUGADOR(',i,')   VIDA   UBICACION             *)');
    writeln('(*         ',jugadores[i].peon, ' ', jugadores[i].vida, ' ', jugadores[i].donde,  '        *)');
    
    writeln('(************************************************)');
    writeln;
    
    
    For j := 0 To 8 Do
    Begin
    If habitacion[j].nombre = jugadores[i].donde Then
    Begin
        jugadores[i].x := habitacion[j].x;
        jugadores[i].y := habitacion[j].y;
    End;
    End;
    readln(partida, jugadores[i].conta.cartas, tmp); // tmp == descartadas
    
    writeln;
    writeln('(*    ',jugadores[i].conta.cartas,'   ', tmp, '      *)');
    writeln;
    
    For j := 0 To jugadores[i].conta.cartas - 1 Do
    Begin
    leerPalabra(partida, palabra[j], saltoLinea);
    jugadores[i].mano[j] := phaInicio[Indice(palabra[j])];
    End;
    If not saltoLinea Then
    Begin
    readln(partida);
    End;
    writeln;
    writeln('(************************************************)');
    writeln('(*         CARTAS QUE POSEE EL JUGADOR(',i,')          *)');
    write('(*    ');
    For j := 0 To jugadores[i].conta.cartas - 1 Do
    Begin
    write(jugadores[i].mano[j], ' ');
    End;
    writeln('    *)');
    writeln('(************************************************)');
    writeln;
    
    For j := 0 To tmp - 1 Do
    Begin
    leerPalabra(partida, palabra[j], saltoLinea);
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
    
    writeln;
    writeln('(*****************************************************)');
    writeln('(*         CARTAS DESCARTADAS POR EL JUGADOR',i,'         *)');
    write('(*    ');
    For j := 0 To tmp - 1 Do
    Begin
    write(palabra[j], ' ');
    End;
    writeln('    *)');
    writeln('(*****************************************************)');
    writeln;
    
    If not saltoLinea Then
    Begin
    readln(partida);
    End;
    
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
        co := co + 1;
    End;
    End;
    
    co := 0;
    For j := 15 To 20 Do
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
        co := co + 1;
    End;
    End;
    
End;
    
leerPalabra(partida, palabra[0], saltoLinea);
For i := 0 To ultimoJ Do
Begin
    If jugadores[i].peon = phaInicio[Indice(palabra[0])] Then
    Begin
    turnoActual := i;
    End;
End;

close(partida);

writeln('cerre el archivo! todo bien! :)');

For i := 0 to ultimoJ do
begin
    writeln('lista del jugador ', i); 
    for j := 0 to 5 Do
    begin
    writeln(jugadores[i].lista.arma[j]);
    end;
    writeln;
    for j := 0 to 5 Do
    begin
    writeln(jugadores[i].lista.prj[j]);
    end;
    writeln;
    for j := 0 to 8 Do
    begin
    writeln(jugadores[i].lista.habt[j]);
    end;
    writeln;
end;




End; //Procedure
   
    
    



    (* Permite ingresar el numero de Computadoras *)
Procedure NComputadoras(Var ultimoJ : integer);
Var 
r,s : string;
{Pre:
True
}

{Post:
ultimoJ > 1 /\ ultimoJ < 6
}
Begin
    r := 'Ingrese el numero de computadoras contra las que desea jugar (2-5) ';
    s := 'Opcion no valida, elija entre 2 y 5 computadoras: ';
LecturaRobusta(ultimoJ,r,s,2,5);
End;
    
    (* Inicializacion de Variables *)
Procedure Inicializa (
            Var phaInicio     : cartas;
            var sobre : sbr;
            var turnoActual : integer;
            var partidaCargada:boolean;
            var ultimoJ           : integer;
            Var habitacion    : array of lugar;
            Var jugadores     : Array of usuario;
            Var Turno         : longint;
            Var SioNo         : boolean;
            Var juegoActivo   : boolean;
            Var sospechaConta : integer);
Var 
    i, j : integer; // Variables de iteracion.
    x, y : integer; // Variables auxiliares.
    co   : integer; // Variable contador.
{Pre:
True
}

{Post:
True
}
    
Begin

(* Habitaciones *)
co := 0;
    For i := 6 To 14 Do
    Begin
        habitacion[co].nombre := phaInicio[i];
        habitacion[co].alcanzable := False;
        co := co + 1;
    End;
    
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
    
    juegoActivo := True;
    turnoActual := 0;
    Turno := 0;
    sospechaConta := 0;
    SioNo := True; 
    partidaCargada := False;
    Writeln('Desea cargar una partida previa?');
    Decision(Siono);
    If Siono Then
    Begin
        Cargar(phaInicio, habitacion, jugadores, sobre, ultimoJ, turnoActual);
        partidaCargada := True;
    End
    Else
    Begin
    NComputadoras(ultimoJ);
    For i := 0 to ultimoJ Do // Inicializo a todos los jugadores
    Begin
        jugadores[i].conta.arma := 0;
        jugadores[i].conta.habt := 0;
        jugadores[i].conta.prj  := 0;
        jugadores[i].conta.cartas := 0;
        jugadores[i].x := 2;
        jugadores[i].y := 2;
        jugadores[i].usuario := False;
        jugadores[i].donde := Vestibulo;
        jugadores[i].posicion := i;
        jugadores[i].vida := True;
   End;
    End;
    (* Descarto a las computadoras que no juegan *)
    For i := ultimoJ + 1 To 5 Do 
    Begin
        jugadores[i].vida := False;
    End;
    
    (* Se da la condicion de usuario a un jugador *)
    jugadores[0].usuario := True; 
End;

    (* Swap de Variables de tipo entero *)
Procedure Swap (Var n : integer; Var m : integer);
Var
tmp : integer; // Variable temporal para el Intercambio

{Pre:
True
}

{Post:

}	
Begin
    tmp := n;
    n := m;
    m := tmp;
End;   
    
    (* Permite cambiar la lista de cartas de cada jugador *)
Procedure Swap_descarte(
            Var jugador : usuario; 
                n       : integer; 
                m       : integer; 
                k       : integer
                    );
Var
    tmp1 : a;
    tmp2 : h;
    tmp3 : p;
{Pre: 
k >= 0 /\ k <= 1 /\ n <= 8 /\ m <= 0
}
{Post: 
n = m0 /\ m = n0 
}
Begin
    Case k of 
        0 :
        Begin
            tmp1 := jugador.lista.arma[n];
            jugador.lista.arma[n] := jugador.lista.arma[m];
            jugador.lista.arma[m] := tmp1;
        End;
        2 :
        Begin
            tmp2 := jugador.lista.habt[n];
            jugador.lista.habt[n] := jugador.lista.habt[m];
            jugador.lista.habt[m] := tmp2;
        End;
        1 :
        Begin
            tmp3 := jugador.lista.prj[n];
            jugador.lista.prj[n] := jugador.lista.prj[m];
            jugador.lista.prj[m] := tmp3;
        End;
    End;
End;     
    
    (* Funcion que genera numeros aleatorios en un rango dado *)
Function Aleatorio(
            inicio : integer; 
            tope   : integer
                ) : integer;
Var 
    amplitud : integer;
{Pre:
True
}
{Post:
(Aleatorio >= inicio) /\ (Aleatorio <= Tope)
}	
Begin
    amplitud := (tope - inicio) + 1;
    Aleatorio := Random(amplitud) + inicio;
End;
    

    (* Proceso para Seleccionar Personaje *)
Procedure SeleccionPersonaje(
                phaInicio : cartas; 
            Var jugadores : Array of usuario;
                ultimoJ  : integer);
{Pre:
True
}
{Post:
------------------------------------------------------------
}	
Var
    i        : integer;
    r,s      : string;
    repartir : Array[0..5] of integer = (0,1,2,3,4,5);
Begin
    Writeln('Seleccione un personaje ingresando el numero correspondiente.');
    For i := 0 To 5 Do
    Begin
        Writeln(i+1, '.- ', phaInicio[i]);
    End;

    r := 'Seleccion: ';
    s := 'Opcion no valida, intente de nuevo: ';
    LecturaRobusta(i,r,s,1,6);
    
    jugadores[0].peon := phaInicio[i-1];
    Writeln('El personaje seleccionado fue: ', jugadores[0].peon);
    Writeln;

(* Asignamos los personajes a las Computadoras *)
    Swap(repartir[i-1], repartir[5]);
    Writeln('(************************************************)'); 
    For i:= 1 To ultimoJ Do
    Begin
        jugadores[i].peon := phaInicio[repartir[i-1]];
        Writeln('Jugador ', i + 1, ' Selecciona a: ', jugadores[i].peon);
    End;
    Writeln('(************************************************)');

End;
    
    (* Proceso que elije las cartas del sobre y reparte las demas *)
Procedure AsignarCartas (
                phaInicio : cartas;
            Var jugadores : array of usuario; 
            Var sobre     : sbr; 
                ultimoJ   : integer
                        );
Var 
    repartir   : Array[0..20] of integer = (0,1,2,3,4,5,6,7,8,9,10,11,12,
                        13,14,15,16,17,18,19,20);
    n,x,y,z         : integer;
    i,j,k,co,aux    : integer;
    esta            : boolean;

    
{Pre:
True
}
{Post:

}	
Begin
    (* Se seleccionan los hechos reales *)
    x := Aleatorio(0,5);
    sobre.prj := phaInicio[x];
    y := Aleatorio(6,14);
    sobre.habt := phaInicio[y];
    z := Aleatorio(15,20);
    sobre.arma := phaInicio[z];
    
    (* Muevo las Variables a las tres posiciones finales para 
        no repartir las cartas del sobre *)
    Swap(repartir[z], repartir[20]);
    Swap(repartir[y], repartir[19]);
    Swap(repartir[x], repartir[18]);
    
    (* Aqui hago Shuffle del arreglo de todas las cartas 
        excluyendo las del sobre *)
    For i := 17 Downto 1 Do
    Begin
        n := Aleatorio(0,i);
        Swap(repartir[i], repartir[n]);
    End;


    
    (* Reparto las cartas dependiendo del numero de jugadores *)
    co := 0;
    While (co < 18) Do
    Begin
        i := 0;
        While (i < ultimoJ + 1) And (co < 18) Do
        Begin
            jugadores[i].mano[jugadores[i].conta.cartas] 
            := phaInicio[repartir[co]];

            If jugadores[i].usuario Then
            Begin
            Writeln(' Te dieron: ',jugadores[i].mano[jugadores[i].conta.cartas]);
            End;

            z := ord(jugadores[i].mano[jugadores[i].conta.cartas]);

            Case z Of
            0..5   :
            Begin
            jugadores[i].lista.prj[5 - jugadores[i].conta.prj] := phaInicio[z];
            jugadores[i].conta.prj := jugadores[i].conta.prj + 1;
            End;
            6..14  :
            Begin
            jugadores[i].lista.habt[8 - jugadores[i].conta.habt] := phaInicio[z];
            jugadores[i].conta.habt := jugadores[i].conta.habt + 1;
            End;
            15..20 :
            Begin
            jugadores[i].lista.arma[5 - jugadores[i].conta.arma] := phaInicio[z];
            jugadores[i].conta.arma := jugadores[i].conta.arma + 1;
            End;
        End;

        aux := 0;
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
            jugadores[i].lista.prj[aux] := phaInicio[j];
            aux := aux + 1;
        End;
        End;
        
        aux := 0;
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
            jugadores[i].lista.habt[aux] := phaInicio[j];
            aux := aux + 1;
        End;
        End;
        
        aux := 0;
        For j := 15 To 20 Do
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
                jugadores[i].lista.arma[aux] := phaInicio[j];
                aux := aux + 1;
            End;
        End;


            jugadores[i].conta.cartas := jugadores[i].conta.cartas + 1;
            co := co + 1;
            i := i + 1;
        End;
    End;
    Writeln('armas',jugadores[0].conta.arma);
    Writeln('prj',jugadores[0].conta.prj);
    Writeln('habt',jugadores[0].conta.habt);
End;
    
    (* Funcion que calcula el valor absoluto de un entero dado *)
Function VA(n : integer): integer;
{Pre:
True
}
{Post:
n < 0 ==> (VA = n * -1)
/\ n >= 0 ==> (VA = n)
}	
Begin
If (n < 0) Then
Begin
    VA := n * -1;
End
Else
Begin
    VA := n;
End;
End;

(* Funcion que calcula la distancia ente un usuario y una habitacion *)
Function Distancia(
            jugador    : usuario; 
            Habitacion : lugar
                )    : integer;
{Pre:
True
}
{Post:
Distancia = |Habitacion.x - jugador.x| + |Habitacion.y - jugador.y|
}	
Begin
    Distancia := VA(Habitacion.x - jugador.x) 
            + VA(Habitacion.y - jugador.y);
End;
    
    (* Procedimiento que permite mover a los jugadores *)   
Procedure Mover (
            Var jugador    : usuario; // Usurio o Computadora.
                n          : integer;    // Lo que saco con el dado.
                Habitacion : array of lugar);
Var
    eleccion : Array[0..8] of integer; // Ayuda para Habts. Alcanzables.
    moverA   : integer; // Eleccion del Usuario.
    co, i    : integer; // Contadores.
    r,s      : string;
{Pre:
True
}
{Post:

}	
Begin
Case n Of // Case de los numeros del Dado (1..6)
    1    :  
    Begin
        Writeln('Debe permanecer en su posicion: ', jugador.donde);
        Exit;
    End;
    2..6 : 
    Begin
    If jugador.usuario then // Caso Usuario
    Begin
        co := 0;
        Writeln('Habitaciones Alcanzables');
        For i := 0 To 8 Do
        Begin
        If Distancia(jugador,Habitacion[i]) <= n Then
        Begin 
            Habitacion[i].alcanzable := True;
            Writeln(co + 1,'.- ', Habitacion[i].nombre, ' es alcanzable.'); 
            eleccion[co] := i;
            co := co + 1;
        End;
        End;
        Writeln;
        Writeln('Tienes ',jugador.conta.habt,' Habitaciones Descartadas');
        For i := ( 8 - jugador.conta.habt ) to 7 Do
        Begin
            Writeln;
            Writeln(jugador.lista.habt[i+1]);
        End;
        Writeln;

        r :='Ingrese el numero correspondiente';
        s :='Numero Ingresado no valido, intente de nuevo';
        LecturaRobusta(moverA,r,s,1,co);

        jugador.x := Habitacion[eleccion[moverA - 1]].x;
        jugador.y := Habitacion[eleccion[moverA - 1]].y;
        jugador.donde := Habitacion[eleccion[moverA - 1]].nombre;
        Writeln('Ahora se encuentra en: ', jugador.donde);
    End 
    Else
    Begin // Caso computadora
        For i := 0 To 8 Do
        Begin
        If Distancia(jugador,Habitacion[i]) <= n Then
        Begin 
            Writeln(Habitacion[i].nombre, ' es alcanzable');
            Habitacion[i].alcanzable := True;
        End;
        End;
    
        i := Aleatorio(0,8);
        While (Habitacion[i].nombre = jugador.donde) 
        And Not habitacion[i].alcanzable Do
        Begin
            i := Aleatorio(0,8);
        End;
        
        jugador.donde := Habitacion[i].nombre;
        jugador.x := Habitacion[i].x;
        jugador.y := Habitacion[i].y;
        Writeln(jugador.peon,' se movio hacia ', jugador.donde);
    End;
    End;
End;
End;

    (* Procedimiento que mueve a un sospechoso/acusado *)
Procedure MoverSospechoso (
                sospeAcu  : sbr; // Acusacion o Sospecha realizada
                ultimoJ   : integer; // Numero de Computadoras
            Var jugador   : usuario; // Jugador que Sopecho/Acuso 
            Var jugadores : array of usuario
                        );
Var
    i : integer;
Begin
    For i := 0 To ultimoJ Do
    Begin
        If (jugadores[i].peon = sospeAcu.prj) 
        And jugadores[i].vida  Then
        Begin
            Writeln('Posicion del que realiza la sospecha: ', 
                    jugador.donde);
            Writeln('Posicion previa del sospechoso: '
                , jugadores[i].donde);
            jugadores[i].x := jugador.x;
            jugadores[i].y := jugador.y;
            jugadores[i].donde := jugador.donde;
            Writeln('Movi al jugador(', i + 1, ') a la posicion del jugador('
                    , jugador.posicion + 1,'): ', jugadores[i].donde);
        End;
    End;
End;

    (* Repartir Cartas al eliminar a un jugador *)
Procedure RepartirEliminado (Var jugador : usuario;
                Var jugadores : array of usuario;
                ultimoJ : integer);
Var 
    i  : integer;
    co : integer;
{Pre:
True
}
{Post:

}	
Begin
    For i := 0 to jugador.conta.cartas Do
    Begin
        Writeln(jugador.mano[i],' ',i);
        Writeln;
    End;
    Writeln;

    co := 0;
    i := jugador.posicion + 1;
    While (i < ultimoJ + 1) And (co < jugador.conta.cartas) Do
    Begin
        jugadores[i].conta.cartas := jugadores[i].conta.cartas + 1;
        jugadores[i].mano[jugadores[i].conta.cartas] := jugador.mano[co];
    
        Writeln('Jugador',i,' Tiene ',jugadores[i].conta.cartas,
                ' cartas','   Carta: ', 
                jugadores[i].mano[jugadores[i].conta.cartas]);
        co := co + 1;
        i := i + 1;
    End;
        
    While (co < jugador.conta.cartas) Do
    Begin
        i := 0;
        While (i < ultimoJ + 1) And (co < jugador.conta.cartas) Do
        Begin
        If ( i = jugador.posicion ) Then
        Begin
            i := i + 1;
        End;
        jugadores[i].conta.cartas := jugadores[i].conta.cartas + 1;
        jugadores[i].mano[jugadores[i].conta.cartas] := jugador.mano[co];
        Writeln('Jugador', i,' Tiene ',jugadores[i].conta.cartas,
                ' cartas','  Carta: ', 
                jugadores[i].mano[jugadores[i].conta.cartas]);
        co := co + 1;
        i := i + 1;
        End;
    End;
    jugador.conta.cartas := 0;
    Writeln;
    Writeln;
    Writeln;
    Writeln;
End;
    
    (* Procedimiento que elimina jugadores segun sus acusaciones *)
Procedure Eliminar(
        Var jugador   : usuario;
        Var jugadores : Array of usuario;
            acusacion : sbr;
            sobre     : sbr;
            ultimoJ   : integer);
{Pre:
True
}
{Post:
(acusacion.prj != sobre.prj) ==> (jugador.vida == False) 
\/ (acusacion.habt != sobre.habt) ==> (jugador.vida == False) 
\/ (acusacion.arma != sobre.arma) ==> (jugador.vida == False) 
}	
Begin
    If (acusacion.prj <> sobre.prj) 
        Or (acusacion.habt <> sobre.habt ) 
        Or (acusacion.arma <> sobre.arma ) Then
    Begin
        Writeln('El jugador', jugador.posicion + 1, ' ha muerto :(.'); 
        jugador.vida := False;
    End;
    RepartirEliminado(jugador,jugadores,ultimoJ);
End;
    
    (* Proceso que permite guardar la partida pra retomarla luego *)
Procedure Guardar (
            jugadores : Array of usuario;
            ultimoJ   : integer;
            sobre     : sbr;
        Var partida   : text
                );
Var 
    i,j  : integer;
    tmp  : integer;
{Pre:

}
{Post:

}	
Begin
    Assign(partida,'Partida.txt');
    Rewrite(partida);

    Writeln(partida, ultimoJ + 1);
    Writeln(partida, sobre.prj, '	', sobre.arma, '	', sobre.habt, '	');

    For i := 0 To ultimoJ Do
    Begin
        
        Write(partida, jugadores[i].peon, '	');
        If jugadores[i].vida Then
        Begin
            Write(partida, 'activo	');
        End
        Else
        Begin
            Write(partida, 'eliminado	');
        End;
        (*
        * Hasta aqui la escritura esta bien 
        *)
        tmp := 0;
        tmp := jugadores[i].conta.arma + jugadores[i].conta.habt 
                + jugadores[i].conta.prj;
                
        Writeln(partida, jugadores[i].donde, '	', jugadores[i].conta.cartas
                , '	', tmp, '	');
        
        (* Cartas que posee el jugador *)
        For j := 0 To jugadores[i].conta.cartas - 1 Do
        Begin
            Write(partida, jugadores[i].mano[j], '	');
        End;
            Writeln(partida);

        (* Personajes Descartados *)
        For  j := (5 - jugadores[i].conta.prj) To 4  Do
        Begin
            Write(partida, jugadores[i].lista.prj[j], '	');
        End;
        (* Armas Descartadas *)
        For j := (5 - jugadores[i].conta.arma)  To 4 Do
        Begin
            Write(partida, jugadores[i].lista.arma[j], '	');
        End;
        (* Habitaciones Descartadas *)
        For j := (8 - jugadores[i].conta.habt) To 7 Do
        Begin
            Write(partida, jugadores[i].lista.habt[j], '	');
        End;
            Writeln(partida);
            End;
    Writeln(partida, jugadores[jugadores[i].posicion + 1].peon); 
    Close(partida);
End;
    
    (* Mensaje de despedida para el usuario *)
Procedure Despedida;
{Pre
juegoActivo = False
}
{Pos
True
}
Begin
    Writeln;
    Writeln('<------Gracias por jugar CLUE--------> ');
    Writeln('Esperamos que haya podido disfrutar la experiencia de ');
    Writeln('haber ido por el camino de las pistas y la intuicion ');
    Writeln('para descrubir los hechos del asesinato de MR. BLACK ');
    Writeln;
    Writeln;
    Writeln;
    Writeln('Copyright 2013 <---MAC---> . Todos los derechos reservados.');
End;
    
    (* Procedimiento que chequea si el juego debe terminar *)
Procedure Fin(
        jugadores   : array of usuario;
        acusacion   : sbr;
        sobre       : sbr;
    Var juegoActivo : boolean
            );
Var
    i : integer;
    {Pre:
    True
    }
    {Post:
    ((%forall i \ 0 < i < 6 : !jugadores[i].vida) ==> (juegoActivo == False))
    \/ (!jugadores[0].vida ==> (juegoActivo == False))
    \/ ((acusacion == sobre) ==> (juegoActivo == False))
    }
Begin
(* Chequeo si alguna computadora sigue viva *)
    juegoActivo := False;
    i := 1;
    While (i < 6) And (juegoActivo = False) Do
    Begin
        juegoActivo := jugadores[i].vida;
        i := i + 1;
    End;
    
    (* Chequeo si el usuario fallo haciendo una acusacion *)
    If Not jugadores[0].vida Then
    Begin
        juegoActivo := False;
        Writeln('Usted ha muerto');
        Despedida;
        halt;
    End;

    (* Chequeo si se realizo una acusacion correcta *)
    If (acusacion.prj = sobre.prj) 
        And (acusacion.habt = sobre.habt) 
        And (acusacion.arma = sobre.arma) Then
    Begin
        juegoActivo := False;
        Writeln('Se ha adivinado el sobre!!');
        Writeln;
    End;
    If juegoActivo Then
    Begin
        Writeln('<-----------El juego no ha Terminado---------->');
    End
    Else
    Begin
        Writeln('<-----------El juego ha Terminado----------->');
	Writeln('Las cartas en el sobre son: ');
	Writeln(sobre.prj);
	Writeln(sobre.arma);
	Writeln(sobre.habt);
        halt;
    End;
End;




    (* Procedimientos para Sospecha *)


    (* Procedimiento que permite hacer match de las manos de los jugadores*)

Procedure Chequeo_cartas ( 
        Var carta        : Array of sbr ; 
            jugadorTurno : usuario ;             
            jugadores    : Array of usuario ; 
        Var sospechaON   : boolean ;
        Var k            : integer ; 
        Var quien        : integer;
        Var humano       : boolean; 
            ultimoj      : integer;
            sospech      : sbr 
                        );
Var
    i,j : integer; // Contadores
    {Pre:
    sospech.arma = (% Exist x : 0 <= x <= 5 : jugadorTurno.lista.arma[x] ) /\
    sospech.prj = (% Exist x : 0 <= x <= 5 : jugadorTurno.lista.prj[x] ) /\
    sospech.habt = jugadorTurno.donde    
    }
    
    {Post:
    carta.arma = (% First : jugadorTurno.posicion + 1 <= y <= 5 /\ 
                        0 <= y <= jugadorTurno.posicon - 1 : 
                    (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                        jugadores[y].mano[x] = sospech.arma)) \/ 
    carta.prj = (% First : jugadorTurno.posicion + 1 <= y <= 5 /\ 
                        0 <= y <= jugadorTurno.posicon - 1 : 
                    (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                        jugadores[y].mano[x] = sospech.prj)) \/
    carta.habt = (% First : jugadorTurno.posicion + 1 <= y <= 5 /\ 
                        0 <= y <= jugadorTurno.posicon - 1 : 
                    (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                        jugadores[y].mano[x] = sospech.habt)) 


    }	



Begin

    If  not ( jugadorTurno.usuario ) Then
    Begin
        { Inv carta.arma = (% First : jugadorTurno.posicion + 1 <= y <= 5 : 
                        (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                            jugadores[y].mano[x] = sospech.arma)) \/ 
        carta.prj = (% First : jugadorTurno.posicion + 1 <= y <= 5 : 
                        (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                            jugadores[y].mano[x] = sospech.prj)) \/
        carta.habt = (% First : jugadorTurno.posicion + 1 <= y <= 5 : 
                        (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                            jugadores[y].mano[x] = sospech.habt)) 
    }
        For i := ( jugadorTurno.posicion + 1 ) to ultimoj Do
        Begin
            If ( sospechaON ) and (jugadores[i].vida ) Then
            Begin
                For j := 0 to jugadores[i].conta.cartas  Do
                Begin
                    If ( jugadores[i].mano[j] = sospech.arma ) Then
                    Begin
                        carta[k].arma := sospech.arma;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                    If ( jugadores[i].mano[j] = sospech.prj ) Then 
                    Begin    
                        carta[k].prj := sospech.prj;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                    If ( jugadores[i].mano[j] = sospech.habt ) Then
                    Begin
                        carta[k].habt := sospech.habt;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                End;
            End;
        End;      
        { Inv carta.arma = (% First : 0 <= y <= jugadorTurno.posicon - 1 : 
                        (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                            jugadores[y].mano[x] = sospech.arma)) \/ 
        carta.prj = (% First : 0 <= y <= jugadorTurno.posicon - 1 : 
                        (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                            jugadores[y].mano[x] = sospech.prj)) \/
        carta.habt = (% First : 0 <= y <= jugadorTurno.posicon - 1 : 
                        (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                            jugadores[y].mano[x] = sospech.habt)) 


        }        
        For i := 0 to ( jugadorTurno.posicion - 1 ) Do
        Begin
            If ( sospechaON ) and ( jugadores[i].vida )Then
            Begin
                For j := 0 to jugadores[i].conta.cartas Do
                Begin
                    If ( jugadores[i].mano[j] = sospech.arma ) Then
                    Begin
                        carta[k].arma := sospech.arma;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                    If ( jugadores[i].mano[j] = sospech.prj ) Then 
                    Begin    
                        carta[k].prj := sospech.prj;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                    If ( jugadores[i].mano[j] = sospech.habt ) Then
                    Begin
                        carta[k].habt := sospech.habt;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End; 
                    If ( sospechaON = false ) and ( jugadores[i].usuario ) Then
                    Begin
                        humano := True
                    End;
                End;
            End;
        End;
    End
    Else
    Begin
        { Inv carta.arma = (% First : jugadorTurno.posicion + 1 <= y <= 5 : 
                        (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                            jugadores[y].mano[x] = sospech.arma)) \/ 
        carta.prj = (% First : jugadorTurno.posicion + 1 <= y <= 5 : 
                        (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                            jugadores[y].mano[x] = sospech.prj)) \/
        carta.habt = (% First : jugadorTurno.posicion + 1 <= y <= 5 : 
                        (% First x : 0 <= x <= jugadores[y].conta.cartas : 
                            jugadores[y].mano[x] = sospech.habt)) 
    }
        For i := ( jugadorTurno.posicion + 1 ) to ultimoj Do
        Begin
            If ( sospechaON ) and ( jugadores[i].vida ) Then
            Begin
                For j := 0 to jugadores[i].conta.cartas Do
                Begin
                    If ( jugadores[i].mano[j] = sospech.arma ) Then
                    Begin
                        carta[k].arma := sospech.arma;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                    If ( jugadores[i].mano[j] = sospech.prj ) Then 
                    Begin    
                        carta[k].prj := sospech.prj;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                    If ( jugadores[i].mano[j] = sospech.habt ) Then
                    Begin
                        carta[k].habt := sospech.habt;
                        sospechaON := false;
                        k := k + 1;
                        quien := i;
                    End;
                End;
            End;
        End;
    End;
End;



    (* Procedimiento que permite al usuario refutar una sospecha *)

Procedure Refuta_Usuario ( carta : Array of sbr; Var jugadorTurno : usuario;
                        sospech : sbr; k : integer; 
                        m : integer; n : integer; h : integer);
Var
    i : integer; // Variable para iterar.
    s,r : string; // Variable de mensajes.
    l : integer; // Variable de lectura robusta.
    {Pre:
    (% exists x : 0 <= x <= 2 : carta[x] )	
    }
    {Post:
    carta[x].arma = (% last x : 0 <= x <= 5 - jugadorTurno.conta.arma : 
        jugadorTurno.lista.arma[x] ) \/ 
    carta[x].prj = (% last x : 0 <= x <= 5 - jugadorTurno.conta.prj : 
        jugadorTurno.lista.prj[x] ) \/ 
    carta[x].habt = (% last x : 0 <= x <= 8 - jugadorTurno.conta.habt : 
        jugadorTurno.lista.habt[x] ) 
    }	
    
    
Begin
    Writeln('En tu mano hay ',k,
        ' carta(s) que se sospechan, cual quieres mostrar?');
    For i := 0 to (k-1) Do
    Begin
        If ( carta[i].arma = sospech.arma ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].arma);
        End;

        If ( carta[i].prj = sospech.prj ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].prj);
        End;

        If ( carta[i].habt = sospech.habt ) Then
        Begin
            Writeln(i + 1,'.- ',carta[i].habt);
        End;
    End;
    r := 'Elige el numero de la carta a mostrar';
    s := ' Te equivocaste, elige otra vez';
    LecturaRobusta(l,r,s,1,k); 

    If ( carta[l-1].arma = sospech.arma ) Then
    Begin
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m,0);
        jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
    End;
    If ( carta[l-1].prj = sospech.prj ) Then
    Begin 
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n,1);
        jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
    End;
    If ( carta[l-1].habt = sospech.habt ) Then
    Begin 
        Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
        jugadorTurno.conta.habt := jugadorTurno.conta.habt + 1;
    End;
End;

    (* Procedimiento que permite a la computadora refutar una sospecha *)

Procedure Refuta_computadora ( 
            carta        : Array of sbr; 
        Var jugadorTurno : usuario;
            k            : integer; 
            quien        : integer; 
            m            : integer;
            n            : integer; 
            h            : integer; 
            sospech      : sbr;
            jugadores    : Array of usuario
            );
Var
    muestro : integer; // Variable que determina que carta mostrar.
    {Pre:
    (% Exist x : 0 <= x <= 2 : carta[x] )	
    }
    
    {Post: 
    carta[x].arma = (% last x : 0 <= x <= 5 - jugadorTurno.conta.arma : 
        jugadorTurno.lista.arma[x] ) \/ 
    carta[x].prj = (% last x : 0 <= x <= 5 - jugadorTurno.conta.prj : 
        jugadorTurno.lista.prj[x] ) \/ 
    carta[x].habt = (% last x : 0 <= x <= 8 - jugadorTurno.conta.habt : 
        jugadorTurno.lista.habt[x] ) 
    }	                       

Begin
    muestro := Aleatorio(0,k-1);

    If jugadorTurno.usuario Then
    Begin
        writeln('(************************************************)');
        If ( sospech.arma = carta[muestro].arma ) Then
        Begin
            Writeln(Jugadores[quien].peon,' te muestra ',carta[muestro].arma);
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,0);
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;

        End;

        If ( sospech.prj = carta[muestro].prj ) Then
        Begin
            Writeln(Jugadores[quien].peon,' te muestra ',carta[muestro].prj);
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,1);
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
        End;

        If ( sospech.habt = carta[muestro].habt ) Then
        Begin
            Writeln(Jugadores[quien].peon,' te muestra ',carta[muestro].habt);
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
            jugadorTurno.conta.habt := jugadorTurno.conta.habt + 1;

        End;

        writeln('(************************************************)');
    End
    Else
    Begin
        Writeln('(************************************************)');
            Writeln('     ',Jugadores[quien].peon,' Muestra una carta a Jugador'
            ,jugadorTurno.posicion+1);

        writeln('(************************************************)');
        If ( carta[muestro].arma = sospech.arma ) 
        and ( m <= 5 - jugadorTurno.conta.arma) Then
        Begin
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,n,0);
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
            Writeln(carta[muestro].arma);
        End;
        If ( carta[muestro].prj = sospech.prj ) 
        and ( n <= 5 - jugadorTurno.conta.prj) Then
        Begin 
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,m,1);
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
            Writeln(carta[muestro].prj);
            Writeln(jugadorTurno.conta.prj);
        End;
        If ( carta[muestro].habt = sospech.habt ) 
        and ( h <= 8 - jugadorTurno.conta.habt ) Then
        Begin 
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
            jugadorTurno.conta.habt := jugadorTurno.conta.habt + 1;
            Writeln(carta[muestro].habt);
        End;
    End;
End;

    (* Descartar la sospecha si es refutada *)

Procedure Descarte_sospecha ( 
            Var sospechaLista : Array of sbr; 
            Var sospechaON    : boolean; 
            Var sospech       : sbr;
            Var sospechaConta : integer 
                            );
    {Pre:
    sospechaON = False 	
    }
    
    {Post:
    sospechaConta >= 0 /\ sospechaConta <= 323 /\ (% Forall x : 
                0 <= x <= sospechaConta 
    : sospechaLista[x].arma = sospech.arma /\ 
    sospechaLista[x].habt = sospech.habt /\ 
    sospechaLista[x].prj = sospech.prj)
    }	


Begin
    If not ( sospechaON ) Then
    Begin
        sospechaLista[sospechaConta].arma := sospech.arma;
        sospechaLista[sospechaConta].prj := sospech.prj;
        sospechaLista[sospechaConta].habt := sospech.habt;
        sospechaConta := sospechaConta + 1;    
    End;
End;



            (* Sospecha de la Computadora *)




Procedure sospecha_computadora ( 
                Var sospechaON    : boolean; 
                Var jugadorTurno  : usuario; 
                Var jugadores     : array of usuario; 
                    phaInicio     : cartas; 
                Var sospech       : sbr; 
                    ultimoJ       : integer;
                Var sospechaConta : integer;
                Var sospechaLista : Array of sbr
                            );


    {Pre:
    True
    }
    
    {Post:
    sospechaON = false \/ sospechaON = true 
    }	


Var
    h,n,m  : integer; // Variables que permiten programacion robusta
    k      : integer; // determina cuantas cartas son sospechadas por mano
    carta  : Array[0..2] of sbr; // Arreglo que guarda las cartas sospechadas
    i      : integer; // Contadores 
    humano : boolean; // determina si el usuario ha mostrado una carta
    quien  : integer; // determina quien hace match con las cartas
Begin


    sospechaON := True;
    humano := false;
    quien := 0;

    sospech.habt := jugadorTurno.donde;
    { Inv (% Exist x : 0 <= x <= 8 : sospech.habt = 
    jugadorTurno.listalhabt[x] ) }
    For i := 0 to 8 Do
    Begin
        If (sospech.habt = jugadorTurno.lista.habt[i] ) Then
        Begin
            h := i;
        End;
    End;
    (* Computadora elegira arma a sospechar *)
    n := Aleatorio(0,5-jugadorTurno.conta.arma);
    sospech.arma := jugadorTurno.lista.arma[n];
    Writeln(jugadorTurno.peon,
        ' sospecha que el arma usada en el asesinato fue: ',sospech.arma);
    (* Computadora elegira personaje a sospechar *)
    m := Aleatorio(0,5-jugadorTurno.conta.prj);
    sospech.prj := jugadorTurno.lista.prj[m];   
    Writeln(jugadorTurno.peon,
        ' sospecha quien mato a Mr.Black fue: ',sospech.prj);
    (* Mover el personaje al lugar de la sospecha *)
    
    MoverSospechoso(sospech,ultimoJ,jugadorTurno,jugadores);

    (* Match de las cartas *)

    k := 0;
    Chequeo_cartas(carta,jugadorTurno,jugadores,
                sospechaON,k,quien,humano,ultimoJ,sospech);

    (* Refutacion *)

        If ( humano ) and (sospechaON = false ) Then
        Begin
            Refuta_Usuario(carta,jugadorTurno,sospech,k,m,n,h);
        End
        Else
        Begin    
            If ( sospechaON = false ) and ( humano = false ) Then
            Begin
                Refuta_computadora(carta,jugadorTurno,k,quien,
                    m,n,h,sospech,jugadores);
            End;
        End;
    
    (* Descarte de la sospecha *)

    Descarte_sospecha(sospechaLista,sospechaON,sospech,sospechaConta);

End;


    
        (* Sospecha del Usuario *)




Procedure sospecha_Usuario( 
            Var sospechaON    : boolean; 
            Var jugadorTurno  : usuario ;                 
            Var jugadores     : array of usuario; 
                phaInicio     : cartas; 
            Var sospech       : sbr; 
                ultimoJ       : integer; 
            Var sospechaConta : integer;
            Var sospechaLista : Array of sbr
                        );



Var
    h,n,m  : integer; // Variables que permiten programacion robusta
    s,r    : string; // Variable que muestra mensaje al usuario
    k      : integer; // determina cuantas cartas son sospechadas por mano
    carta  : Array[0..2] of sbr; // Arreglo que guarda las cartas sospechadas
    i      : integer; // Contadores 
    humano : boolean; // determina si el usuario ha mostrado una carta
    quien  : integer; // Determina que jugador hizo match de las cartas
    {Pre:
    true
    }
    
    {Post: 
    sospechaON = false \/ sospechaON = true 
    }	
Begin

    sospechaON := True;
    humano := false;
    quien := 0;
    sospech.habt := jugadorTurno.donde;

        { Inv (% Exist x : 0 <= x <= 8 : sospech.habt = 
        jugadorTurno.listalhabt[x] ) }
        For i := 0 to 8 Do
        Begin
            If (sospech.habt = jugadorTurno.lista.habt[i] ) Then
            Begin
                h := i;
            End;
        End;

        (* Elegir arma a sospechar *)

        Writeln('Armas para sospechar');
        For i := 0 to 5 Do
        Begin
            Writeln(i+1,'.- ',jugadorTurno.lista.arma[i]);
        End;
        Writeln('Armas que ya tienes descartadas');
        For i := (5 - jugadorTurno.conta.arma) to 4 Do
        Begin
            Writeln;
            Writeln(jugadorTurno.lista.arma[i+1]);
        End;
    
        Writeln; 
        r := 'Arma a sospechar';
        s := 'Te equivocaste, Elige otra vez';

        (* Lectura Robusta del arma a sospechar *) 
        LecturaRobusta(m,r,s,1,6);

        sospech.arma := jugadorTurno.lista.arma[m-1];

        (* Elegir personaje a sospechar *)
      
        Writeln('Personajes para Sospechar');
    
        Writeln('Personajes no descartados');
        For i := 0 to 5 Do
        Begin
            Writeln(i+1,'.- ',jugadorTurno.lista.prj[i]);
        End;
        Writeln('Personajes que ya tienes descartados');
        For i := (5 - jugadorTurno.conta.prj) to 4 Do
        Begin
            Writeln;
            Writeln(jugadorTurno.lista.prj[i+1]);
        End;
        Writeln; 
        r := 'Personaje a sospechar: ';
        s := 'Te equivocaste, Elige otra vez';
        (* Lectura Robusta del personaje a sospechar *)
        LecturaRobusta(n,r,s,1,6);
        
        sospech.prj := jugadorTurno.lista.prj[n-1];

        (* Mover el personaje al lugar de la sospecha *)

        MoverSospechoso(sospech,ultimoJ,jugadorTurno,jugadores);

        (* Match de las cartas *)

        k := 0;
        Chequeo_cartas(carta,jugadorTurno,jugadores,sospechaON,
                    k,quien,humano,ultimoJ,sospech);

        (* Refutacion *)

        Refuta_computadora(carta,jugadorTurno,k,quien,m,n,h,sospech,jugadores);

        (* Descarte de sospecha *)

        Descarte_sospecha(sospechaLista,sospechaON,sospech,sospechaConta);
End;


            (* Acusacion *)



(* Procedimiento de acusacion para el usuario *)

Procedure Acusacion_Usuario( 
            Var acus         : sbr; 
            Var jugadorTurno : usuario; 
                sobre        : sbr; 
                phaInicio    : cartas;                 
            Var juegoActivo  : boolean;
            Var jugadores    : Array of usuario; 
                ultimoJ      : integer 
                        );
Var 
    i     : integer; // Variable de iteracion.
    n,m,h : integer; // Variable que permite lectura robusta
    s,r   : string; // Variables para mensajes
    {Pre:
    true	
    }
    
    {Post:
    jugadorTurno.vida = false \/ jugadorTurno.vida = true
    }	
Begin

    (* Acusacion del Personaje *)
    Writeln('Quien Mato a Mr.Black? ');
    Writeln;

    Writeln('Personajes descartados'); 
    Writeln;
    Writeln(jugadorTurno.lista.prj[5]);
    Writeln(jugadorTurno.conta.prj);
    Writeln;
    For i := ( 5 - jugadorTurno.conta.prj ) to 4 Do
    Begin
        Writeln(jugadorTurno.lista.prj[i+1]);
    End;
    Writeln;
    Writeln('Personajes Para Acusar ');
    Writeln;
    For i := 0  to 5 Do
    Begin
        Writeln(i+1,'.- ',phaInicio[i]);
    End;
    r := 'Elige una opcion';
    s := 'Te equivocaste, Eliga otra vez';
    Writeln;
    LecturaRobusta(n,r,s,1,6);

    acus.prj := phaInicio[n-1];
    MoverSospechoso(acus,ultimoJ,jugadorTurno,jugadores);
    (* Acusacion del arma *)

    Writeln;
    Writeln('Que arma se uso para asesinarlo? ');
    Writeln;
    Writeln('Armas descartadas ');
    Writeln;
    For i := ( 5 - jugadorTurno.conta.arma ) to 4 Do
    Begin
        Writeln(jugadorTurno.lista.arma[i+1]);
    End;
    Writeln;
    Writeln('Armas para acusar');
    For i := 15 to 20 Do
    Begin
        Writeln( i - 14,'.- ',phaInicio[i]);
    End;
    r := 'Elige una opcion';
    s := 'Te equivocaste, Eliga otra vez';
    Writeln;
    LecturaRobusta(m,r,s,1,6);

    acus.arma := phaInicio[m+14];

    (* Acusacion de la habitacion *)

    Writeln;
    Writeln('En que lugar crees que ocurrio el asesinato?' );
    Writeln;
    Writeln('Habitaciones descartadas ');
    Writeln;
    For i := ( 8 - jugadorTurno.conta.habt ) to 7 Do
    Begin
        Writeln(jugadorTurno.lista.habt[i+1]);
    End;
    Writeln;
    Writeln('Habitaciones donde acusar ');
    For i := 6 to 14 Do
    Begin
        Writeln(i - 5,'.- ',phaInicio[i]);
    End;
    r := 'Elige una opcion';
    s := 'Te equivocaste, Eliga otra vez';
    Writeln;
    LecturaRobusta(h,r,s,1,9);
    
    acus.habt := phaInicio[h+5];

    (* Verificacion de la acusacion *)
        
    Eliminar(jugadorTurno,jugadores,acus,sobre,ultimoJ);
    Fin(jugadores,sobre,acus,juegoActivo);


End;






(* Procedimiento de acusacion para la computadora *)



Procedure Acusacion_Computadora( 
            Var jugadorTurno  : usuario; 
                sobre         : sbr;
                phaInicio     : cartas; 
                sospech       : sbr;
            Var sospechaConta : integer;
                sospechaLista : Array of sbr; 
                jugadores     : Array of usuario;
                sospechaON    : boolean; 
                ultimoj       : integer;
            Var juegoActivo   : boolean; 
            Var acus          : sbr
                                );
    {Pre:
    true	
    }
    
    {Post: 
    jugadorTurno.vida = false \/ jugadorTurno.vida = true
    }	
Begin

    (* Formulacion de la Acusacion *)

    If sospechaON Then
    Begin
        acus.arma := sospech.arma;
        acus.prj := sospech.prj;
        acus.habt := sospech.habt;
    

        MoverSospechoso(acus,ultimoj,jugadorTurno,jugadores);
        Writeln; 
        Writeln(JugadorTurno.peon,' ha realizado una acusacion');
        Writeln;
        Writeln('Arma elegida: ',acus.arma);
        Writeln;
        Writeln('Personaje elegido: ',acus.prj);
        Writeln;
        Writeln('Haitacion elegida: ',acus.habt);

    (* Verificacion de la acusacion *)
        Eliminar(jugadorTurno,jugadores,acus,sobre,ultimoJ);
        Fin(jugadores,acus,sobre,juegoActivo);


    End;

    


End;



                (*  Turno *) 


Procedure Turnos(
                phaInicio     : cartas; 
            Var habitacion    : Array of lugar;
                sobre         : sbr; 
            Var partida       : text; 
            Var jugadorTurno  : usuario;
            Var jugadores     : Array of usuario; 
            Var sospech       : sbr;
            Var acus          : sbr; 
                ultimoJ       : integer; 
            Var sospechaConta : integer; 
            Var sospechaLista : Array of sbr; 
            Var SioNo         : boolean;
            Var juegoActivo   : boolean; 
            Var sospechaON    : boolean; 
            Var turno         : longint
                    );

Var
	n : integer; // Valor del dado
	{Pre:
	    ultimoJ > 2 /\ ultimoJ < 6 /\ juegoActivo = True /\ Turno >= 0 /\
	sospechaConta >= 0 /\ sospechaLista = ( %forall z : 0 <= z < 324 : 
        sospecha[z].arma /\ sospecha[z].habt /\ sospecha[z].prj )  /\ 
    phaInicio = ( %forall z : 0 <= z <= 20 : phaInicio[z])  
	}
	
	{Post:
	jugadorTurno.vida = ( acus.prj = sobre.prj /\ acus.habt = sobre.habt /\ 
        acus.arma = sobre.arma )
	}	
Begin

	
	
	
	
	
	If ( JugadorTurno.vida ) Then
	Begin
        writeln;
        writeln('(************************************************)');
        writeln('             Turno del jugador ', jugadorTurno.posicion + 1,'          ');
        writeln('               ', jugadorTurno.peon, '               ');
        writeln('(************************************************)');
        writeln;
	    (* Se calcula el dado *)
	    n := Aleatorio(1,6);
	    Writeln(JugadorTurno.peon,' Saco ',n,' en el dado');
        Writeln(jugadorTurno.peon, ' se encuentra en ',jugadorTurno.donde);
	    (* Mover al jugador *)

	    Mover(jugadorTurno,n,habitacion);

	    (* Jugador del Turno hace la sospecha *)

	    If ( jugadorTurno.usuario ) Then
	    Begin
		    Writeln;
		    Writeln('Deseas realizar una sospecha?');
		    Writeln;
		    Decision(SioNO);

		    If SioNo Then
		    Begin
		        sospecha_Usuario(sospechaON,jugadorTurno,jugadores,phaInicio,
				        sospech,ultimoJ,sospechaConta,sospechaLista);
		    End;
	    End
	    Else
	    Begin
		    Writeln;
		    Writeln(jugadorTurno.peon);
		    Writeln('va a realizar una sospecha');
		    Writeln;
	    
		    sospecha_computadora(sospechaON,jugadorTurno,jugadores,phaInicio,
				        sospech,ultimoJ,sospechaConta,sospechaLista);
	    End;

	    (* Jugador del Turno hace la Acusacion *)
	    
	    If ( jugadorTurno.usuario ) and ( sospechaON ) Then
	    Begin
		    Writeln;
		    Writeln('Deseas realizar una acusacion?');
		    Writeln;
		    Decision(SioNo);

		    If SioNo Then
		    Begin
		        Acusacion_Usuario(acus,jugadorTurno,sobre,phaInicio,
				    juegoActivo,jugadores,ultimoJ);
		    End;
        End
        Else
        Begin

        (* Computadora acusa *) 

            If (jugadorTurno.conta.arma = 5 ) and (jugadorTurno.conta.habt = 8 ) 
                and (jugadorTurno.conta.prj = 5) and ( sospechaON) Then 
            Begin
                
                Acusacion_Computadora(jugadorTurno,sobre,phaInicio,sospech,
                        sospechaConta,sospechaLista,jugadores,
                        sospechaON,ultimoJ,juegoActivo,acus);

            End;
        End;
        
        If not  juegoActivo  Then
        Begin
            despedida;
            Writeln(sobre.prj,sobre.arma,sobre.habt);
        End;   

        turno := turno + 1;
        Writeln;
        Writeln('Turno ',turno);
        Writeln;
        Readln; 
    End;
End;
    

(* 
* Empieza el Programa Principal 
*)
VAR
    (* 
    * Personajes: 0 al 5
    * Habitaciones: del 6 al 14
    * Armas: 15 20 
    *)
    phaInicio : cartas = (SenioraBlanco, SeniorVerde, SenioraCeleste,
            ProfesorCiruela, SenioritaEscarlata, 
            CoronelMostaza, Biblioteca, Cocina, 
            Comedor, Estudio, Vestibulo, Salon, 
            Invernadero, SalaDeBaile, SalaDeBillar,
            Candelabro, Cuchillo, Cuerda, 
            LlaveInglesa, Revolver, Tubo);

    habitacion    : Array[0..8] of lugar;
    sobre         : sbr; // Variable que contiene los hechos reales
    partida       : Text;
    
    jugadores     : Array[0..5] of usuario; // Arreglo de jugadores.
    
    Turno         : Longint; // Contador de los Turnos.
    
    sospech       : sbr; // Variable para realizar sospechas
    acus          : sbr; // Variable para realizar acusaciones
    ultimoJ       : integer;
    sospechaLista : Array[0..323] of sbr;
    sospechaConta : integer;
    turnoActual   : integer;

    partidaCargada: boolean;
    SioNo         : boolean;
    juegoActivo   : boolean;
    sospechaON    : boolean;
    i             : integer; // Contador    
BEGIN
    Writeln;
    Randomize();
    (* Procedimiento con Instrucciones *)
    Introduccion(SioNo);
    
    (* Inicializacion de Variables *)
    Inicializa(phaInicio, sobre, turnoActual, partidaCargada, ultimoJ,habitacion,jugadores,
                Turno,SioNo,juegoActivo,sospechaConta);
    
    If Not partidaCargada Then
    Begin
    (* Asigancion de personajes *)
    SeleccionPersonaje(phaInicio, jugadores,ultimoJ);
    Writeln;
    
    (* Se Asignan las cartas al sobre y se reparten las demas *)
    AsignarCartas(phaInicio, jugadores, sobre,  ultimoJ);
    End;
    (*
    * Comienzan los turnos de cada personaje 
    *)
    While juegoActivo Do
    Begin
        i := 0;
        i := turnoActual;
        { Inv x <= ultimoJ /\ x >= 0 Cota 6 - x }
        While i < ultimoJ + 1 Do
        Begin
            Turnos(phaInicio,habitacion,sobre,partida,jugadores[i],jugadores,
                sospech,acus,ultimoJ,sospechaConta,sospechaLista,SioNo,
                juegoActivo,sospechaON,turno);
            Guardar(jugadores, ultimoJ, sobre, partida);
        i := i + 1;
        End;
        turnoActual := 0;
    End;
    Writeln;
    

END.
