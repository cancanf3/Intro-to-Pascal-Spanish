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
