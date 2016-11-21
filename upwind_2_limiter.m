%Spatial 2nd order upwind numerical scheme using flux limiter

%Note: for each ion the same lines of code are used. This is somewhat ugly
%as a full loop around one set can do the same. This, in a struct, is
%however very slow (10 times). Therefore it is now done by hand. Any P.better
%solution for a more compact code?

%Generate r-values for all ions, for the full column length at a single time step.
for m=1:P.nsw
    if m == 1 || m ==P.nsw 
        P.r.Na(m,n)    = 0;
        P.r.K(m,n)     = 0;
        P.r.Ca(m,n)    = 0;
        P.r.Mg(m,n)    = 0;
        P.r.Ba(m,n)    = 0;
        P.r.Sr(m,n)    = 0;
        P.r.Cl(m,n)    = 0;
        P.r.S(m,n)     = 0;
        P.r.B(m,n)     = 0;
        P.r.Al(m,n)    = 0;    
        P.r.Si(m,n)    = 0;
        P.r.Li(m,n)    = 0;
        P.r.H(m,n)     = 0;
        P.r.C4(m,n)    = 0;
        P.r.HCO3(m,n)  = 0;
    else        
        P.r.Na(m,n) = (C.Na(m+1,n) - C.Na(m,n))/(C.Na(m,n) - C.Na(m-1,n));    
        P.r.K(m,n) = (C.K(m+1,n) - C.K(m,n))/(C.K(m,n) - C.K(m-1,n));    
        P.r.Ca(m,n) = (C.Ca(m+1,n) - C.Ca(m,n))/(C.Ca(m,n) - C.Ca(m-1,n));    
        P.r.Mg(m,n) = (C.Mg(m+1,n) - C.Mg(m,n))/(C.Mg(m,n) - C.Mg(m-1,n));    
        P.r.Ba(m,n) = (C.Ba(m+1,n) - C.Ba(m,n))/(C.Ba(m,n) - C.Ba(m-1,n));    
        P.r.Sr(m,n) = (C.Sr(m+1,n) - C.Sr(m,n))/(C.Sr(m,n) - C.Sr(m-1,n));    
        P.r.Cl(m,n) = (C.Cl(m+1,n) - C.Cl(m,n))/(C.Cl(m,n) - C.Cl(m-1,n));    
        P.r.S(m,n) = (C.S(m+1,n) - C.S(m,n))/(C.S(m,n) - C.S(m-1,n));    
        P.r.B(m,n) = (C.B(m+1,n) - C.B(m,n))/(C.B(m,n) - C.B(m-1,n));    
        P.r.Al(m,n) = (C.Al(m+1,n) - C.Al(m,n))/(C.Al(m,n) - C.Al(m-1,n));    
        P.r.Si(m,n) = (C.Si(m+1,n) - C.Si(m,n))/(C.Si(m,n) - C.Si(m-1,n));    
        P.r.Li(m,n) = (C.Li(m+1,n) - C.Li(m,n))/(C.Li(m,n) - C.Li(m-1,n));    
        P.r.H(m,n) = (C.H(m+1,n) - C.H(m,n))/(C.H(m,n) - C.H(m-1,n));    
        P.r.C4(m,n) = (C.C4(m+1,n) - C.C4(m,n))/(C.C4(m,n) - C.C4(m-1,n));    
        P.r.HCO3(m,n) = (C.HCO3(m+1,n) - C.HCO3(m,n))/(C.HCO3(m,n) - C.HCO3(m-1,n));       

        if isnan(P.r.Na(m,n)) && C.Na(m+1,n) - C.Na(m,n) == 0; P.r.Na(m,n) = 0; elseif isnan(P.r.Na(m,n)); P.r.Na(m,n) = inf; end;
        if isnan(P.r.K(m,n)) && C.K(m+1,n) - C.K(m,n) == 0; P.r.K(m,n) = 0; elseif isnan(P.r.K(m,n)); P.r.K(m,n) = inf; end;
        if isnan(P.r.Ca(m,n)) && C.Ca(m+1,n) - C.Ca(m,n) == 0; P.r.Ca(m,n) = 0; elseif isnan(P.r.Ca(m,n)); P.r.Ca(m,n) = inf; end;
        if isnan(P.r.Mg(m,n)) && C.Mg(m+1,n) - C.Mg(m,n) == 0; P.r.Mg(m,n) = 0; elseif isnan(P.r.Mg(m,n)); P.r.Mg(m,n) = inf; end;
        if isnan(P.r.Ba(m,n)) && C.Ba(m+1,n) - C.Ba(m,n) == 0; P.r.Ba(m,n) = 0; elseif isnan(P.r.Ba(m,n)); P.r.Ba(m,n) = inf; end;
        if isnan(P.r.Sr(m,n)) && C.Sr(m+1,n) - C.Sr(m,n) == 0; P.r.Sr(m,n) = 0; elseif isnan(P.r.Sr(m,n)); P.r.Sr(m,n) = inf; end;
        if isnan(P.r.Cl(m,n)) && C.Cl(m+1,n) - C.Cl(m,n) == 0; P.r.Cl(m,n) = 0; elseif isnan(P.r.Cl(m,n)); P.r.Cl(m,n) = inf; end;
        if isnan(P.r.S(m,n)) && C.S(m+1,n) - C.S(m,n) == 0; P.r.S(m,n) = 0; elseif isnan(P.r.S(m,n)); P.r.S(m,n) = inf; end;
        if isnan(P.r.B(m,n)) && C.B(m+1,n) - C.B(m,n) == 0; P.r.B(m,n) = 0; elseif isnan(P.r.B(m,n)); P.r.B(m,n) = inf; end;
        if isnan(P.r.Al(m,n)) && C.Al(m+1,n) - C.Al(m,n) == 0; P.r.Al(m,n) = 0; elseif isnan(P.r.Al(m,n)); P.r.Al(m,n) = inf; end;
        if isnan(P.r.Si(m,n)) && C.Si(m+1,n) - C.Si(m,n) == 0; P.r.Si(m,n) = 0; elseif isnan(P.r.Si(m,n)); P.r.Si(m,n) = inf; end;
        if isnan(P.r.Li(m,n)) && C.Li(m+1,n) - C.Li(m,n) == 0; P.r.Li(m,n) = 0; elseif isnan(P.r.Li(m,n)); P.r.Li(m,n) = inf; end;
        if isnan(P.r.H(m,n)) && C.H(m+1,n) - C.H(m,n) == 0; P.r.H(m,n) = 0; elseif isnan(P.r.H(m,n)); P.r.H(m,n) = inf; end;
        if isnan(P.r.C4(m,n)) && C.C4(m+1,n) - C.C4(m,n) == 0; P.r.C4(m,n) = 0; elseif isnan(P.r.C4(m,n)); P.r.C4(m,n) = inf; end;
        if isnan(P.r.HCO3(m,n)) && C.HCO3(m+1,n) - C.HCO3(m,n) == 0; P.r.HCO3(m,n) = 0; elseif isnan(P.r.HCO3(m,n)); P.r.HCO3(m,n) = inf; end;
    end
