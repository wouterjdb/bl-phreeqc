%Spatial 1st order upwind numerical scheme
C.Na(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Na(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.Na(:,n) .* F.fw(:,n))  - C_bc.Na(:,n)));
C.K(:,n+1)      = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.K(:,n)      - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.K(:,n) .* F.fw(:,n))   - C_bc.K(:,n)));
C.Ca(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Ca(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.Ca(:,n) .* F.fw(:,n))  - C_bc.Ca(:,n)));
C.Mg(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Mg(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.Mg(:,n) .* F.fw(:,n))  - C_bc.Mg(:,n)));
C.Ba(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Ba(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.Ba(:,n) .* F.fw(:,n))  - C_bc.Ba(:,n)));
C.Sr(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Sr(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.Sr(:,n) .* F.fw(:,n))  - C_bc.Sr(:,n)));
C.Cl(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Cl(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.Cl(:,n) .* F.fw(:,n))  - C_bc.Cl(:,n)));
C.S(:,n+1)      = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.S(:,n)      - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.S(:,n) .* F.fw(:,n))   - C_bc.S(:,n)));
C.B(:,n+1)      = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.B(:,n)      - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.B(:,n) .* F.fw(:,n))   - C_bc.B(:,n)));
C.Al(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Al(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.Al(:,n) .* F.fw(:,n))  - C_bc.Al(:,n)));
C.Si(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Si(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.Si(:,n) .* F.fw(:,n))  - C_bc.Si(:,n)));
C.Li(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Li(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.Li(:,n) .* F.fw(:,n))  - C_bc.Li(:,n)));
C.H(:,n+1)      = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.H(:,n)      - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.H(:,n) .* F.fw(:,n))   - C_bc.H(:,n)));
C.C4(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.C4(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.C4(:,n) .* F.fw(:,n))  - C_bc.C4(:,n)));
C.HCO3(:,n+1)   = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.HCO3(:,n)   - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * (C.HCO3(:,n) .* F.fw(:,n))- C_bc.HCO3(:,n)));

