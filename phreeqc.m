function [ output ] = phreeqc(iphreeqc, C, P, F, X, Calcite, m, n)
%PHREEQC MATLAB function enabling PHREEQC simulation.
%   Detailed explanation goes here


    iphreeqc.AccumulateLine('USER_PUNCH');
    iphreeqc.AccumulateLine('	-headings PV sumX MU');
    iphreeqc.AccumulateLine('	-start');
    iphreeqc.AccumulateLine('	10 punch STEP_NO');
    iphreeqc.AccumulateLine('	20 punch 3*MOL("AlX3")+2*(MOL("CaX2")+MOL("MgX2")+MOL("SrX2")+MOL("BaX2")+MOL("AlOHX2"))+MOL("NaX")+MOL("KX")+MOL("HX")+MOL("LiX")');
    iphreeqc.AccumulateLine('	30 punch MU');
    iphreeqc.AccumulateLine('	-end');


    iphreeqc.AccumulateLine('SELECTED_OUTPUT');
    iphreeqc.AccumulateLine('	-high_precision true');
    iphreeqc.AccumulateLine('	-kinetic_reactants Calcite');
    iphreeqc.AccumulateLine('	-saturation_indices Calcite #CO2(g)');
    iphreeqc.AccumulateLine('	-totals Na K Ca Mg Ba Sr Cl S B Al Si Li C(+4)')
    iphreeqc.AccumulateLine('	-molalities Ca+2 CaX2 NaX HX MgX2 BaX2 SrX2 KX LiX AlOHX2 AlX3 Na+ Cl- K+ Mg+2 Ba+2 Sr+2 SO4-2 H3BO3 Al+3 H4SiO4 Li+ HCO3- CO2 CO3-2 H+');
    iphreeqc.AccumulateLine('	-temperature');


    iphreeqc.AccumulateLine('EXCHANGE_SPECIES');
    iphreeqc.AccumulateLine('	H+ + X- = HX');
    iphreeqc.AccumulateLine('	log_k	1.0');
    iphreeqc.AccumulateLine('	-gamma	9.0	0.0');


    iphreeqc.AccumulateLine('SOLUTION 0');
    iphreeqc.AccumulateLine('	-units     			mol/kgw');
    iphreeqc.AccumulateLine(['	-temperature        ' sprintf('%0.15g',P.T)]);
    iphreeqc.AccumulateLine(['	  -water    ' sprintf('%0.15g',F.Sw(m,n+1)) '     # kg']);
    
    if C.H(m,n+1)  > 0; iphreeqc.AccumulateLine(['	-pH '   sprintf('%0.15g',-log10(C.H(m,n+1)))]); end;                        
    
    %if C.H(m,n+1)  > 0; iphreeqc.AccumulateLine(['	H(1) '   sprintf('%0.15g',C.H(m,n+1))]); end;                        
    
    if C.Na(m,n+1) > 0; iphreeqc.AccumulateLine(['	Na  '   sprintf('%0.15g',C.Na(m,n+1))]);        end; 
    if C.K(m,n+1)  > 0; iphreeqc.AccumulateLine(['	K   '   sprintf('%0.15g',C.K(m,n+1))]);         end; 
    if C.Ca(m,n+1) > 0; iphreeqc.AccumulateLine(['	Ca  '   sprintf('%0.15g',C.Ca(m,n+1))]);        end; 
    if C.Mg(m,n+1) > 0; iphreeqc.AccumulateLine(['	Mg  '   sprintf('%0.15g',C.Mg(m,n+1))]);        end; 
    if C.Ba(m,n+1) > 0; iphreeqc.AccumulateLine(['	Ba  '   sprintf('%0.15g',C.Ba(m,n+1))]);        end; 
    if C.Sr(m,n+1) > 0; iphreeqc.AccumulateLine(['	Sr  '   sprintf('%0.15g',C.Sr(m,n+1))]);        end; 
    if C.Cl(m,n+1) > 0; iphreeqc.AccumulateLine(['	Cl  '   sprintf('%0.15g',C.Cl(m,n+1))]);        end; 
    if C.S(m,n+1)  > 0; iphreeqc.AccumulateLine(['	S   '   sprintf('%0.15g',C.S(m,n+1))]);         end; 
    if C.B(m,n+1)  > 0; iphreeqc.AccumulateLine(['	B   '   sprintf('%0.15g',C.B(m,n+1))]);         end; 
    if C.Al(m,n+1) > 0; iphreeqc.AccumulateLine(['	Al  '   sprintf('%0.15g',C.Al(m,n+1))]);        end; 
    if C.Si(m,n+1) > 0; iphreeqc.AccumulateLine(['	Si  '   sprintf('%0.15g',C.Si(m,n+1))]);        end; 
    if C.Li(m,n+1) > 0; iphreeqc.AccumulateLine(['	Li  '   sprintf('%0.15g',C.Li(m,n+1))]);        end;   
    if C.C4(m,n+1) > 0; iphreeqc.AccumulateLine(['	C(+4) ' sprintf('%0.15g',C.C4(m,n+1)) ]);       end;
    
    iphreeqc.AccumulateLine('EQUILIBRIUM_PHASES 0');
    iphreeqc.AccumulateLine(['	CO2(g)  ' sprintf('%0.15g',P.logP_CO2)]);
    if P.UseKinetics == false;  iphreeqc.AccumulateLine('	Calcite 0.0'); end;
        
    %Check if an exchanger composition for the current grid cell exists
    if X.Na(m,n) == 0 
        %No exchanger composition, equilibriate with defined water (first
        %timestep)
        iphreeqc.AccumulateLine('EXCHANGE 0');
        iphreeqc.AccumulateLine('	-equilibrate 0');
        iphreeqc.AccumulateLine(['	X  ' sprintf('%0.15g',P.ExchangerTot) ' #mol/L']);       
    else       
        %Exchanger present, use preceding time step as basis for geochemical
        %calculation (mol attached/kgw)
        iphreeqc.AccumulateLine('EXCHANGE 0');
        if X.Na(m,n)    > 0; iphreeqc.AccumulateLine(['	NaX '     sprintf('%0.15g',X.Na(m,n))  ]);   end;
        if X.Ca(m,n)    > 0; iphreeqc.AccumulateLine(['	CaX2 '    sprintf('%0.15g',X.Ca(m,n))  ]);   end;
        if X.H(m,n)     > 0; iphreeqc.AccumulateLine(['	HX '      sprintf('%0.15g',X.H(m,n))   ]);   end;
        if X.Mg(m,n)    > 0; iphreeqc.AccumulateLine(['	MgX2 '    sprintf('%0.15g',X.Mg(m,n))  ]);   end;
        if X.Ba(m,n)    > 0; iphreeqc.AccumulateLine(['	BaX2 '    sprintf('%0.15g',X.Ba(m,n))  ]);   end;
        if X.Sr(m,n)    > 0; iphreeqc.AccumulateLine(['	SrX2 '    sprintf('%0.15g',X.Sr(m,n))  ]);   end;
        if X.K(m,n)     > 0; iphreeqc.AccumulateLine(['	KX '      sprintf('%0.15g',X.K(m,n))   ]);   end;
        if X.Li(m,n)    > 0; iphreeqc.AccumulateLine(['	LiX '     sprintf('%0.15g',X.Li(m,n))  ]);   end;
        if X.AlOH(m,n)  > 0; iphreeqc.AccumulateLine(['	AlOHX2 '  sprintf('%0.15g',X.AlOH(m,n))]);   end;
        if X.Al(m,n)    > 0; iphreeqc.AccumulateLine(['	AlX3 '    sprintf('%0.15g',X.Al(m,n))  ]);   end;   
    end     
    
        %Add kinetic block if required
    if P.UseKinetics == true 
        
        %iphreeqc.AccumulateLine('EQUILIBRIUM_PHASES 0');
        %iphreeqc.AccumulateLine(['	CO2(g)  ' sprintf('%0.15g',P.logP_CO2)]);
                
        iphreeqc.AccumulateLine('RATES 0');
        iphreeqc.AccumulateLine('Calcite');
        iphreeqc.AccumulateLine('	-start');
        iphreeqc.AccumulateLine('		10  S = m*100.07*0.01 #n*M*beta');
        iphreeqc.AccumulateLine('		20  k = 1e-6');
        iphreeqc.AccumulateLine('		30  rate = k*m*(1-SR("Calcite"))');
        iphreeqc.AccumulateLine('		40  moles = rate*time');
        iphreeqc.AccumulateLine('		100 SAVE moles');
        iphreeqc.AccumulateLine('	-end');

        iphreeqc.AccumulateLine('KINETICS 0');
        iphreeqc.AccumulateLine('     Calcite');
        iphreeqc.AccumulateLine(['        -m0 ' sprintf('%0.15g',Calcite.k(m,n))]);   %Use current amount of calcite as starting point, to calculate n+1 calcite
        iphreeqc.AccumulateLine(['     -steps ' sprintf('%0.15g',P.dt * 3600 * 24) ' in 1 steps']); %dt of 1 time step in seconds
                
        %else
        
        %iphreeqc.AccumulateLine('EQUILIBRIUM_PHASES 0');
        %iphreeqc.AccumulateLine(['	CO2(g)  ' sprintf('%0.15g',P.logP_CO2)]);
        %iphreeqc.AccumulateLine('	Calcite 0.0');
    end
                
%Run PHREEQC simulation    %(Type "iphreeqc.Lines" to get simulation input)
iphreeqc.RunAccumulated();

%Fetch Results (Faster than doing GetSelectedOutPutValue each time)
result = iphreeqc.GetSelectedOutputArray();

%Clear phreeqc accumulated (input) lines
iphreeqc.ClearAccumulatedLines()

%Send output back to MATLAB transport simulator
output = result;             
            
end

