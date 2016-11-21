%Generate time space
P.t = linspace(0,P.t_end,(P.t_end)/P.dt);
P.nt = numel(P.t);                  %Number of time steps
%P.pre  = P.pre /P.dt; %Convert from days to timesteps
%P.slug = P.slug/P.dt; %Convert from days to timesteps

%Generate distance space
P.x = linspace(0,P.L,P.nsw);

%Generate PV injected space
P.PV = linspace(0,P.t_end*P.ut/P.porosity/P.L,P.nt);

%Build water saturation and fractional flow matrices
F.Sw = zeros(P.nsw,P.nt);
F.fw = zeros(P.nsw,P.nt);

%Matrix to save salinties
F.Salinity = zeros(P.nsw,P.nt);
%Initial Conditions
F.Salinity(:,1) = (W.FW.Na*22.9898+W.FW.K*39.102+W.FW.Ca*40.08+W.FW.Mg*24.312+W.FW.Ba*137.34+W.FW.Sr*87.62+W.FW.Cl*35.453+W.FW.S*32.064+W.FW.B*10.81+W.FW.Al*26.9815+W.FW.Si*28.0843+W.FW.Li*6.939)*1000;

%Matrix to save pH
F.pH = zeros(P.nsw,P.nt);

%Matrix to save sumX values
F.sumX = zeros(P.nsw,P.nt);

%Build Ion concentration and exchanger matrices
C.Na = zeros(P.nsw,P.nt); X.Na = zeros(P.nsw,P.nt);
C.K  = zeros(P.nsw,P.nt); X.K  = zeros(P.nsw,P.nt);
C.Ca = zeros(P.nsw,P.nt); X.Ca = zeros(P.nsw,P.nt);
C.Mg = zeros(P.nsw,P.nt); X.Mg = zeros(P.nsw,P.nt);
C.Ba = zeros(P.nsw,P.nt); X.Ba = zeros(P.nsw,P.nt);
C.Sr = zeros(P.nsw,P.nt); X.Sr = zeros(P.nsw,P.nt);
C.Cl = zeros(P.nsw,P.nt); 
C.S  = zeros(P.nsw,P.nt); 
C.B  = zeros(P.nsw,P.nt); 
C.Al = zeros(P.nsw,P.nt); X.Al = zeros(P.nsw,P.nt); X.AlOH = zeros(P.nsw,P.nt);
C.Si = zeros(P.nsw,P.nt); 
C.Li = zeros(P.nsw,P.nt); X.Li = zeros(P.nsw,P.nt);
C.H  = zeros(P.nsw,P.nt); X.H  = zeros(P.nsw,P.nt);
C.HCO3 = zeros(P.nsw,P.nt);
C.C4 = zeros(P.nsw,P.nt);

%Build Calcite matrices
Calcite.k   = zeros(P.nsw,P.nt); 
Calcite.dk  = zeros(P.nsw,P.nt);
Calcite.SI  = zeros(P.nsw,P.nt);

%Boundary Conditions Fluid
F_bc.fw = zeros(P.nsw,1); F_bc.fw(1) = 1;

%Convert Ion boundary conditions from days to timesteps
for i = 1:P.t_end/P.dt; W_bc(i) = W_bc_days(ceil(i*P.dt)); end;