end

for i=1:P.nsw

    switch P.Limiter 
        case 'sweby'                                              
            P.psi.Na(i,n) = max([0 min([P.bet*P.r.Na(i,n) 1]) min([P.r.Na(i,n) P.bet])]);        %sweby
            P.psi.K(i,n) = max([0 min([P.bet*P.r.K(i,n) 1]) min([P.r.K(i,n) P.bet])]);        %sweby
            P.psi.Ca(i,n) = max([0 min([P.bet*P.r.Ca(i,n) 1]) min([P.r.Ca(i,n) P.bet])]);        %sweby
            P.psi.Mg(i,n) = max([0 min([P.bet*P.r.Mg(i,n) 1]) min([P.r.Mg(i,n) P.bet])]);        %sweby
            P.psi.Ba(i,n) = max([0 min([P.bet*P.r.Ba(i,n) 1]) min([P.r.Ba(i,n) P.bet])]);        %sweby
            P.psi.Sr(i,n) = max([0 min([P.bet*P.r.Sr(i,n) 1]) min([P.r.Sr(i,n) P.bet])]);        %sweby
            P.psi.Cl(i,n) = max([0 min([P.bet*P.r.Cl(i,n) 1]) min([P.r.Cl(i,n) P.bet])]);        %sweby
            P.psi.S(i,n) = max([0 min([P.bet*P.r.S(i,n) 1]) min([P.r.S(i,n) P.bet])]);        %sweby
            P.psi.B(i,n) = max([0 min([P.bet*P.r.B(i,n) 1]) min([P.r.B(i,n) P.bet])]);        %sweby
            P.psi.Al(i,n) = max([0 min([P.bet*P.r.Al(i,n) 1]) min([P.r.Al(i,n) P.bet])]);        %sweby
            P.psi.Si(i,n) = max([0 min([P.bet*P.r.Si(i,n) 1]) min([P.r.Si(i,n) P.bet])]);        %sweby
            P.psi.Li(i,n) = max([0 min([P.bet*P.r.Li(i,n) 1]) min([P.r.Li(i,n) P.bet])]);        %sweby
            P.psi.H(i,n) = max([0 min([P.bet*P.r.H(i,n) 1]) min([P.r.H(i,n) P.bet])]);        %sweby
            P.psi.C4(i,n) = max([0 min([P.bet*P.r.C4(i,n) 1]) min([P.r.C4(i,n) P.bet])]);        %sweby
            P.psi.HCO3(i,n) = max([0 min([P.bet*P.r.HCO3(i,n) 1]) min([P.r.HCO3(i,n) P.bet])]);        %sweby
            
        case 'superbee'           
                        
            P.psi.Na(i,n) = max([0 min([2*P.r.Na(i,n) 1]) min([P.r.Na(i,n) 2])]);        %Superbee
            P.psi.K(i,n) = max([0 min([2*P.r.K(i,n) 1]) min([P.r.K(i,n) 2])]);        %Superbee
            P.psi.Ca(i,n) = max([0 min([2*P.r.Ca(i,n) 1]) min([P.r.Ca(i,n) 2])]);        %Superbee
            P.psi.Mg(i,n) = max([0 min([2*P.r.Mg(i,n) 1]) min([P.r.Mg(i,n) 2])]);        %Superbee
            P.psi.Ba(i,n) = max([0 min([2*P.r.Ba(i,n) 1]) min([P.r.Ba(i,n) 2])]);        %Superbee
            P.psi.Sr(i,n) = max([0 min([2*P.r.Sr(i,n) 1]) min([P.r.Sr(i,n) 2])]);        %Superbee
            P.psi.Cl(i,n) = max([0 min([2*P.r.Cl(i,n) 1]) min([P.r.Cl(i,n) 2])]);        %Superbee
            P.psi.S(i,n) = max([0 min([2*P.r.S(i,n) 1]) min([P.r.S(i,n) 2])]);        %Superbee
            P.psi.B(i,n) = max([0 min([2*P.r.B(i,n) 1]) min([P.r.B(i,n) 2])]);        %Superbee
            P.psi.Al(i,n) = max([0 min([2*P.r.Al(i,n) 1]) min([P.r.Al(i,n) 2])]);        %Superbee
            P.psi.Si(i,n) = max([0 min([2*P.r.Si(i,n) 1]) min([P.r.Si(i,n) 2])]);        %Superbee
            P.psi.Li(i,n) = max([0 min([2*P.r.Li(i,n) 1]) min([P.r.Li(i,n) 2])]);        %Superbee
            P.psi.H(i,n) = max([0 min([2*P.r.H(i,n) 1]) min([P.r.H(i,n) 2])]);        %Superbee
            P.psi.C4(i,n) = max([0 min([2*P.r.C4(i,n) 1]) min([P.r.C4(i,n) 2])]);        %Superbee
            P.psi.HCO3(i,n) = max([0 min([2*P.r.HCO3(i,n) 1]) min([P.r.HCO3(i,n) 2])]);        %Superbee
    
        case 'minmod' 
            P.psi.Na(i,n) = max([0 min([1 P.r.Na(i,n)])]); %minmod
            P.psi.K(i,n) = max([0 min([1 P.r.K(i,n)])]); %minmod
            P.psi.Ca(i,n) = max([0 min([1 P.r.Ca(i,n)])]); %minmod
            P.psi.Mg(i,n) = max([0 min([1 P.r.Mg(i,n)])]); %minmod
            P.psi.Ba(i,n) = max([0 min([1 P.r.Ba(i,n)])]); %minmod
            P.psi.Sr(i,n) = max([0 min([1 P.r.Sr(i,n)])]); %minmod
            P.psi.Cl(i,n) = max([0 min([1 P.r.Cl(i,n)])]); %minmod
            P.psi.S(i,n) = max([0 min([1 P.r.S(i,n)])]); %minmod
            P.psi.B(i,n) = max([0 min([1 P.r.B(i,n)])]); %minmod
            P.psi.Al(i,n) = max([0 min([1 P.r.Al(i,n)])]); %minmod
            P.psi.Si(i,n) = max([0 min([1 P.r.Si(i,n)])]); %minmod
            P.psi.Li(i,n) = max([0 min([1 P.r.Li(i,n)])]); %minmod
            P.psi.H(i,n) = max([0 min([1 P.r.H(i,n)])]); %minmod
            P.psi.C4(i,n) = max([0 min([1 P.r.C4(i,n)])]); %minmod
            P.psi.HCO3(i,n) = max([0 min([1 P.r.HCO3(i,n)])]); %minmod            
        otherwise
       error('No limiter defined. Check spelling.');     
    end               
