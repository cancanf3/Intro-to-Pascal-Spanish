Program hola;
    

    Procedure decision (var SioNo : boolean);
    Var
	YN : char;
    n : integer;
    Begin
        Repeat
        Begin
            readln(YN);
            SioNo := true;
            n := 0;
        	Case YN of
        	    's','y' :
        		Begin
        		    SioNo := true;
                    n := 1;
        		End;
        	    'n'    :
        		Begin
        		    SioNo := false;
                    n := 1;
        		End;
            End;
        End
        Until ( n = 1 );
    End;
Var
    SioNo : boolean;
Begin
    SioNo := true;
    writeln;
    write('Desea hacer alguna cosa que necesite el proyecto? (s/n): ');
    decision(SioNo);
    If SioNo then
    Begin
	writeln('Me permitio Entrar');
    End
    Else
    Begin
	writeln('No me permitio Entrar');
    End;
End.