% %Boundary Conditions Ions (injection scheme)
% C_bc.Na   = zeros(1,P.nt);    C_bc.Na(1,1:P.pre)   = W.FW.Na;      C_bc.Na(1,P.pre+1:P.pre+P.slug)   = W.LSW.Na;     C_bc.Na(1,P.pre+P.slug+1:P.nt)   = W.SRP.Na;
% C_bc.K    = zeros(1,P.nt);    C_bc.K(1,1:P.pre)    = W.FW.K;       C_bc.K(1,P.pre+1:P.pre+P.slug)    = W.LSW.K;      C_bc.K(1,P.pre+P.slug+1:P.nt)    = W.SRP.K;
% C_bc.Ca   = zeros(1,P.nt);    C_bc.Ca(1,1:P.pre)   = W.FW.Ca;      C_bc.Ca(1,P.pre+1:P.pre+P.slug)   = W.LSW.Ca;     C_bc.Ca(1,P.pre+P.slug+1:P.nt)   = W.SRP.Ca; 
% C_bc.Mg   = zeros(1,P.nt);    C_bc.Mg(1,1:P.pre)   = W.FW.Mg;      C_bc.Mg(1,P.pre+1:P.pre+P.slug)   = W.LSW.Mg;     C_bc.Mg(1,P.pre+P.slug+1:P.nt)   = W.SRP.Mg;
% C_bc.Ba   = zeros(1,P.nt);    C_bc.Ba(1,1:P.pre)   = W.FW.Ba;      C_bc.Ba(1,P.pre+1:P.pre+P.slug)   = W.LSW.Ba;     C_bc.Ba(1,P.pre+P.slug+1:P.nt)   = W.SRP.Ba;
% C_bc.Sr   = zeros(1,P.nt);    C_bc.Sr(1,1:P.pre)   = W.FW.Sr;      C_bc.Sr(1,P.pre+1:P.pre+P.slug)   = W.LSW.Sr;     C_bc.Sr(1,P.pre+P.slug+1:P.nt)   = W.SRP.Sr;
% C_bc.Cl   = zeros(1,P.nt);    C_bc.Cl(1,1:P.pre)   = W.FW.Cl;      C_bc.Cl(1,P.pre+1:P.pre+P.slug)   = W.LSW.Cl;     C_bc.Cl(1,P.pre+P.slug+1:P.nt)   = W.SRP.Cl;
% C_bc.S    = zeros(1,P.nt);    C_bc.S(1,1:P.pre)    = W.FW.S;       C_bc.S(1,P.pre+1:P.pre+P.slug)    = W.LSW.S;      C_bc.S(1,P.pre+P.slug+1:P.nt)    = W.SRP.S;
% C_bc.B    = zeros(1,P.nt);    C_bc.B(1,1:P.pre)    = W.FW.B;       C_bc.B(1,P.pre+1:P.pre+P.slug)    = W.LSW.B;      C_bc.B(1,P.pre+P.slug+1:P.nt)    = W.SRP.B;
% C_bc.Al   = zeros(1,P.nt);    C_bc.Al(1,1:P.pre)   = W.FW.Al;      C_bc.Al(1,P.pre+1:P.pre+P.slug)   = W.LSW.Al;     C_bc.Al(1,P.pre+P.slug+1:P.nt)   = W.SRP.Al;
% C_bc.Si   = zeros(1,P.nt);    C_bc.Si(1,1:P.pre)   = W.FW.Si;      C_bc.Si(1,P.pre+1:P.pre+P.slug)   = W.LSW.Si;     C_bc.Si(1,P.pre+P.slug+1:P.nt)   = W.SRP.Si;
% C_bc.Li   = zeros(1,P.nt);    C_bc.Li(1,1:P.pre)   = W.FW.Li;      C_bc.Li(1,P.pre+1:P.pre+P.slug)   = W.LSW.Li;     C_bc.Li(1,P.pre+P.slug+1:P.nt)   = W.SRP.Li;
% C_bc.H    = zeros(1,P.nt);    C_bc.H(1,1:P.pre)    = W.FW.H;       C_bc.H(1,P.pre+1:P.pre+P.slug)    = W.LSW.H;      C_bc.H(1,P.pre+P.slug+1:P.nt)    = W.SRP.H;
% C_bc.HCO3 = zeros(1,P.nt);    C_bc.HCO3(1,1:P.pre) = W.FW.HCO3;    C_bc.HCO3(1,P.pre+1:P.pre+P.slug) = W.LSW.HCO3;   C_bc.HCO3(1,P.pre+P.slug+1:P.nt) = W.SRP.HCO3;
% C_bc.C4   = zeros(1,P.nt);    C_bc.C4(1,1:P.pre)   = W.FW.C4;      C_bc.C4(1,P.pre+1:P.pre+P.slug)   = W.LSW.C4;     C_bc.C4(1,P.pre+P.slug+1:P.nt)   = W.SRP.C4;

%Initial Conditions Fluid
F.Sw(:,1)   = F.sw_init;       
F.sor       = ones(P.nsw, P.nt) .* F.HS_sor;
F.nw        = ones(P.nsw, P.nt) .* F.HS_nw;           
F.no        = ones(P.nsw, P.nt) .* F.HS_no;
F.kroe      = ones(P.nsw, P.nt) .* F.HS_kroe;
F.krwe      = ones(P.nsw, P.nt) .* F.HS_krwe;

%Initial Conditions Ions (mol/kgw)
C.Na(:,1)   = W.FW.Na;
C.K(:,1)    = W.FW.K;
C.Ca(:,1)   = W.FW.Ca;
C.Mg(:,1)   = W.FW.Mg;
C.Ba(:,1)   = W.FW.Ba;
C.Sr(:,1)   = W.FW.Sr;
C.Cl(:,1)   = W.FW.Cl;
C.S(:,1)    = W.FW.S;
C.B(:,1)    = W.FW.B;
C.Al(:,1)   = W.FW.Al;
C.Si(:,1)   = W.FW.Si;
C.Li(:,1)   = W.FW.Li;
C.H(:,1)    = W.FW.H;
%C.HCO3(:,1) = W.FW.HCO3;
C.C4(:,1)   = W.FW.C4;

%Initial Conditions Exchanger (mol/kgw) (NaX = 0 => equilibriate exchanger for
%initial ions concentration)
X.Na(:,1)   = 0;            %Na
X.K(:,1)    = 0;            %K
X.Ca(:,1)   = 0;            %Ca
X.Mg(:,1)   = 0;            %Mg
X.Ba(:,1)   = 0;            %Ba
X.Sr(:,1)   = 0;            %Sr
X.Al(:,1)   = 0;            %Al
X.Li(:,1)   = 0;            %Li
X.H(:,1)    = 0;            %H