end

for i=1:P.nsw
    %Second order
    if i==1             
        %C.Na(i,n+1)     = (1./F.Sw(i,n+1)) .* (F.Sw(i,n).*C.Na(i,n)    - ((P.ut * P.dt) / (P.porosity * P.dx))*(1+.5*P.psi.Na(i,n)) * (C.Na(i,n)*F.fw(i,n)-C_bc.Na(1,n)*1));                        
        C.Na(i,n+1)     = C.Na(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.Na(i,n)-C_bc.Na(1,n));
        C.K(i,n+1)     = C.K(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.K(i,n)-C_bc.K(1,n));
        C.Ca(i,n+1)     = C.Ca(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.Ca(i,n)-C_bc.Ca(1,n));
        C.Mg(i,n+1)     = C.Mg(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.Mg(i,n)-C_bc.Mg(1,n));
        C.Ba(i,n+1)     = C.Ba(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.Ba(i,n)-C_bc.Ba(1,n));
        C.Sr(i,n+1)     = C.Sr(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.Sr(i,n)-C_bc.Sr(1,n));
        C.Cl(i,n+1)     = C.Cl(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.Cl(i,n)-C_bc.Cl(1,n));
        C.S(i,n+1)     = C.S(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.S(i,n)-C_bc.S(1,n));
        C.B(i,n+1)     = C.B(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.B(i,n)-C_bc.B(1,n));
        C.Al(i,n+1)     = C.Al(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.Al(i,n)-C_bc.Al(1,n));
        C.Si(i,n+1)     = C.Si(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.Si(i,n)-C_bc.Si(1,n));
        C.Li(i,n+1)     = C.Li(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.Li(i,n)-C_bc.Li(1,n));
        C.H(i,n+1)     = C.H(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.H(i,n)-C_bc.H(1,n));
        C.C4(i,n+1)     = C.C4(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.C4(i,n)-C_bc.C4(1,n));