%Is Euler modified to be used?
if P.EulerOrder==2
    C.Na(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Na(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.Na(:,n) .* F.fw(:,n)-C_bc.Na(:,n)+K_u * C.Na(:,n+1) .* F.fw(:,n+1)-C_bc.Na(:,n+1))./2  ));
    C.K(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.K(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.K(:,n) .* F.fw(:,n)-C_bc.K(:,n)+K_u * C.K(:,n+1) .* F.fw(:,n+1)-C_bc.K(:,n+1))./2  ));
    C.Ca(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Ca(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.Ca(:,n) .* F.fw(:,n)-C_bc.Ca(:,n)+K_u * C.Ca(:,n+1) .* F.fw(:,n+1)-C_bc.Ca(:,n+1))./2  ));
    C.Mg(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Mg(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.Mg(:,n) .* F.fw(:,n)-C_bc.Mg(:,n)+K_u * C.Mg(:,n+1) .* F.fw(:,n+1)-C_bc.Mg(:,n+1))./2  ));
    C.Ba(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Ba(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.Ba(:,n) .* F.fw(:,n)-C_bc.Ba(:,n)+K_u * C.Ba(:,n+1) .* F.fw(:,n+1)-C_bc.Ba(:,n+1))./2  ));    
    C.Sr(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Sr(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.Sr(:,n) .* F.fw(:,n)-C_bc.Sr(:,n)+K_u * C.Sr(:,n+1) .* F.fw(:,n+1)-C_bc.Sr(:,n+1))./2  ));
    C.Cl(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Cl(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.Cl(:,n) .* F.fw(:,n)-C_bc.Cl(:,n)+K_u * C.Cl(:,n+1) .* F.fw(:,n+1)-C_bc.Cl(:,n+1))./2  ));
    C.S(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.S(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.S(:,n) .* F.fw(:,n)-C_bc.S(:,n)+K_u * C.S(:,n+1) .* F.fw(:,n+1)-C_bc.S(:,n+1))./2  ));
    C.B(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.B(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.B(:,n) .* F.fw(:,n)-C_bc.B(:,n)+K_u * C.B(:,n+1) .* F.fw(:,n+1)-C_bc.B(:,n+1))./2  ));
    C.Al(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Al(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.Al(:,n) .* F.fw(:,n)-C_bc.Al(:,n)+K_u * C.Al(:,n+1) .* F.fw(:,n+1)-C_bc.Al(:,n+1))./2  ));
    C.Si(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Si(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.Si(:,n) .* F.fw(:,n)-C_bc.Si(:,n)+K_u * C.Si(:,n+1) .* F.fw(:,n+1)-C_bc.Si(:,n+1))./2  ));
    C.Li(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Li(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.Li(:,n) .* F.fw(:,n)-C_bc.Li(:,n)+K_u * C.Li(:,n+1) .* F.fw(:,n+1)-C_bc.Li(:,n+1))./2  ));
    C.H(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.H(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.H(:,n) .* F.fw(:,n)-C_bc.H(:,n)+K_u * C.H(:,n+1) .* F.fw(:,n+1)-C_bc.H(:,n+1))./2  ));
    C.C4(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.C4(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.C4(:,n) .* F.fw(:,n)-C_bc.C4(:,n)+K_u * C.C4(:,n+1) .* F.fw(:,n+1)-C_bc.C4(:,n+1))./2  ));
    C.HCO3(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.HCO3(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *((K_u *C.HCO3(:,n) .* F.fw(:,n)-C_bc.HCO3(:,n)+K_u * C.HCO3(:,n+1) .* F.fw(:,n+1)-C_bc.HCO3(:,n+1))./2  ));    
end

% %Is Euler modified to be used?
% if P.EulerOrder==2
%     C.Na(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Na(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.Na(:,n) .* F.fw(:,n)+C.Na(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.Na(:,n)));
%     C.K(:,n+1)      = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.K(:,n)      - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.K(:,n) .* F.fw(:,n) +C.K(:,n+1) .* F.fw(:,n+1))./2)   - C_bc.K(:,n)));
%     C.Ca(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Ca(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.Ca(:,n) .* F.fw(:,n)+C.Ca(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.Ca(:,n)));
%     C.Mg(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Mg(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.Mg(:,n) .* F.fw(:,n)+C.Mg(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.Mg(:,n)));
%     C.Ba(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Ba(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.Ba(:,n) .* F.fw(:,n)+C.Ba(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.Ba(:,n)));
%     C.Sr(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Sr(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.Sr(:,n) .* F.fw(:,n)+C.Sr(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.Sr(:,n)));
%     C.Cl(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Cl(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.Cl(:,n) .* F.fw(:,n)+C.Cl(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.Cl(:,n)));
%     C.S(:,n+1)      = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.S(:,n)      - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.S(:,n) .* F.fw(:,n)+C.S(:,n+1) .* F.fw(:,n+1))./2)   - C_bc.S(:,n)));
%     C.B(:,n+1)      = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.B(:,n)      - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.B(:,n) .* F.fw(:,n)+C.B(:,n+1) .* F.fw(:,n+1))./2)   - C_bc.B(:,n)));
%     C.Al(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Al(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.Al(:,n) .* F.fw(:,n)+C.Al(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.Al(:,n)));
%     C.Si(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Si(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.Si(:,n) .* F.fw(:,n)+C.Si(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.Si(:,n)));
%     C.Li(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.Li(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.Li(:,n) .* F.fw(:,n)+C.Li(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.Li(:,n)));
%     C.H(:,n+1)      = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.H(:,n)      - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.H(:,n) .* F.fw(:,n)+C.H(:,n+1) .* F.fw(:,n+1))./2)   - C_bc.H(:,n)));
%     C.C4(:,n+1)     = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.C4(:,n)     - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.C4(:,n) .* F.fw(:,n)+C.C4(:,n+1) .* F.fw(:,n+1))./2)  - C_bc.C4(:,n)));
%     C.HCO3(:,n+1)   = (1./F.Sw(:,n+1)) .* (F.Sw(:,n).*C.HCO3(:,n)   - ((P.ut * P.dt) / (P.porosity * P.dx)) *(K_u * ((C.HCO3(:,n) .* F.fw(:,n)+C.HCO3(:,n+1) .* F.fw(:,n+1))./2)- C_bc.HCO3(:,n)));
% end