%Initial Conditions
Calcite.k(:,1)    = P.CalciteInitial;     %(mol/kgw)
Calcite.dk(:,1)   = 0;        %(-)  
Calcite.SI(:,1)   = 0;        %(-)

%Make list of fieldnames, to be used in simulation
P.fieldnamesC = fieldnames(C);
P.fieldnamesX = fieldnames(X);
P.fieldnamesCalcite = fieldnames(Calcite);


%K matrices used in vector calculation of buckley leverett
K_u = zeros(P.nsw,P.nsw);
K_u2 = zeros(P.nsw,P.nsw);
K_lw_1 = zeros(P.nsw,P.nsw);
K_lw_2 = zeros(P.nsw,P.nsw);
for l=1:P.nsw
    for m=1:P.nsw
        if l==m
            K_u(l,m) =1;
            K_u2(l,m) =3;
            K_lw_1(l,m) =0;
            K_lw_2(l,m) =-2;
        elseif m==l-1
            K_u(l,m)=-1;
            K_u2(l,m) =-4;
            K_lw_1(l,m) = -1;
            K_lw_2(l,m) = 1;
        elseif m==l-2            
            K_u2(l,m) =1;
        elseif m==l+1
            K_lw_1(l,m) = 1;
            K_lw_2(l,m) = 1;
        end
    end
end

%Concentration coundary conditions

C_bc.Na = zeros(P.nsw,P.nt); for n = 1:P.nt;  C_bc.Na(1,n)  =  W_bc(n).Na;    C_bc.Na(P.nsw,n)  = 0; end;
C_bc.K = zeros(P.nsw,P.nt); for n = 1:P.nt;    C_bc.K(1,n)   =  W_bc(n).K;     C_bc.K(P.nsw,n)   = 0;end;
C_bc.Ca = zeros(P.nsw,P.nt); for n = 1:P.nt;   C_bc.Ca(1,n)  =  W_bc(n).Ca;    C_bc.Ca(P.nsw,n)  = 0;end;
C_bc.Mg = zeros(P.nsw,P.nt); for n = 1:P.nt;   C_bc.Mg(1,n)  =  W_bc(n).Mg;    C_bc.Mg(P.nsw,n)  = 0;end;
C_bc.Ba = zeros(P.nsw,P.nt); for n = 1:P.nt;   C_bc.Ba(1,n)  =  W_bc(n).Ba;    C_bc.Ba(P.nsw,n)  = 0;end;
C_bc.Sr = zeros(P.nsw,P.nt); for n = 1:P.nt;   C_bc.Sr(1,n)  =  W_bc(n).Sr;    C_bc.Sr(P.nsw,n)  = 0;end;
C_bc.Cl = zeros(P.nsw,P.nt); for n = 1:P.nt;   C_bc.Cl(1,n)  =  W_bc(n).Cl;    C_bc.Cl(P.nsw,n)  = 0;end;
C_bc.S = zeros(P.nsw,P.nt);  for n = 1:P.nt;   C_bc.S(1,n)   =  W_bc(n).S;     C_bc.S(P.nsw,n)   = 0;end;
C_bc.B = zeros(P.nsw,P.nt);  for n = 1:P.nt;   C_bc.B(1,n)   =  W_bc(n).B;     C_bc.B(P.nsw,n)   = 0;end;
C_bc.Al = zeros(P.nsw,P.nt);  for n = 1:P.nt;  C_bc.Al(1,n)  =  W_bc(n).Al;    C_bc.Al(P.nsw,n)  = 0;end;
C_bc.Si = zeros(P.nsw,P.nt); for n = 1:P.nt;   C_bc.Si(1,n)  =  W_bc(n).Si;    C_bc.Si(P.nsw,n)  = 0;end;
C_bc.Li = zeros(P.nsw,P.nt);  for n = 1:P.nt;  C_bc.Li(1,n)  =  W_bc(n).Li;    C_bc.Li(P.nsw,n)  = 0;end;
C_bc.H = zeros(P.nsw,P.nt);  for n = 1:P.nt;   C_bc.H(1,n)   =  W_bc(n).H;     C_bc.H(P.nsw,n)   = 0;end;
C_bc.C4 = zeros(P.nsw,P.nt);  for n = 1:P.nt;  C_bc.C4(1,n)  =  W_bc(n).C4;    C_bc.C4(P.nsw,n)  = 0;end;
%C_bc.HCO3 = zeros(P.nsw,P.nt);  for n = 1:P.nt;   C_bc.HCO3(1,n)=  W_bc(n).HCO3;  C_bc.HCO3(P.nsw,n)= 0;end;

%Define matrices for use in limiters. One matrix for every type of ion.
 for loopIndex = 1:numel(P.fieldnamesC)
     P.r.(P.fieldnamesC{loopIndex}) = zeros(P.nsw,P.nt);
     P.psi.(P.fieldnamesC{loopIndex}) = zeros(P.nsw,P.nt);     
 end   


%Clear n, otherwise simulation doesn't start.
clear n;