%        C.HCO3(i,n+1)     = C.HCO3(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * (C.HCO3(i,n)-C_bc.HCO3(1,n));                       
        
        %Is Euler modified to be used?
        if P.EulerOrder==2            
            C.Na(i,n+1)     = C.Na(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.Na(i,n)+C.Na(i,n+1))/2-C_bc.Na(1,n));    
            C.K(i,n+1)     = C.K(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.K(i,n)+C.K(i,n+1))/2-C_bc.K(1,n));    
            C.Ca(i,n+1)     = C.Ca(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.Ca(i,n)+C.Ca(i,n+1))/2-C_bc.Ca(1,n));    
            C.Mg(i,n+1)     = C.Mg(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.Mg(i,n)+C.Mg(i,n+1))/2-C_bc.Mg(1,n));    
            C.Ba(i,n+1)     = C.Ba(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.Ba(i,n)+C.Ba(i,n+1))/2-C_bc.Ba(1,n));    
            C.Sr(i,n+1)     = C.Sr(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.Sr(i,n)+C.Sr(i,n+1))/2-C_bc.Sr(1,n));    
            C.Cl(i,n+1)     = C.Cl(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.Cl(i,n)+C.Cl(i,n+1))/2-C_bc.Cl(1,n));    
            C.S(i,n+1)     = C.S(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.S(i,n)+C.S(i,n+1))/2-C_bc.S(1,n));    
            C.B(i,n+1)     = C.B(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.B(i,n)+C.B(i,n+1))/2-C_bc.B(1,n));    
            C.Al(i,n+1)     = C.Al(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.Al(i,n)+C.Al(i,n+1))/2-C_bc.Al(1,n));    
            C.Si(i,n+1)     = C.Si(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.Si(i,n)+C.Si(i,n+1))/2-C_bc.Si(1,n));    
            C.Li(i,n+1)     = C.Li(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.Li(i,n)+C.Li(i,n+1))/2-C_bc.Li(1,n));    
            C.H(i,n+1)     = C.H(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.H(i,n)+C.H(i,n+1))/2-C_bc.H(1,n));    
            C.C4(i,n+1)     = C.C4(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.C4(i,n)+C.C4(i,n+1))/2-C_bc.C4(1,n));    
