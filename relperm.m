%Make the relperm a function of the chemistry?

if P.UseRelpermAsFunctionOfChem == true         
      for m = 1:P.nsw
        if F.Salinity(m,n) < F.sal_threshold
            F.nw(m,n)            = F.LS_nw ;                %Corey-coefficient, water [-]
            F.no(m,n)            = F.LS_no;                %Corey-coefficient, oil [-]
            F.sor(m,n)           = F.LS_sor;             %Residual oil saturation [-]
            F.kroe(m,n)          = F.LS_kroe;              %Oil endpoint relative permeability [-]
            F.krwe(m,n)          = F.LS_krwe;              %Water end-point relative permeability [-]      
        end
      end         
end