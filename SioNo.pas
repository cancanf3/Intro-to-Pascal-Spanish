Program SioNo;
    

    Function Permite (): boolean;
    Var
	YN : char;
    Begin
	read(YN);
	Permite := true;
	Case YN of
	    's','y' :
		Begin
		    permite := true;
		End;
	    'n' :
		Begin
		    permite := false;
		End;
	    Else
	    Begin
		permite := True;
	    End;
	End;
    End;

Begin
    writeln;
    write('Desea hacer alguna cosa que necesite el proyecto? (s/n): ');
    If Permite then
    Begin
	writeln('Me permitio Entrar');
    End
    Else
    Begin
	writeln('No me permitio Entrar');
    End;
End.