%            C.HCO3(i,n+1)     = C.HCO3(i,n)     - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) * ((C.HCO3(i,n)+C.HCO3(i,n+1))/2-C_bc.HCO3(1,n));    
        end
        
    else
        
        
        %Na,K,Ca,Mg,Ba,Sr,Cl,S,B,Al,Si,Li,H,C4,HCO3
        %Na
        if abs(P.psi.Na(i-1,n)) == 0            
            C.Na(i,n+1)         = C.Na(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Na(i,n)-0.5 * 0                                 )    * (C.Na(i,n)-C.Na(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Na(i,n+1)     = C.Na(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Na(i,n)-0.5 * 0                                 )    * (((C.Na(i,n)-C.Na(i-1,n))+(C.Na(i,n+1)-C.Na(i-1,n+1)))/2);                
            end
        else
            C.Na(i,n+1)         = C.Na(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Na(i,n)-0.5 * P.psi.Na(i-1,n) / P.r.Na(i-1,n)   )    * (C.Na(i,n)-C.Na(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Na(i,n+1)     = C.Na(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Na(i,n)-0.5 * P.psi.Na(i-1,n) / P.r.Na(i-1,n)   )    * (((C.Na(i,n)-C.Na(i-1,n))+(C.Na(i,n+1)-C.Na(i-1,n+1)))/2);                            
            end
        end
        %K
        if abs(P.psi.K(i-1,n)) == 0            
            C.K(i,n+1)         = C.K(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.K(i,n)-0.5 * 0                                 )    * (C.K(i,n)-C.K(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.K(i,n+1)     = C.K(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.K(i,n)-0.5 * 0                                 )    * (((C.K(i,n)-C.K(i-1,n))+(C.K(i,n+1)-C.K(i-1,n+1)))/2);                
            end
        else
            C.K(i,n+1)         = C.K(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.K(i,n)-0.5 * P.psi.K(i-1,n) / P.r.K(i-1,n)   )    * (C.K(i,n)-C.K(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.K(i,n+1)     = C.K(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.K(i,n)-0.5 * P.psi.K(i-1,n) / P.r.K(i-1,n)   )    * (((C.K(i,n)-C.K(i-1,n))+(C.K(i,n+1)-C.K(i-1,n+1)))/2);                            
            end
        end
        %Ca
        if abs(P.psi.Ca(i-1,n)) == 0            
            C.Ca(i,n+1)         = C.Ca(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Ca(i,n)-0.5 * 0                                 )    * (C.Ca(i,n)-C.Ca(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Ca(i,n+1)     = C.Ca(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Ca(i,n)-0.5 * 0                                 )    * (((C.Ca(i,n)-C.Ca(i-1,n))+(C.Ca(i,n+1)-C.Ca(i-1,n+1)))/2);                
            end
        else
            C.Ca(i,n+1)         = C.Ca(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Ca(i,n)-0.5 * P.psi.Ca(i-1,n) / P.r.Ca(i-1,n)   )    * (C.Ca(i,n)-C.Ca(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Ca(i,n+1)     = C.Ca(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Ca(i,n)-0.5 * P.psi.Ca(i-1,n) / P.r.Ca(i-1,n)   )    * (((C.Ca(i,n)-C.Ca(i-1,n))+(C.Ca(i,n+1)-C.Ca(i-1,n+1)))/2);                            
            end
        end
        %Mg
        if abs(P.psi.Mg(i-1,n)) == 0            
            C.Mg(i,n+1)         = C.Mg(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Mg(i,n)-0.5 * 0                                 )    * (C.Mg(i,n)-C.Mg(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Mg(i,n+1)     = C.Mg(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Mg(i,n)-0.5 * 0                                 )    * (((C.Mg(i,n)-C.Mg(i-1,n))+(C.Mg(i,n+1)-C.Mg(i-1,n+1)))/2);                
            end
        else
            C.Mg(i,n+1)         = C.Mg(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Mg(i,n)-0.5 * P.psi.Mg(i-1,n) / P.r.Mg(i-1,n)   )    * (C.Mg(i,n)-C.Mg(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Mg(i,n+1)     = C.Mg(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Mg(i,n)-0.5 * P.psi.Mg(i-1,n) / P.r.Mg(i-1,n)   )    * (((C.Mg(i,n)-C.Mg(i-1,n))+(C.Mg(i,n+1)-C.Mg(i-1,n+1)))/2);                            
            end
        end
        %Ba
        if abs(P.psi.Ba(i-1,n)) == 0            
            C.Ba(i,n+1)         = C.Ba(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Ba(i,n)-0.5 * 0                                 )    * (C.Ba(i,n)-C.Ba(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Ba(i,n+1)     = C.Ba(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Ba(i,n)-0.5 * 0                                 )    * (((C.Ba(i,n)-C.Ba(i-1,n))+(C.Ba(i,n+1)-C.Ba(i-1,n+1)))/2);                
            end
        else
            C.Ba(i,n+1)         = C.Ba(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Ba(i,n)-0.5 * P.psi.Ba(i-1,n) / P.r.Ba(i-1,n)   )    * (C.Ba(i,n)-C.Ba(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Ba(i,n+1)     = C.Ba(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Ba(i,n)-0.5 * P.psi.Ba(i-1,n) / P.r.Ba(i-1,n)   )    * (((C.Ba(i,n)-C.Ba(i-1,n))+(C.Ba(i,n+1)-C.Ba(i-1,n+1)))/2);                            
            end
        end
        %Sr
        if abs(P.psi.Sr(i-1,n)) == 0            
            C.Sr(i,n+1)         = C.Sr(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Sr(i,n)-0.5 * 0                                 )    * (C.Sr(i,n)-C.Sr(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Sr(i,n+1)     = C.Sr(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Sr(i,n)-0.5 * 0                                 )    * (((C.Sr(i,n)-C.Sr(i-1,n))+(C.Sr(i,n+1)-C.Sr(i-1,n+1)))/2);                
            end
        else
            C.Sr(i,n+1)         = C.Sr(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Sr(i,n)-0.5 * P.psi.Sr(i-1,n) / P.r.Sr(i-1,n)   )    * (C.Sr(i,n)-C.Sr(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Sr(i,n+1)     = C.Sr(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Sr(i,n)-0.5 * P.psi.Sr(i-1,n) / P.r.Sr(i-1,n)   )    * (((C.Sr(i,n)-C.Sr(i-1,n))+(C.Sr(i,n+1)-C.Sr(i-1,n+1)))/2);                            
            end
        end
        %Cl
        if abs(P.psi.Cl(i-1,n)) == 0            
            C.Cl(i,n+1)         = C.Cl(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Cl(i,n)-0.5 * 0                                 )    * (C.Cl(i,n)-C.Cl(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Cl(i,n+1)     = C.Cl(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Cl(i,n)-0.5 * 0                                 )    * (((C.Cl(i,n)-C.Cl(i-1,n))+(C.Cl(i,n+1)-C.Cl(i-1,n+1)))/2);                
            end
        else
            C.Cl(i,n+1)         = C.Cl(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Cl(i,n)-0.5 * P.psi.Cl(i-1,n) / P.r.Cl(i-1,n)   )    * (C.Cl(i,n)-C.Cl(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Cl(i,n+1)     = C.Cl(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Cl(i,n)-0.5 * P.psi.Cl(i-1,n) / P.r.Cl(i-1,n)   )    * (((C.Cl(i,n)-C.Cl(i-1,n))+(C.Cl(i,n+1)-C.Cl(i-1,n+1)))/2);                            
            end
        end
        %S
        if abs(P.psi.S(i-1,n)) == 0            
            C.S(i,n+1)         = C.S(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.S(i,n)-0.5 * 0                                 )    * (C.S(i,n)-C.S(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.S(i,n+1)     = C.S(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.S(i,n)-0.5 * 0                                 )    * (((C.S(i,n)-C.S(i-1,n))+(C.S(i,n+1)-C.S(i-1,n+1)))/2);                
            end
        else
            C.S(i,n+1)         = C.S(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.S(i,n)-0.5 * P.psi.S(i-1,n) / P.r.S(i-1,n)   )    * (C.S(i,n)-C.S(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.S(i,n+1)     = C.S(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.S(i,n)-0.5 * P.psi.S(i-1,n) / P.r.S(i-1,n)   )    * (((C.S(i,n)-C.S(i-1,n))+(C.S(i,n+1)-C.S(i-1,n+1)))/2);                            
            end
        end
        %B
        if abs(P.psi.B(i-1,n)) == 0            
            C.B(i,n+1)         = C.B(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.B(i,n)-0.5 * 0                                 )    * (C.B(i,n)-C.B(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.B(i,n+1)     = C.B(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.B(i,n)-0.5 * 0                                 )    * (((C.B(i,n)-C.B(i-1,n))+(C.B(i,n+1)-C.B(i-1,n+1)))/2);                
            end
        else
            C.B(i,n+1)         = C.B(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.B(i,n)-0.5 * P.psi.B(i-1,n) / P.r.B(i-1,n)   )    * (C.B(i,n)-C.B(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.B(i,n+1)     = C.B(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.B(i,n)-0.5 * P.psi.B(i-1,n) / P.r.B(i-1,n)   )    * (((C.B(i,n)-C.B(i-1,n))+(C.B(i,n+1)-C.B(i-1,n+1)))/2);                            
            end
        end
        %Al
        if abs(P.psi.Al(i-1,n)) == 0            
            C.Al(i,n+1)         = C.Al(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Al(i,n)-0.5 * 0                                 )    * (C.Al(i,n)-C.Al(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Al(i,n+1)     = C.Al(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Al(i,n)-0.5 * 0                                 )    * (((C.Al(i,n)-C.Al(i-1,n))+(C.Al(i,n+1)-C.Al(i-1,n+1)))/2);                
            end
        else
            C.Al(i,n+1)         = C.Al(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Al(i,n)-0.5 * P.psi.Al(i-1,n) / P.r.Al(i-1,n)   )    * (C.Al(i,n)-C.Al(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Al(i,n+1)     = C.Al(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Al(i,n)-0.5 * P.psi.Al(i-1,n) / P.r.Al(i-1,n)   )    * (((C.Al(i,n)-C.Al(i-1,n))+(C.Al(i,n+1)-C.Al(i-1,n+1)))/2);                            
            end
        end
        %Si
        if abs(P.psi.Si(i-1,n)) == 0            
            C.Si(i,n+1)         = C.Si(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Si(i,n)-0.5 * 0                                 )    * (C.Si(i,n)-C.Si(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Si(i,n+1)     = C.Si(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Si(i,n)-0.5 * 0                                 )    * (((C.Si(i,n)-C.Si(i-1,n))+(C.Si(i,n+1)-C.Si(i-1,n+1)))/2);                
            end
        else
            C.Si(i,n+1)         = C.Si(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Si(i,n)-0.5 * P.psi.Si(i-1,n) / P.r.Si(i-1,n)   )    * (C.Si(i,n)-C.Si(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Si(i,n+1)     = C.Si(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Si(i,n)-0.5 * P.psi.Si(i-1,n) / P.r.Si(i-1,n)   )    * (((C.Si(i,n)-C.Si(i-1,n))+(C.Si(i,n+1)-C.Si(i-1,n+1)))/2);                            
            end
        end
        %Li
        if abs(P.psi.Li(i-1,n)) == 0            
            C.Li(i,n+1)         = C.Li(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Li(i,n)-0.5 * 0                                 )    * (C.Li(i,n)-C.Li(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Li(i,n+1)     = C.Li(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Li(i,n)-0.5 * 0                                 )    * (((C.Li(i,n)-C.Li(i-1,n))+(C.Li(i,n+1)-C.Li(i-1,n+1)))/2);                
            end
        else
            C.Li(i,n+1)         = C.Li(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Li(i,n)-0.5 * P.psi.Li(i-1,n) / P.r.Li(i-1,n)   )    * (C.Li(i,n)-C.Li(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.Li(i,n+1)     = C.Li(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.Li(i,n)-0.5 * P.psi.Li(i-1,n) / P.r.Li(i-1,n)   )    * (((C.Li(i,n)-C.Li(i-1,n))+(C.Li(i,n+1)-C.Li(i-1,n+1)))/2);                            
            end
        end
        %H
        if abs(P.psi.H(i-1,n)) == 0            
            C.H(i,n+1)         = C.H(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.H(i,n)-0.5 * 0                                 )    * (C.H(i,n)-C.H(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.H(i,n+1)     = C.H(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.H(i,n)-0.5 * 0                                 )    * (((C.H(i,n)-C.H(i-1,n))+(C.H(i,n+1)-C.H(i-1,n+1)))/2);                
            end
        else
            C.H(i,n+1)         = C.H(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.H(i,n)-0.5 * P.psi.H(i-1,n) / P.r.H(i-1,n)   )    * (C.H(i,n)-C.H(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.H(i,n+1)     = C.H(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.H(i,n)-0.5 * P.psi.H(i-1,n) / P.r.H(i-1,n)   )    * (((C.H(i,n)-C.H(i-1,n))+(C.H(i,n+1)-C.H(i-1,n+1)))/2);                            
            end
        end
        %C4
        if abs(P.psi.C4(i-1,n)) == 0            
            C.C4(i,n+1)         = C.C4(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.C4(i,n)-0.5 * 0                                 )    * (C.C4(i,n)-C.C4(i-1,n));                
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.C4(i,n+1)     = C.C4(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.C4(i,n)-0.5 * 0                                 )    * (((C.C4(i,n)-C.C4(i-1,n))+(C.C4(i,n+1)-C.C4(i-1,n+1)))/2);                
            end
        else
            C.C4(i,n+1)         = C.C4(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.C4(i,n)-0.5 * P.psi.C4(i-1,n) / P.r.C4(i-1,n)   )    * (C.C4(i,n)-C.C4(i-1,n));                            
            %Is Euler modified to be used?
            if P.EulerOrder==2            
                C.C4(i,n+1)     = C.C4(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.C4(i,n)-0.5 * P.psi.C4(i-1,n) / P.r.C4(i-1,n)   )    * (((C.C4(i,n)-C.C4(i-1,n))+(C.C4(i,n+1)-C.C4(i-1,n+1)))/2);                            
            end
        end
        %HCO3
%        if abs(P.psi.HCO3(i-1,n)) == 0            
%            C.HCO3(i,n+1)         = C.HCO3(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.HCO3(i,n)-0.5 * 0                                 )    * (C.HCO3(i,n)-C.HCO3(i-1,n));                
%            %Is Euler modified to be used?
%            if P.EulerOrder==2            
%                C.HCO3(i,n+1)     = C.HCO3(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.HCO3(i,n)-0.5 * 0                                 )    * (((C.HCO3(i,n)-C.HCO3(i-1,n))+(C.HCO3(i,n+1)-C.HCO3(i-1,n+1)))/2);                
%            end
%        else
%            C.HCO3(i,n+1)         = C.HCO3(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.HCO3(i,n)-0.5 * P.psi.HCO3(i-1,n) / P.r.HCO3(i-1,n)   )    * (C.HCO3(i,n)-C.HCO3(i-1,n));                            
%            %Is Euler modified to be used?
%            if P.EulerOrder==2            
%                C.HCO3(i,n+1)     = C.HCO3(i,n) - ((P.ut * P.dt * F.fw(i,n)) / (P.porosity * P.dx * F.Sw(i,n))) *   (1+.5*P.psi.HCO3(i,n)-0.5 * P.psi.HCO3(i-1,n) / P.r.HCO3(i-1,n)   )    * (((C.HCO3(i,n)-C.HCO3(i-1,n))+(C.HCO3(i,n+1)-C.HCO3(i-1,n+1)))/2);                            
%            end
%        end                   
    end
end