Procedure sospecha( var sospechaON : boolean; var player : user ; 
                    var pc : array of user; phaInit : cartas );
Var
    sospech : sbr;
    n : integer;
    s : string;
Begin

If ( player.usuario ) Then
Begin
    sospech.habt := player.donde;

    (* Elegir arma a sospechar *)

    Writeln('Armas no descartadas');
    For i := 0 to ( 5 - pc.conta.arma ) Do
    Begin
        Writeln(i,'.- ',pc[0].lista.arma[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - pc.conta.arma) to 5 Do
    Begin
        Writeln(pc[0].lista.arma[i]);
    End;
   
    s := 'Arma a sospechar: ';
   
    Repeat
    Begin
        Writeln(s);
        Readln(n);
        s := 'Arma incorrecta, Elegir otra vez';
    End
    Until (n < 7 ) and ( n > 0 );

    sospechar.arma := phaInit[n];

    (* Elegir personaje a sospechar *)
  
    Writeln('Personajes no descartados');
    For i := 0 to ( 5 - pc.conta.prj ) Do
    Begin
        Writeln(i+1,'.- ',pc[0].lista.prj[i]);
    End;
    Writeln('Armas descartadas');
    For i := (5 - pc.conta.prj) to 5 Do
    Begin
        Writeln(pc[0].lista.prj[i]);
    End;
    
    s := 'Personaje a sospechar: ';
    Repeat 
    Begin
        Writeln(s);
        Readln(n);
        s := 'Personaje incorrecto, Elegir otra vez'
    End
    Until ( n < 7 ) and ( n > 0);
    
    (* Mover el personaje al lugar de la sospecha *)

    For i := 1 to 5 Do
    Begin
        If ( sospech.prj = pc[i].peon ) Then
        Begin
            pc[i].donde := sospech.habt;
        End;
    End;

    (* Match de las cartas *)
    
    For i := ( player.posicion + 1 ) to 5 Do
    Begin
        For j := 0 to 2 Do
        Begin
                         
        




