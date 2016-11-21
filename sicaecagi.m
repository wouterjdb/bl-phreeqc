%Save Ion Concentration And Exchanger Composition After Geochemical
%Interaction (sicaecagi)

%Convert output to decimal numbers
matrix = cell2mat(result(size(result,1),7:54));    %always use bottom row

%Save concentrations and exchanger composition
C.Na(m,n+1) = matrix(4);       X.Na(m,n+1) = matrix(19)*F.Sw(m,n+1); %Output of amount of exchanger is per kgw. Less water used for lower Sw but assumed full water wet
C.K(m,n+1)  = matrix(5);       X.K(m,n+1)  = matrix(24)*F.Sw(m,n+1);
C.Ca(m,n+1) = matrix(6);       X.Ca(m,n+1) = matrix(18)*F.Sw(m,n+1);
C.Mg(m,n+1) = matrix(7);       X.Mg(m,n+1) = matrix(21)*F.Sw(m,n+1);
C.Ba(m,n+1) = matrix(8);       X.Ba(m,n+1) = matrix(22)*F.Sw(m,n+1);
C.Sr(m,n+1) = matrix(9);       X.Sr(m,n+1) = matrix(23)*F.Sw(m,n+1);
C.Cl(m,n+1) = matrix(10);     
C.S(m,n+1)  = matrix(11);     
C.B(m,n+1)  = matrix(12);     
C.Al(m,n+1) = matrix(13);      X.Al(m,n+1) = matrix(27)*F.Sw(m,n+1); X.AlOH(m,n+1) = matrix(26)*F.Sw(m,n+1);  
C.Si(m,n+1) = matrix(14);     
C.Li(m,n+1) = matrix(15);      X.Li(m,n+1) = matrix(25)*F.Sw(m,n+1);
C.C4(m,n+1) = matrix(16);
%in mol/kgw used for pH calculation
C.H(m,n+1)  = 10^-matrix(1);   X.H(m,n+1)  = matrix(20)*F.Sw(m,n+1);


%C.H(m,n+1)  = matrix(42);      X.H(m,n+1)  = matrix(20)*F.Sw(m,n+1);
F.pH(m,n+1)  = matrix(1);

F.sumX(m,n+1) = matrix(47)*F.Sw(m,n+1);
F.Salinity(m,n+1) = (C.Na(m,n+1)*22.9898+C.K(m,n+1)*39.102+C.Ca(m,n+1)*40.08+C.Mg(m,n+1)*24.312+C.Ba(m,n+1)*137.34+C.Sr(m,n+1)*87.62+C.Cl(m,n+1)*35.453+C.S(m,n+1)*32.064+C.B(m,n+1)*10.81+C.Al(m,n+1)*26.9815+C.Si(m,n+1)*28.0843+C.Li(m,n+1)*6.939)*1000;

C.HCO3(m,n+1)  = matrix(26);

Calcite.k(m,n+1)    = matrix(44);
Calcite.dk(m,n+1)   = matrix(45);
Calcite.SI(m,n+1)   = matrix(43);