Program Swap;

    Procedure Swap(var n : integer; var m : integer);
    Var
	tmp : integer;
    Begin
	tmp := n;
	n := m;
	m := tmp;
    End;



Var 
    x : integer;
    z : integer;

Begin
    writeln;
    
    x := 10;
    z := 1000;
    writeln;
    writeln(x,' ', z);
    Swap(x, z);
    writeln(x,' ', z);
    
    writeln;
End.