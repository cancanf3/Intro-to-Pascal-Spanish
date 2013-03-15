PROGRAM NumeroDeComputadoras;

    Procedure NComputadoras(var ultimoJ : integer);
    Begin
	write('Ingrese el numero de jugadoras contra las que desea jugar (2-5): ');
	read(ultimoJ);
	While (ultimoJ < 2) Or (ultimoJ > 5) Do
	Begin
	    writeln('Numero ingresado no valido, Puede elejir entre 2 y 5 computadoras');
	    write('Intente de nuevo: ');
	    read(ultimoJ);
	End;
    
    End;






VAR
    ultimoJ : integer;


BEGIN
    Ncomputadoras(ultimoJ);
    writeln(ultimoJ);
END.