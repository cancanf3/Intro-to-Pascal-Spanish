Procedure sospecha( var sospechaON : boolean; var player : user ; 
                    var pc : array of user);
Type

Var
    sospech : string;

Begin

If ( player.usuario ) Then
Begin
    sospech.habt := player.donde;
    Writeln('Armas no descartadas');
    For i := 15 to ( 20 - pc.co.arma ) Do
    Begin
        Writeln(pc[0].lista.arma[i]);
    End;
    Writeln('Armas descartadas');
    For i := (20 - pc.co.arma) to 20 Do
    Begin
        Writeln(pc[0].lista.arma[i]);
    End;
    Writeln('Arma a sospechar: ');
    Repeat
    Begin
        Readln(sospech.arma);
    End
    Until (sospech.arma = 'Candelabro') or (sospech.arma = 'Cuchillo')
          or (sospech.arma = 'Cuerda') or (sospech.arma = 'LlaveInglesa')
          or (sospech.arma = 'Revolver') or (sospech.arma = 'Tubo');
   

    Writeln('Persona a sospechar: ');
    For i := 15 to ( 20 - pc.co.prj ) Do
    Begin
        Writeln(pc[0].lista.arma[i]);
    End;

    For i := 15 to 20 Do
    Readln(sospech.prj);

    For i := 1 to 5 Do
    Begin
        If ( sospech.prj = pc[i].peon ) Then
        Begin
            pc[i].donde := sospech.habt;
        End
        Else 
            For j := 0 to 5 Do
            Begin 
                If ( sospech.prj = pc[i].lista.lista_cartas.prj[j] ) Then
                Begin
                    personaje := pc[i].lista_cartas.prj[j];
                    sospechaON := false;
                End;
            End;
            If         
