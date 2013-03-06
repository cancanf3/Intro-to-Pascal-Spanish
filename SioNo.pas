Program SioNo;
    

    Procedure SioNo : boolean;
    Var
	YN : string;
    n : integer;
    Begin
        Repeat
        Begin
        	read(YN);
            SioNo := true;
            n := 0;
        	Case YN of
        	    's','y','si','yes' :
        		Begin
        		    SioNo := true;
                    n := 1;
        		End;
        	    'n','no' :
        		Begin
        		    SioNo := false;
                    n := 1;
        		End;
    	    End;
        End
        Until ( n = 1 );
    End;

Begin
    writeln;
    write('Desea hacer alguna cosa que necesite el proyecto? (s/n): ');
    If SioNo then
    Begin
	writeln('Me permitio Entrar');
    End
    Else
    Begin
	writeln('No me permitio Entrar');
    End;
End.
