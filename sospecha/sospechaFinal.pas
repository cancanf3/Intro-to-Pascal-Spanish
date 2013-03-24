PROGRAM SOSPECHA;



Procedure Match_cartas ( Var carta : Array of sbr ; jugadorTurno : user ;
                         jugadores : Array of user ; var sospechaON : boolean ;
                         var k : integer ; var quien : integer;
                         var humano : boolean; ultimoj : integer;
                         sospech : sbr );
Var
    i,j : integer; // Contadores
  
Begin

If  not ( jugadorTurno.usuario ) Then
Begin

    For i := ( jugadorTurno.posicion + 1 ) to ultimoj Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].conta.cartas  Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j].arma := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.prj ) Then 
                Begin    
                    carta[j].prj := sospech.prj;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.habt ) Then
                Begin
                    carta[j].habt := sospech.habt;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
            End;
        End;
    End;      
            
    For i := 0 to ( jugadorTurno.posicion - 1 ) Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].conta.cartas Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j].arma := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.prj ) Then 
                Begin    
                    carta[j].prj := sospech.prj;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.habt ) Then
                Begin
                    carta[j].habt := sospech.habt;
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
    For i := ( jugadorTurno.posicion + 1 ) to ultimoj Do
    Begin
        If ( sospechaON ) Then
        Begin
            For j := 0 to jugadores[i].conta.cartas Do
            Begin
                If ( jugadores[i].mano[j] = sospech.arma ) Then
                Begin
                    carta[j].arma := sospech.arma;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.prj ) Then 
                Begin    
                    carta[j].prj := sospech.prj;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
                If ( jugadores[i].mano[j] = sospech.habt ) Then
                Begin
                    carta[j].habt := sospech.habt;
                    sospechaON := false;
                    k := k + 1;
                    quien := i;
                End;
            End;
        End;
    End;
End;
End;


Procedure Swap_descarte(var jugador : user; n : integer; 
                            m : integer; k : integer);
Var
tmp1 : a;
tmp2 : h;
tmp3 : p;
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

Procedure Refuta_Usuario ( carta : Array of sbr; Var jugadorTurno : user;
                           sospech : sbr; k : integer; 
                           m : integer; n : integer; h : integer);
Var
    i : integer; // Variable para iterar.
    s : string; // Variable de mensajes.
    l : integer; // Variable de lectura robusta.
Begin
    Writeln('En tu mano hay ',k,
        ' cartas que se sospechan, cual quieres mostrar?');
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
    s := 'elige el numero de la carta a mostrar';
    Repeat
    Begin
        Writeln(s);
        Read(l);
        S := ' te equivocaste, elige otra vez';
    End
    Until ( n > 0 ) and ( n < (k + 1) );

    If ( carta[l-1].arma = sospech.arma ) Then
    Begin
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,0);
        jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
    End;
    If ( carta[l-1].prj = sospech.prj ) Then
    Begin 
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,1);
        jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
    End;
    If ( carta[l-1].habt = sospech.habt ) Then
    Begin 
        Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
        jugadorTurno.conta.habt := jugadorTurno.conta.habt + 1;
    End;
End;

Procedure Refuta_computadora ( carta : Array of sbr; var jugadorTurno : user;
                                k : integer; quien : integer; m : integer;
                                n : integer; h : integer; sospech : sbr);
Var
    muestro : integer; // Variable que determina que carta mostrar.
                               

Begin

    muestro := Aleatorio(0,k-1);
    If jugadorTurno.usuario Then
    Begin
        If ( sospech.arma = carta[muestro].arma ) Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[muestro].arma);
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,0);
            jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;

        End;

        If ( sospech.habt = carta[muestro].habt ) Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[muestro].habt);
            Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,1);
            jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
 
        End;

        If ( sospech.prj = carta[muestro].prj ) Then
        Begin
            Writeln('Jugador',quien,' te muestra ',carta[muestro].prj);
            Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
            jugadorTurno.conta.habt := jugadorTurno.conta.habt + 1;
 
        End;
    End
    Else
    Begin
        Writeln('Jugador',quien,' Muestra una carta a Jugador'
            ,jugadorTurno.posicion,' La carta es: ');
    End;
    If ( carta[muestro].arma = sospech.arma ) 
    and ( m-1 <= 5 - jugadorTurno.conta.arma) Then
    Begin
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.arma,m-1,0);
        jugadorTurno.conta.arma := jugadorTurno.conta.arma + 1;
    End;
    If ( carta[muestro].prj = sospech.prj ) 
    and ( n-1 <= 5 - jugadorTurno.conta.prj) Then
    Begin 
        Swap_descarte(jugadorTurno,5-jugadorTurno.conta.prj,n-1,1);
        jugadorTurno.conta.prj := jugadorTurno.conta.prj + 1;
    End;
    If ( carta[muestro].habt = sospech.habt ) 
    and ( h <= 8 - jugadorTurno.conta.habt ) Then
    Begin 
        Swap_descarte(jugadorTurno,8-jugadorTurno.conta.habt,h,2);
        jugadorTurno.conta.habt := jugadorTurno.conta.habt + 1;
    End;
End;

Procedure Descarte_sospecha ( var sospecha_lista : Array of sbr; 
                              var sospechaON : boolean; 
                              var sospech : sbr;
                              var sospecha_conta : integer );

