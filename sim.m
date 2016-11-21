%Initialize PHREEQC COM Object (On 64bit system, install both 32 en 64 bit
%versions (needed in version August, 2012))
P.iphreeqc = actxserver('IPhreeqcCOM.Object');
P.iphreeqc.LoadDatabase(P.db);
P.iphreeqc.OutputFileOn = false;

if exist('n','var') == false
    n=1;
end

%Show a progressbar to the user (enables also user interruption of the
%simulation prcess)
h = waitbar(0,'Simulating, please wait... (Press any key to pause)',...
   'keypressfcn','set(gcbf,''userdata'',1)', ...
   'userdata',0);

TickOverall = tic;

%Simulate!
for n = n:P.nt-1
    TickOne = tic;

    %Calculated the relperm based on geochemical state
    relperm                   

    %Calculate fractional flow based on relative permeability
    F.krw(:,n)   = F.krwe(:,n).*((F.Sw(:,n)-F.swc)./(1-F.swc-F.sor(:,n))).^(F.nw(:,n));
    F.kro(:,n)   = F.kroe(:,n).*((1-F.Sw(:,n)-F.sor(:,n))./(1-F.swc-F.sor(:,n))).^(F.no(:,n));
    F.mob_w(:,n) = F.krw(:,n)./F.visco_w;
    F.mob_o(:,n) = F.kro(:,n)./F.visco_o; 
    F.fw(:,n)    = F.mob_w(:,n)./(F.mob_w(:,n)+F.mob_o(:,n));         
       
    %Calculation water saturation
    F.Sw(:,n+1) = F.Sw(:,n) - ((P.ut * P.dt) / (P.porosity * P.dx)) * ( K_u * F.fw(:,n) - F_bc.fw(:)); 
    
    %Is Euler modified to be used?
    if P.EulerOrder==2
        F.krw(:,n+1)   = F.krwe(:,n+1).*((F.Sw(:,n+1)-F.swc)./(1-F.swc-F.sor(:,n+1))).^(F.nw(:,n+1));
        F.kro(:,n+1)   = F.kroe(:,n+1).*((1-F.Sw(:,n+1)-F.sor(:,n+1))./(1-F.swc-F.sor(:,n+1))).^(F.no(:,n+1));
        F.mob_w(:,n+1) = F.krw(:,n+1)./F.visco_w;
        F.mob_o(:,n+1) = F.kro(:,n+1)./F.visco_o; 
        F.fw(:,n+1)    = F.mob_w(:,n+1)./(F.mob_w(:,n+1)+F.mob_o(:,n+1));         

        F.Sw(:,n+1) = F.Sw(:,n) - ((P.ut * P.dt) / (P.porosity * P.dx)) * ( K_u * ((F.fw(:,n) + F.fw(:,n+1))./2) - F_bc.fw(:)); 
    end
       
    %Calculate ion concentrations using the desired numerical scheme
    switch P.C_scheme 
        case 'upwind_1'           
            %Run numerical scheme
            upwind_1
        case 'upwind_2_limiter'           
            %Run numerical scheme
            upwind_2_limiter
        otherwise
            %The numercial scheme in undefined. Check spelling?!
            error('Numerical scheme undefined.')
    end
    
    %Loop thorugh all grid cells to perform geochemical calculations, and
    %save data.
    for m = 1:P.nsw      
       %See if geochemical interactions are desired (set in input_parameters)
       if P.usePhreeqc == true      
           
           %SmartSim means (set in input_parameters): do not calculate geochemical behavior for
           %non-invaded zones (no change in Sw)
           if P.UseSmartSim == true && F.Sw(m,n+1) == F.sw_init && n > 1 %mol/kgw
                %Next time step equals current timestep
                for loopIndex = 1:numel(P.fieldnamesC)
                    C.(P.fieldnamesC{loopIndex})(m,n+1) = C.(P.fieldnamesC{loopIndex})(m,n);                
                end   
                for loopIndex = 1:numel(P.fieldnamesX)
                    X.(P.fieldnamesX{loopIndex})(m,n+1) = X.(P.fieldnamesX{loopIndex})(m,n);                
                end
                for loopIndex = 1:numel(P.fieldnamesCalcite)
                    Calcite.(P.fieldnamesCalcite{loopIndex})(m,n+1) = Calcite.(P.fieldnamesCalcite{loopIndex})(m,n);                
                end                               
                F.Salinity(m,n+1)   = F.Salinity(m,n);
                F.pH(m,n+1)         = F.pH(m,n);
                F.sumX(m,n+1)       = F.sumX(m,n);

           else
               %Calculate geochemical effect
               result = phreeqc(P.iphreeqc,C,P,F,X,Calcite,m,n);  %#ok<NASGU>: Used in sicaecagi

               %Save Ion Concentration And Exchanger Composition After Geochemical
               %Interaction (sicaecagi)
               sicaecagi;                                          
           end
       else
            %Save Salinity and pH for non-PHREEQC situation
            F.Salinity(m,n+1)   = (C.Na(m,n+1)*22.9898+C.K(m,n+1)*39.102+C.Ca(m,n+1)*40.08+C.Mg(m,n+1)*24.312+C.Ba(m,n+1)*137.34+C.Sr(m,n+1)*87.62+C.Cl(m,n+1)*35.453+C.S(m,n+1)*32.064+C.B(m,n+1)*10.81+C.Al(m,n+1)*26.9815+C.Si(m,n+1)*28.0843+C.Li(m,n+1)*6.939)*1000;
            F.pH(m,n+1)         = -log10(C.H(m,n+1));                                      
       end
            
   end

    %Report status of simulator
    disp(['day = ' num2str(round(n*P.dt)) '; PV Injected = ' sprintf('%0.4g',P.dt*n*P.ut/P.porosity/P.L) '; Sw_producer = ' num2str(F.Sw(P.nsw,n)) '; Simulation time = ' num2str(floor(toc(TickOverall)/3600)) 'h, ' num2str(floor((toc(TickOverall)-floor(toc(TickOverall)/3600)*3600)/60)) 'm, ' num2str(floor((toc(TickOverall)-floor(toc(TickOverall)/3600)*3600)-floor((toc(TickOverall)-floor(toc(TickOverall)/3600)*3600)/60)*60)) 's; ETA = ' num2str(floor((toc(TickOne))*(P.nt-n)/3600)) 'h, ' num2str(floor((((toc(TickOne))*(P.nt-n))-floor((toc(TickOne))*(P.nt-n)/3600)*3600)/60)) 'm'])
    %pause(0.0001); %Used to be able to cancel process by Ctrl+C at all
    %times. Remove to increase speed marginal! (if no progreesbar window is
    %used this should be uncommented if one want to be able to kill the
    %simulation process)
    
    %Update the progressbar
    waitbar(n/P.nt,h)
       
    %Check if the user has touched a button on the keyboard (while the
    %progresbar was in focus). If so, stop the loop. The simulation can be
    %restarted from the results menu by using 'r' from the point it was
    %terminated.
    if get(h,'userdata')
        break; 
    end
    
end

%Cleaning...
close(h)
clear result matrix LoopIndex;
P.iphreeqc.delete()