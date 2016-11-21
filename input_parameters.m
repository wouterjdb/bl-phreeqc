%The input parameters in this file have been defaulted to potentially unrealistic values.
%Make sure to check all of them!

P.porosity      = 0.2;             %Porosity [-]
P.ut            = 0.5*8.2192*P.porosity;%Darcy velocity [m / day] (=v*phi=200 m/y * porosity)
P.nsw           = 100;              %number of gridpoints
P.L             = 1000;              %Reservoir simultion length [m]
P.t_end         = 7300;             %End time [days]
P.dt            = 1;                %Time step size [days] (Always check stability!)
P.dx            = P.L/P.nsw;        %Length step size [m]
P.T             = 90;              %Reservoir temperature [deg C]
P.db = 'C:\Program Files (x86)\USGS\IPhreeqcCOM 2.18.5570\database\phreeqc.dat';
P.ExchangerTot  = 0.30;             %Total amount of Exchanger (mol/kgw) per grid cell
P.CalciteInitial= 0.70;             %Initial calcite (mol/kgw) per grid cell
P.logP_CO2      = 0.2;            %Log(Partial pressure of CO2 (atm))
%P.pre           = 1;                %Amount of days pre flush before (LSW) slug
%P.slug          = 5840;             %Amount of days (LSW) slug injection
P.C_scheme      = 'upwind_2_limiter';         %Define numerical scheme to be used for ion contration calculation. (upwind_1 upwind_2_limiter)
P.Limiter       = 'sweby';          %Define limiter to be used in upwind_2_limiter (superbee, minmod,sweby)
    P.bet = 1.0;                    %sweby tuning parameters 1<P.bet<2. 1 is most disperion = minmod, 2 is least disperion = superbee.         
P.EulerOrder    = 2;                %Euler fordward = 1, Euler Modified (Runge Kutta 2) = 2.
P.epsSaveLocation = 'F:\Statoil Documents\MSc Thesis\Thesis\figures\'; %Some figures can be saved automatic as eps file in this location.
P.epsSave         = 'off';           %Default eps save option usage state

%Fluid parameters
F.visco_w       = 1.0e-3;           %Viscosity of water [Pa.s]
F.visco_o       = 2.0e-3;           %Viscosity of oil [Pa.s]
F.swc           = 0.2;             %Connate water saturaion [-]
F.sw_init       = 0.2;              %Initial water saturation

%Relperm parameters, High sal
F.HS_nw            = 2;                %Corey-coefficient, water [-]
F.HS_no            = 6;                %Corey-coefficient, oil [-]
F.HS_sor           = 0.2;              %Residual oil saturation [-]
F.HS_kroe          = 1;                %Oil endpoint relative permeability [-]
F.HS_krwe          = 0.45;             %Water end-point relative permeability [-]

%Relperm parameters, Low sal
F.LS_nw            = 2;                %Corey-coefficient, water [-]
F.LS_no            = 5;                %Corey-coefficient, oil [-]
F.LS_sor           = 0.15;             %Residual oil saturation [-]
F.LS_kroe          = 1;                %Oil endpoint relative permeability [-]
F.LS_krwe          = 0.25;             %Water end-point relative permeability [-]
F.sal_threshold    = 3000;             %Salinity threshold (ppm) for switching to low salinity rel perm


%Simulator switches: define what to use in the model
P.usePhreeqc    = false;                 %Switch determining the use of geochemical interactions in the simulation (false is obviously much faster)
    P.UseSmartSim   = false;             %Ignore geochemical simulation for non invaded zone (faster calculation. Always runs a full simulation to check!)
    P.UseKinetics 	= true;            %Specify wheter kinetics or equilibrium phases for calcite should be used
P.UseRelpermAsFunctionOfChem = true;    %Switch to set the relative permeability as a function of chemistry (salinity threshold?)



%Add Water Types, Ion concentration (mol/kgw, or assume 1 L=1 kg for simplicity)
%Formation Water                %Low Salinity Injection Water       %Sulphate reduced sea water
%Defaulted with unrealistic values; replace with realistic concentrations.
W.FW.Na    = 1e-3;      W.LSW.Na    = 1e-3;          W.SRP.Na    = 1e-3;          %Na
W.FW.K     = 1e-3;      W.LSW.K     = 0;             W.SRP.K     = 1e-3;          %K
W.FW.Ca    = 1e-3;      W.LSW.Ca    = 0;             W.SRP.Ca    = 1e-3;          %Ca
W.FW.Mg    = 1e-3;      W.LSW.Mg    = 0;             W.SRP.Mg    = 1e-3;          %Mg
W.FW.Ba    = 1e-3;      W.LSW.Ba    = 0;             W.SRP.Ba    = 0;             %Ba
W.FW.Sr    = 1e-3;      W.LSW.Sr    = 0;             W.SRP.Sr    = 1e-3;          %Sr
W.FW.Cl    = 1e-3;      W.LSW.Cl    = 1e-3;          W.SRP.Cl    = 1e-3;          %Cl
W.FW.S     = 1e-3;      W.LSW.S     = 0;             W.SRP.S     = 1e-3;          %S
W.FW.B     = 1e-3;      W.LSW.B     = 0;             W.SRP.B     = 0;             %B
W.FW.Al    = 1e-3;      W.LSW.Al    = 0;             W.SRP.Al    = 0;             %Al
W.FW.Si    = 1e-3;      W.LSW.Si    = 0;             W.SRP.Si    = 0;             %Si
W.FW.Li    = 1e-3;      W.LSW.Li    = 0;             W.SRP.Li    = 0;             %Li
W.FW.H     = 1e-3;      W.LSW.H     = 1e-3;          W.SRP.H     = 1e-3;          %H
W.FW.C4    = 1e-3;      W.LSW.C4    = 1e-3;          W.SRP.C4    = 1e-3;          %C4


%Define injection schedule for all days!
W_bc_days(1:100)                = W.FW; %(make sure initial exchanger composition is for FW)
W_bc_days(101:P.t_end)          = W.LSW;
%W_bc_days(1607:P.t_end)          = W.FW;
%W_bc_days(1461:P.t_end)         = W.LSW;
%W_bc_days(1001:2000)            = W.LSW;
%W_bc_days(2001:P.t_end)         = W.SRP;

%SRP_start = 1461;
%for i = 31:31 %Every year month two days of SRP injection from day SRP_start
%    W_bc_days(SRP_start+i:31:P.t_end) = W.SRP;
%end
%for i = 352:365 %Every year two weeks of SRP injection
%   W_bc_days(SRP_start+i:365:P.t_end) = W.SRP;
%end


%Plotting properties
P.h = 'PVs'; %Default horizontal axis type (days or PVs)