Begin
    If not ( sospechaON ) Then
    Begin
        sospecha_lista[sospecha_conta].arma := sospech.arma;
        sospecha_lista[sospecha_conta].prj := sospech.prj;
        sospecha_lista[sospecha_conta].habt := sospech.habt;
        sospecha_conta := sospecha_conta + 1;    
    End;
End;

Procedure sospecha_computadora ( var sospechaON : boolean; 
                                 var jugadorTurno : usuario; 
                                 var jugadores : array of usuario; 
                                 phaInicio : cartas; 
                                 var sospech : sbr; ultimoJ : integer;
                                 var sospecha.conta : integer;
                                 var sospecha_lista : Array of sbr);



Var
    h,n,m,l : integer; // variables que permiten programacion robusta
    s : string; // Variable que muestra mensaje al usuario
    k : integer; // determina cuantas cartas son sospechadas por mano
    carta : Array[0..2] of pha; // Arreglo que guarda las cartas sospechadas
    i,j,co : integer; // Contadores 
    humano : boolean; // determina si el usuario ha mostrado una carta
    quien : integer; // determina quien hace match con las cartas
    Begin
    
    
    sospechaON := True;
    humano := false;
    quien := 0;

    sospech.habt := jugadorTurno.donde;
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
    Writeln('La computadora',jugadorTurno.posicion,
        ' sospecha que el arma usada en el asesinato fue: ',sospech.arma);
    (* Computadora elegira personaje a sospechar *)
    m := Aleatorio(0,5-jugadorTurno.conta.prj);
    sospech.prj := jugadorTurno.lista.arma[m];   
    Writeln('La computadora',jugadorTurno.posicion,
        'sospecha quien mato a Mr.Black fue: ',sospech.prj);
    (* Mover el personaje al lugar de la sospecha *)
    
    MoverSospechoso(sospech,ultimoJ,jugadorTurno,jugadores);

    (* Match de las cartas *)

    k := 0;
    Match_cartas(carta,jugadorTurno,jugadores,sospechaON,k,quien,humano);

    (* Refutacion *)

        If ( humano ) and (sospechaON = false ) Then
        Begin
            Refuta_Usuario(carta,jugadorTurno,k,m,n,h);
        End
        Else
        Begin    
            If ( sospechaON = false ) and ( humano = false ) Then
            Begin
                Refuta_computadora(carta,jugadorTurno,k,quien,m,n,h);
            End;
        End;
    End;
    
    (* Descarte de la sospecha *)

    Descarte_sospecha(sospecha_lista,sospechaON,sospech,sospecha.conta);

End;


Procedure sospecha_Usuario( var sospechaON : boolean; var jugadorTurno : usuario ; 
                            var jugadores : array of usuario; 
                            phaInicio : cartas; var sospech : sbr; 
                            ultimoJ : integer; var sospecha.conta : integer;
                            var sospecha_lista : Array of sbr;
                            );



Var
    h,n,m,l : integer; // variables que permiten programacion robusta
    s : string; // Variable que muestra mensaje al usuario
    k : integer; // determina cuantas cartas son sospechadas por mano
    carta : Array[0..2] of pha; // Arreglo que guarda las cartas sospechadas
    i,j,co : integer; // Contadores 
    humano : boolean; // determina si el usuario ha mostrado una carta
    quien  : integer; // Determina que jugador hizo match de las cartas
Begin

sospechaON := True;
humano := false;
quien := 0;
    sospech.habt := jugadorTurno.donde;

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
        Writeln(i+1,'.- ',jugadores[0].lista.arma[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - jugadorTurno.conta.arma) to 5 Do
    Begin
        Writeln(jugadores[0].lista.arma[i]);
    End;
   
    s := 'Arma a sospechar';

    (* Lectura Robusta del arma a sospechar *) 
    
    Repeat
    Begin
        Writeln(s);
        Readln(m);
        s := 'Arma incorrecta, Elegir otra vez';
    End
    Until (m < 7 ) and ( m > 0 );

    sospech.arma := phaInicio[ m + 14 ];

    (* Elegir personaje a sospechar *)
  
    Writeln('Personajes no descartados');
    For i := 0 to 5 Do
    Begin
        Writeln(i+1,'.- ',jugadorTurno.lista.prj[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - jugadorTurno.conta.prj) to 5 Do
    Begin
        Writeln(jugadorTurno.lista.prj[i]);
    End;
    
    s := 'Personaje a sospechar: ';

    (* Lectura Robusta del personaje a sospechar *)

    Repeat 
    Begin
        Writeln(s);
        Readln(n);
        s := 'Personaje incorrecto, Elegir otra vez'
    End
    Until ( n < 7 ) and ( n > 0);
    
    sospech.prj := phaInicio [ n - 1];

    (* Mover el personaje al lugar de la sospecha *)

    MoverSospechoso(sospech,ultimoJ,jugadorTurno,jugadores);

    (* Match de las cartas *)

    k := 0;
    Match_cartas(carta,jugadorTurno,jugadores,sospechaON,k,quien,humano);

    (* Refutacion *)

    Refuta_computadora(carta,jugadorTurno,k,quien,m,n,h);

    (* Descarte de sospecha *)

    Descarte_sospecha(sospecha_lista,sospechaON,sospech,sospecha.conta);
End;

