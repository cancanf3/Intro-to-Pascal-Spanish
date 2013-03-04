program ValorAbsoluto;

    Function VA(n : integer): integer;
    Begin
	If n < 0 Then
	Begin
	    VA := n * -1;
	End
	Else
	Begin
	    VA := n;
	End;
    End;
    
Var
    n : integer;

Begin
    Write('Introduzca un numero: ');
    Read(n);
    Writeln('|', n, '| = ', VA(n)); 
End.
    


	    