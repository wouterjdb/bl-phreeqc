%Calculate And Save Ion Concentration After Transport (casicat)

% for loopIndex = 1:numel(P.fieldnames)
%     C.(P.fieldnames{loopIndex})(m,n+1) = (1/F.F.Sw(m,n+1)) * (F.F.Sw(m,n)*C.(P.fieldnames{loopIndex})(m,n)-((P.P.ut * P.P.dt) / (P.P.porosity * P.P.dx))*(F.F.fw(m,n)*C.(P.fieldnames{loopIndex})(m,n)-F_bc.fw.F.fw(m)*C.bc.(P.fieldnames{loopIndex})(m)));
% end     

% C.Na(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Na(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Na(m,n)-F_bc.fw(m)*C_bc.Na(n)));
% C.K(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.K(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.K(m,n) -F_bc.fw(m)*C_bc.K(n)));
% C.Ca(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Ca(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Ca(m,n)-F_bc.fw(m)*C_bc.Ca(n)));
% C.Mg(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Mg(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Mg(m,n)-F_bc.fw(m)*C_bc.Mg(n)));
% C.Ba(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Ba(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Ba(m,n)-F_bc.fw(m)*C_bc.Ba(n)));
% C.Sr(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Sr(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Sr(m,n)-F_bc.fw(m)*C_bc.Sr(n)));
% C.Cl(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Cl(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Cl(m,n)-F_bc.fw(m)*C_bc.Cl(n)));
% C.S(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.S(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.S(m,n) -F_bc.fw(m)*C_bc.S(n)));
% C.B(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.B(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.B(m,n) -F_bc.fw(m)*C_bc.B(n)));
% C.Al(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Al(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Al(m,n)-F_bc.fw(m)*C_bc.Al(n)));
% C.Si(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Si(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Si(m,n)-F_bc.fw(m)*C_bc.Si(n)));
% C.Li(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Li(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Li(m,n)-F_bc.fw(m)*C_bc.Li(n)));
% C.H(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.H(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.H(m,n) -F_bc.fw(m)*C_bc.H(n)));  
% 
% C.C4(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.C4(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.C4(m,n) -F_bc.fw(m)*C_bc.C4(n)));  
% 
% 
% C.HCO3(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.HCO3(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.HCO3(m,n)-F_bc.fw(m)*C_bc.HCO3(n)));  


%C.Na(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Na(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Na(m,n)-F_bc.fw(m)*W_bc(n).Na));
C.K(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.K(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.K(m,n) -F_bc.fw(m)*W_bc(n).K));
C.Ca(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Ca(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Ca(m,n)-F_bc.fw(m)*W_bc(n).Ca));
C.Mg(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Mg(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Mg(m,n)-F_bc.fw(m)*W_bc(n).Mg));
C.Ba(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Ba(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Ba(m,n)-F_bc.fw(m)*W_bc(n).Ba));
C.Sr(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Sr(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Sr(m,n)-F_bc.fw(m)*W_bc(n).Sr));
C.Cl(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Cl(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Cl(m,n)-F_bc.fw(m)*W_bc(n).Cl));
C.S(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.S(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.S(m,n) -F_bc.fw(m)*W_bc(n).S));
C.B(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.B(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.B(m,n) -F_bc.fw(m)*W_bc(n).B));
C.Al(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Al(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Al(m,n)-F_bc.fw(m)*W_bc(n).Al));
C.Si(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Si(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Si(m,n)-F_bc.fw(m)*W_bc(n).Si));
C.Li(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.Li(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.Li(m,n)-F_bc.fw(m)*W_bc(n).Li));
C.H(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.H(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.H(m,n) -F_bc.fw(m)*W_bc(n).H));  

C.C4(m,n+1)  = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.C4(m,n) -((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.C4(m,n) -F_bc.fw(m)*W_bc(n).C4));  


C.HCO3(m,n+1) = (1/F.Sw(m,n+1)) * (F.Sw(m,n)*C.HCO3(m,n)-((P.ut * P.dt) / (P.porosity * P.dx))*(F.fw(m,n)*C.HCO3(m,n)-F_bc.fw(m)*W_bc(n).HCO3)); 