Procedure Descarte_sospecha ( var sospecha_lista : Array of sbr; 
                              var sospechaON : boolean; 
                              var sospech : sbr;
                              var sospecha.conta : integer );

Begin
    If not ( sospechaON ) Then
    Begin
        sospecha_lista[sospecha.conta].arma := sospech.arma;
        sospecha_lista[sospecha.conta].prj := sospech.prj;
        sospecha_lista[sospecha.conta].habt := sospech.habt;
        sospecha.conta := sospecha.conta + 1;    
    End;
End;
