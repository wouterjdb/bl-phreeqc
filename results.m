while 1
    
        clc;
        disp('1:  Plot Buckley-Leverett profile through time')
        disp('2:  Plot oil production')
        disp('3:  Plot Calcite data for grid cell x')    
        disp('4:  Plot ion concentration & exchanger composition for grid cell x')    
        disp('5:  Plot pH grid cell x')    
        disp('6:  Plot relative permeability and fractional flow')            
        disp('7:  Plot salinity profile through time')              
        disp('8:  Plot pH profile through time')
        disp('9:  Plot Calcite profile through time')
        disp('10: Plot limiter function through time')        
        disp('11: Compare Analytical and Numerical')
        disp('12: Plot water cut')                
        disp('13: Build Summary Video') 
        
        if n == P.nt-1 
            disp('r:  Restart simulation from start point');    
        else
            disp(['r:  Restart simulation from break point (' num2str(n*P.dt) ' days)']);
        end        
        disp(['h:  Change horizontal axis beteween days and injected pore volumes [Current: ' P.h ']'])
        disp(['e:  Change state on save file as eps option [Current: ' P.epsSave ']'])
        disp('c:  Close image windows')
        disp('q:  Quit')
        reply = input('Choose an option: ', 's');
        if isempty(reply)

        elseif strcmp(reply,'1')


            reply = str2double(input('Incremental time steps: ', 's'));
            rate = str2double(input('Create movie? Frame rate (0=No movie): ', 's'));
            start_t = str2double(input('Start from day [1]: ', 's'));
            disp('Plotting...')

            if rate > 0 
                % Preallocate the struct array for the struct returned by getframe
                writerObj = VideoWriter('newfile.avi');
                writerObj.FrameRate = rate;
                open(writerObj);
                figure1 = figure('Color',[1 1 1],'Position',[0 0 800 600]);
            else
                figure1 = figure();
            end




            if isempty(start_t); start_t =1; end;

            for i = start_t/P.dt:reply:P.nt
                plot(P.x,F.Sw(:,i),'k-',P.x,1-F.sor(:,i),'k--',P.x,C.Na(:,i),'g-',P.x,X.Na(:,i),'g--',P.x,C.Ca(:,i),'r-',P.x,2*X.Ca(:,i),'r--',P.x,C.Mg(:,i),'b-',P.x,2*X.Mg(:,i),'b--',P.x,F.pH(:,i),'y-');
set(gca,'YGrid','on','XGrid','on','YScale','lin')
                ylabel('S_w (-), Concentration (mol/kgw), pH (-)')
                xlabel('x (m)')   
                legend('S_w','1-S_{or}','[Na]','[NaX]','[Ca]','[CaX_2]','[Mg]','[MgX_2]','pH')    
                ylim([1e-5 1]);
                xlim([0 800]);
                title(['Day = ' num2str(round(i*P.dt)) '; PV Injected =' num2str((i*P.dt*P.ut/P.porosity)/P.L)]);

                if rate > 0 
                    movie_frame = getframe(figure1);
                    writeVideo(writerObj,movie_frame);
                end

                drawnow()
           %pause(0.1)
            end

            if rate > 0 
                close(writerObj);
            end



            clear Mov rate i movie_frame ans figure1 writerObj
            disp('Done')
            pause(1)

        elseif strcmp(reply,'2')

            disp('Plotting...')        

            %Oil Production
            %N_gridblocks = ((ones(nsw,nt) - sor - swc) - (ones(nsw,nt) - Sw - sor))/nsw;% / (nt * nsw);

            %N_gridblocks = ((ones(P.nsw,P.nt) .* (F.Sw - F.swc)) ./ (ones(P.nsw,P.nt).*(1-F.sor-F.swc)))/P.nsw;

            N_gridblocks = F.Sw -F.swc;
            N_cumulative = sum(N_gridblocks,1)/P.nsw;

            figure;
            hold on;
            
            if strcmp(P.h,'days'); ha=P.t; else ha=P.PV; end;
            plot(ha,N_cumulative)
            
            
            if strcmp(P.h,'days'); xlabel('t (days)'); else xlabel('PV'); end;
            ylabel('Fraction of STOIIP produced')
            legend('Dimensionless Oil Production')
            ylim([0 1]);
            hold off;

            %Call epsSave
            epsSave
            
            clear ha
            disp('Done')
            pause(1)

        elseif strcmp(reply,'3')

            reply = str2double(input(['For which grid cell [1-' num2str(P.nsw) '] do you want to plot the calcite data? '], 's'));       

            if strcmp(P.h,'days'); ha=P.t; else ha=P.PV; end;
            
            disp('Plotting...')        

            figure;
            plot(ha,Calcite.k(reply,:));
            ylim([0 ceil(max(Calcite.k(reply,:)))])
            
            if strcmp(P.h,'days'); xlabel('t (days)'); else xlabel('PV'); end;
            ylabel('Calcite (mol)')
            title(['Grid cell #' num2str(reply)])
            
            %Call epsSave
            epsSave
            
            clear ha
            disp('Done')
            pause(1)        

        elseif strcmp(reply,'4')

            reply = str2double(input(['For which grid cell [1-' num2str(P.nsw) '] do you want to plot the ion concentration & exchanger composition? '], 's'));       

            
            
            disp('Plotting...')        

            figure1 = figure();

            %Set axis properties. Enable gridlines.
            set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;1 1 0; 0 1 1; 1 0 1; 0 0 0],...
                'DefaultAxesLineStyleOrder','-|--|:','defaultlinelinewidth',2)
            set(gca,'YGrid','on','XGrid','on','YScale','log')
            hold on;
            %xlim([0 4]);
            ylim([10^-4.5 10^0]);
            
            if strcmp(P.h,'days'); ha=P.t; else ha=P.PV; end;
            plot(ha, C.Na(reply,:),'g-',ha, X.Na(reply,:),'g--',ha, C.Ca(reply,:),'r-',ha, 2*X.Ca(reply,:),'r--',ha, C.Mg(reply,:),'b-',ha, 2*X.Mg(reply,:),'b--',ha, -log10(C.H(reply,:)),'y-')
            
            if strcmp(P.h,'days'); xlabel('t (days)'); else xlabel('PV'); end;
            ylabel('Concentration / Exchanger composition (mol/kgw)')
            legend('[Na^{+}]','[NaX]','[Ca^{2+}]','[CaX_2]','[Mg^{2+}]','[MgX_2]','pH')
            
            hold off;
            
            %Call epsSave
            epsSave
            
            clear ha
            disp('Done')
            pause(1)        




        elseif strcmp(reply,'5')

            reply = str2double(input(['For which grid cell [1-' num2str(P.nsw) '] do you want to plot the pH? '], 's'));       

            disp('Plotting...')        

            figure1 = figure();

            %Set axis properties. Enable gridlines.
            set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;1 1 0; 0 1 1; 1 0 1; 0 0 0],...
                'DefaultAxesLineStyleOrder','-|--|:','defaultlinelinewidth',2)
            set(gca,'YGrid','on','XGrid','on','YScale','lin')
            hold on;
            %xlim([0 4]);
            ylim([3 8]);
            
            if strcmp(P.h,'days'); ha=P.t; else ha=P.PV; end;
            plot(ha, -log10(C.H(reply,:)),'y-');
            
            if strcmp(P.h,'days'); xlabel('t (days)'); else xlabel('PV'); end;
            ylabel('pH (-)');
            legend('pH');
            hold off;
            
            %Call epsSave
            epsSave
            
            clear ha
            disp('Done');
            pause(1)        
            
    elseif strcmp(reply,'6')
        
        S_w        = 0:0.001:1;
        S_wn_HS    = (S_w - F.swc) / (1-F.swc-F.HS_sor);
        S_wn_LS    = (S_w - F.swc) / (1-F.swc-F.LS_sor);
        
        k_ro_HS      = (1-S_wn_HS).^F.HS_no;
        k_rw_HS      = F.HS_krwe*S_wn_HS.^F.HS_nw;
        
        k_ro_LS      = (1-S_wn_LS).^F.LS_no;
        k_rw_LS      = F.LS_krwe*S_wn_LS.^F.LS_nw;
               
        
        for i=1:numel(S_w)
            if S_w(i) < F.swc; k_ro_HS(i) = 1; k_ro_LS(i) = 1; end;
            if S_w(i) < F.swc; k_rw_HS(i) = 0; k_rw_LS(i) = 0; end;
            
            if S_w(i) > 1-F.HS_sor; k_ro_HS(i) = 0; end;
            if S_w(i) > 1-F.LS_sor; k_ro_LS(i) = 0; end;
            
            if S_w(i) > 1-F.HS_sor; k_rw_HS(i) = F.HS_krwe; end;
            if S_w(i) > 1-F.LS_sor; k_rw_LS(i) = F.LS_krwe; end;
            if S_w(i) > 1-F.HS_sor; k_ro_HS(i) = 0; end;
            if S_w(i) > 1-F.LS_sor; k_ro_LS(i) = 0; end;
        end
        
       %Calculate fractional flow based on relative permeability
       mob_w_HS = k_rw_HS/F.visco_w;
       mob_o_HS = k_ro_HS/F.visco_o; 
       fw_HS    = mob_w_HS./(mob_w_HS+mob_o_HS);   
       mob_w_LS = k_rw_LS/F.visco_w;
       mob_o_LS = k_ro_LS/F.visco_o; 
       fw_LS    = mob_w_LS./(mob_w_LS+mob_o_LS);   
       
       %Plot fractional flow
       figure1= figure('Position',[0 0 320 416]);
       set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;1 1 0; 0 1 1; 1 0 1; 0 0 0],...
        'DefaultAxesLineStyleOrder','-|--|:','defaultlinelinewidth',2)
        set(gca,'YGrid','on','XGrid','on')



       hold on;
           plot(S_w,fw_HS,'b',S_w,fw_LS,'r--')
           xlabel('S_w (-)')
           ylabel('f_w (-)')
           legend('HS','LS','Location','NorthOutside','Orientation','horizontal') 
           

       hold off;
       legend('boxoff')
       
       % Resize the axes in order to prevent it from shrinking.
       
       %Call epsSave
       epsSave
            
       %Calcute df/dSw
       df_dsw_HS = diff(fw_HS)./diff(S_w);
       df_dsw_LS = diff(fw_LS)./diff(S_w);
              
       %Plot df/dsw
       figure('Position',[0 0 320 416]);
       set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;1 1 0; 0 1 1; 1 0 1; 0 0 0],...
        'DefaultAxesLineStyleOrder','-|--|:','defaultlinelinewidth',2)
        set(gca,'YGrid','on','XGrid','on')
        
       hold on;
           plot(S_w(2:numel(S_w)),df_dsw_HS,'b',S_w(2:numel(S_w)),df_dsw_LS,'r--')
           line([0 1],[max(max(df_dsw_HS,df_dsw_LS)) max(max(df_dsw_HS,df_dsw_LS))],'LineStyle','-.','Color','k')           
           xlabel('S_w (-)')
           ylabel('df_w / dS_w (-)')             
           legend('HS','LS','minimum','Location','NorthOutside','Orientation','horizontal') 
          

       hold off;       
        legend('boxoff')
       
       %Call epsSave
       epsSave
            
            
%         figure;       
%         
%         hold on;
%         
%         plot(S_w,k_ro_HS,'r-')
%         plot(S_w,k_rw_HS,'b-')
%         plot(S_w,k_ro_LS,'r--')
%         plot(S_w,k_rw_LS,'b--')
%         
%         xlim([0 1]);
%         ylim([0 1]);
%         
%         ylabel('Relative permeability (-)');
%         xlabel('S_w (-)');
%         
%         legend('k_{ro}^{HS}','k_{rw}^{HS}','k_{ro}^{LS}','k_{ro}^{LS}')
%         
%         hold off;
                       
    
       %Plot relperm
       figure1 = figure('Position',[0 0 320 416]);
       %set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;1 1 0; 0 1 1; 1 0 1; 0 0 0],...
       % 'DefaultAxesLineStyleOrder','-|--|:','defaultlinelinewidth',2)
       % set(gca,'YGrid','on','XGrid','on')
        
        
% Create axes
axes1 = axes('Parent',figure1,'YTick',[0 0.2 0.4 0.6 0.8 1],'YGrid','on',...
    'XGrid','on',...
    'Position',[0.17007481296758 0.1 0.68 0.84]); %r b

hold(axes1,'all');

        
        [ax,h1,h2] = plotyy(S_w,k_ro_HS,S_w,k_ro_LS);


        set(ax(1),'ylim',[0 1])
        set(ax(2),'ylim',[0 1])
        set(ax(1),'xlim',[0 1])
        set(ax(2),'xlim',[0 1])

        %set(ax(2),'YTick',[]) % Remove ticks of axis 2 (leaves right-hand ticks of axis 1)
        set(ax(1),'Box','off') % Turn off box of axis 1, which removes its right-hand 
        %set(ax(1),'YTick',[1e-4 1e-3 1e-2 1e-1 1])
        %set(ax(2),'YTick',[4 5 6 7 8])
        %set(ax(1),'XTick',[-1 0 1 2 3 4])
        set(ax(2),'XTick',[])
        set(ax(1),'XGrid','on')
        set(ax(1),'YGrid','on')

        set(ax(1),'XColor','k','YColor','k')
        set(ax(2),'XColor','k','YColor','k')

        set(h2,'LineStyle','--')
        set(h2,'Color','r')
        set(h2,'LineWidth',2)

        set(h1,'LineStyle','-')
        set(h1,'Color','r')
        set(h1,'LineWidth',2)


        y1label= get(ax(1),'ylabel');  % name the second axis y-label 
        set(y1label,'String','k_{ro} (-)')%
        y2label= get(ax(2),'ylabel');  % name the second axis y-label 
        set(y2label,'String','k_{rw} (-)')%


        hold(ax(1),'on')


        h4=plot(S_w,k_rw_HS,'b-',S_w,k_rw_LS,'b--')        

        legend([h1 h2 h4(1) h4(2)],'k_{ro}^{HS}','k_{ro}^{LS}','k_{rw}^{HS}','k_{rw}^{LS}','Location','NorthOutside','Orientation','horizontal') 
 


        legend('boxoff')

        xlabel('S_w (-)')

        hold off;
        
        %Call epsSave
        epsSave
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       figure('Position',[0 0 320 416]);
        
        set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;1 1 0; 0 1 1; 1 0 1; 0 0 0],...
'DefaultAxesLineStyleOrder','-|--|:','defaultlinelinewidth',2)
set(gca,'YGrid','on','XGrid','on','YTick',[0 0.5 1 1.5 2],'XTick',[0 0.2 0.4 0.6 0.8 1])

        hold on;

        plot(S_w,S_w./fw_HS,'b-',S_w,S_w./fw_LS,'r--')

        legend('HS','LS','Location','NorthOutside','Orientation','horizontal')
        legend('boxoff')

        ylabel('S_w / f_w (-)')
        xlabel('S_w (-)')
        
        line([0 1],[min(min(S_w./fw_HS,S_w./fw_LS)) min(min(S_w./fw_HS,S_w./fw_LS))],'LineStyle','-.','Color','k')
        
        ylim([0 2]);
        xlim([0 1]);
        

        hold off;

        
        
        
        %Call epsSave
        epsSave

        

        clear S_w S_wn_HS S_wn_LS k_ro_HS k_rw_HS k_ro_LS k_rw_LS mob_w_HS mob_o_HS fw_HS mob_w_LS mob_o_LS fw_LS
        
 elseif strcmp(reply,'7')


            reply = str2double(input('Incremental time steps: ', 's'));
            rate = str2double(input('Create movie? Frame rate (0=No movie): ', 's'));
            start_t = str2double(input('Start from day [1]: ', 's'));
            disp('Plotting...')

            if rate > 0 
                % Preallocate the struct array for the struct returned by getframe
                writerObj = VideoWriter('newfile.avi');
                writerObj.FrameRate = rate;
                open(writerObj);
                figure1 = figure('Color',[1 1 1],'Position',[0 0 800 600]);
            else
                figure1 = figure();
            end



            if isempty(start_t); start_t =1; end;


            for i = start_t/P.dt:reply:P.nt
                                
                plot(P.x,F.Salinity(:,i))
                line([0 P.L],[F.sal_threshold F.sal_threshold],'Color','k','LineStyle','--')
                set(gca,'YGrid','on','XGrid','on','YScale','log')
                ylabel('Salinity (ppm)')
                xlabel('x (m)')   
                legend('Salinity','Salinity Threshold')    
                ylim([100 100000]);
                xlim([0 800]);
                title(['Day = ' num2str(round(i*P.dt)) '; PV Injected =' num2str((i*P.dt*P.ut/P.porosity)/P.L)]);

                if rate > 0 
                    movie_frame = getframe(figure1);
                    writeVideo(writerObj,movie_frame);
                end

                drawnow()
           %pause(0.1)
            end

            if rate > 0 
                close(writerObj);
            end



            clear Mov rate i movie_frame ans figure1 writerObj
            disp('Done')
            pause(1)

 elseif strcmp(reply,'8')


            reply = str2double(input('Incremental time steps: ', 's'));
            rate = str2double(input('Create movie? Frame rate (0=No movie): ', 's'));
            start_t = str2double(input('Start from day [1]: ', 's'));
            disp('Plotting...')

            if rate > 0 
                % Preallocate the struct array for the struct returned by getframe
                writerObj = VideoWriter('newfile.avi');
                writerObj.FrameRate = rate;
                open(writerObj);
                figure1 = figure('Color',[1 1 1],'Position',[0 0 800 600]);
            else
                figure1 = figure();
            end



            if isempty(start_t); start_t =1; end;


            for i = start_t/P.dt:reply:P.nt
                                
                plot(P.x,F.pH(:,i))
                line([0 P.L],[F.pH(1,1) F.pH(1,1)],'Color','k','LineStyle','--')
                set(gca,'YGrid','on','XGrid','on','YScale','lin')
                ylabel('pH (-)')
                xlabel('x (m)')   
                legend('pH','Initial pH')    
                ylim([3 10]);
                xlim([0 800]);
                title(['Day = ' num2str(round(i*P.dt)) '; PV Injected =' num2str((i*P.dt*P.ut/P.porosity)/P.L)]);

                if rate > 0 
                    movie_frame = getframe(figure1);
                    writeVideo(writerObj,movie_frame);
                end

                drawnow()
           %pause(0.1)
            end

            if rate > 0 
                close(writerObj);
            end



            clear Mov rate i movie_frame ans figure1 writerObj
            disp('Done')
            pause(1)
 elseif strcmp(reply,'9')


            reply = str2double(input('Incremental time steps: ', 's'));
            rate = str2double(input('Create movie? Frame rate (0=No movie): ', 's'));
            start_t = str2double(input('Start from day [1]: ', 's'));
            disp('Plotting...')

            if rate > 0 
                % Preallocate the struct array for the struct returned by getframe
                writerObj = VideoWriter('newfile.avi');
                writerObj.FrameRate = rate;
                open(writerObj);
                figure1 = figure('Color',[1 1 1],'Position',[0 0 800 600]);
            else
                figure1 = figure();
            end


            if isempty(start_t); start_t =1; end;



            for i = start_t/P.dt:reply:P.nt
                                
                plot(P.x,Calcite.k(:,i))
                line([0 P.L],[Calcite.k(1,1) Calcite.k(1,1)],'Color','k','LineStyle','--')
                set(gca,'YGrid','on','XGrid','on','YScale','lin')
                ylabel('Calcite (mol/kgw)')
                xlabel('x (m)')   
                legend('Calcite','Initial Calcite')    
                ylim([0 1]);
                xlim([0 800]);
                title(['Day = ' num2str(round(i*P.dt)) '; PV Injected =' num2str((i*P.dt*P.ut/P.porosity)/P.L)]);

                if rate > 0 
                    movie_frame = getframe(figure1);
                    writeVideo(writerObj,movie_frame);
                end

                drawnow()
           %pause(0.1)
            end

            if rate > 0 
                close(writerObj);
            end



            clear Mov rate i movie_frame ans figure1 writerObj
            disp('Done')
            pause(1)
            
elseif strcmp(reply,'10')


            reply = str2double(input('Incremental time steps: ', 's'));
            rate = str2double(input('Create movie? Frame rate (0=No movie): ', 's'));
            start_t = str2double(input('Start from day [1]: ', 's'));
            disp('Plotting...')

            if rate > 0 
                % Preallocate the struct array for the struct returned by getframe
                writerObj = VideoWriter('newfile.avi');
                writerObj.FrameRate = rate;
                open(writerObj);
                figure1 = figure('Color',[1 1 1],'Position',[0 0 800 600]);
            else
                figure1 = figure();
            end


            if isempty(start_t); start_t =1; end;



            for i = start_t/P.dt:reply:P.nt
                                
                plot(P.x,P.psi.Na(:,i),'r',P.x,C.Na(:,i),'g--',P.x,F.fw(:,i).*C.Na(:,i),'y--')
                %line([0 P.L],[Calcite.k(1,1) Calcite.k(1,1)],'Color','k','LineStyle','--')
                set(gca,'YGrid','on','XGrid','on','YScale','lin')
                ylabel('Limiter function')
                xlabel('x (m)')   
                legend('Limiter function \psi','C.Na','C.Na*F.fw')    
                ylim([0 2]);
                xlim([0 800]);
                title(['Day = ' num2str(round(i*P.dt)) '; PV Injected =' num2str((i*P.dt*P.ut/P.porosity)/P.L)]);

                if rate > 0 
                    movie_frame = getframe(figure1);
                    writeVideo(writerObj,movie_frame);
                end

                drawnow()
           %pause(0.1)
            end

            if rate > 0 
                close(writerObj);
            end


elseif strcmp(reply,'11')
    
            reply = str2double(input('Copare BL [1] or Ion [2]: ', 's'));
            
            if reply == 1
                

            disp('NB: The analytical solution is for a single water breakthrough ONLY!');
            reply = str2double(input('For what day do you want to plot the results: ', 's'));
           
            %ANALYTICAL

            % saturation
            %nsw     = 101;                   % number of gridpoints
            dsw     = (1-F.sor(1,1)-F.swc(1,1))/(P.nsw(1,1)-1);   
            sw      = F.swc(1,1):dsw:(1-F.sor);       % saturation range
            % relperms + mobility + fracflow
            krw     = F.krwe(1,1)*((sw-F.swc(1,1))/(1-F.swc(1,1)-F.sor(1,1))).^F.nw(1,1);
            kro     = F.kroe(1,1)*((1-sw-F.sor(1,1))/(1-F.swc(1,1)-F.sor(1,1))).^F.no(1,1);
            mob_w   = krw/F.visco_w;
            mob_o   = kro/F.visco_o;
            fw      = mob_w./(mob_w+mob_o);
            % fracflow derivative (numerical)
            rr      = 2:(P.nsw-1);
            dfw1    = [0 (fw(rr+1)-fw(rr-1))./(sw(rr+1)-sw(rr-1)) 0];
            vw      = P.ut/P.porosity*dfw1;
            % jump velocity 
            dfw2    = (fw - fw(1))./(sw-sw(1));
            [shock_vel, shock_index] = max(dfw2);
            shock_sat = sw(shock_index);
            rr2     = shock_index:P.nsw;
            % valid saturation range within BL solution
            sw2     = [sw(1)   sw(1)   sw(rr2)];
            vw2     = vw(rr2);
            vw2     = [1.5*vw2(1) vw2(1) vw2];
            t       = reply;
            x       = vw2*t;

            % plot of saturation as function of position
            %figure(1); 
            figure;
            hold on;            
            plot(P.x,F.Sw(:,reply/P.dt),'r-');
            plot(x,sw2,'--k','linewidth',1);
            xlabel('x [m]'); ylabel('S_w [-]');
            legend('Numerical','Analytical')
            xlim([0 P.L]);
            ylim([0 1]);
           hold off;
            else
                
            disp('NB: Make sure to only flood with water!');
            reply = str2double(input('For what day do you want to plot the results: ', 's'));
                      
           x = linspace(0,P.L,P.L/(P.ut*P.dt/P.porosity));
           y = ones(1, numel(x))*C_bc.Na(1,1);
           y(1:reply/P.dt) = fliplr(C_bc.Na(1,1:reply/P.dt));
           
           %y = C_bc.Na(1,reply/P.dt:reply/P.dt+numel(x)-1);
               
           %y = fliplr(y);
            
            % plot of saturation as function of position
            %figure(1); 
            figure;
            hold on;            
            plot(P.x,C.Na(:,reply/P.dt),'r-');
            plot(x,y,'--k','linewidth',1);
            xlabel('x [m]'); ylabel('C_{Na} [mol/kgw]');
            legend('Numerical','Analytical')
            xlim([0 P.L]);
            ylim([0 1]);
           hold off;
           
            end
            
            
            %Call epsSave
            epsSave
            
        elseif strcmp(reply,'12')

            disp('Plotting...')        

            %Oil Production
            %N_gridblocks = ((ones(nsw,nt) - sor - swc) - (ones(nsw,nt) - Sw - sor))/nsw;% / (nt * nsw);

            %N_gridblocks = ((ones(P.nsw,P.nt) .* (F.Sw - F.swc)) ./ (ones(P.nsw,P.nt).*(1-F.sor-F.swc)))/P.nsw;

            N_gridblocks = F.Sw -F.swc;
            N_cumulative = sum(N_gridblocks,1)/P.nsw;

            figure;
            hold on;
            
            if strcmp(P.h,'days'); ha=P.t; else ha=P.PV; end;
            plot(ha,F.fw(P.nsw,:));
            
            
            if strcmp(P.h,'days'); xlabel('t (days)'); else xlabel('PV'); end;
            ylabel('Water cut @ producer (-)')
            legend('Dimensionless Oil Production')
            ylim([0 1]);
            hold off;

            %Call epsSave
            epsSave

            clear ha
            disp('Done')
            pause(1)
            
        elseif strcmp(reply,'13')


             
          
            
            reply = str2double(input('Incremental time steps: ', 's'));
            rate = str2double(input('Create movie? Frame rate (0=No movie): ', 's'));
            start_t = str2double(input('Start from day [1]: ', 's'));
            disp('Plotting...')

            if rate > 0 
                % Preallocate the struct array for the struct returned by getframe
                writerObj = VideoWriter('summaryvideo.avi','Motion JPEG AVI');
                writerObj.FrameRate = rate;
                open(writerObj);
                figure1 = figure('Color',[1 1 1],'Position',[0 0 1600 1100]);
            else
                figure1 = figure();
            end




            if isempty(start_t); start_t =1; end;

            for i = start_t/P.dt:reply:P.nt
                
                subplot(2,2,1)
                
                %set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;1 1 0; 0 1 1; 1 0 1; 0 0 0],...
                %      'DefaultAxesLineStyleOrder','-|--|:','defaultlinelinewidth',2)                               
                plot(P.x,F.Sw(:,i),'k-',P.x,1-F.sor(:,i),'k--',P.x,ones(1,numel(F.sor(:,i)))'.*F.swc,'k-.')
                ylabel('S_w (-)')
                xlabel('x (m)')   
                legend('S_w','1-S_{or}','S_{wc}')    
                ylim([0 1]);
                xlim([0 800]);
                title(['Day = ' num2str(round(i*P.dt)) '; PV Injected =' num2str((i*P.dt*P.ut/P.porosity)/P.L)]); 
                
                subplot(2,2,2)

                %      set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;1 1 0; 0 1 1; 1 0 1; 0 0 0],...
                %      'DefaultAxesLineStyleOrder','-|--|:','defaultlinelinewidth',2)
                  
                N_gridblocks = F.Sw -F.swc;
                N_cumulative = sum(N_gridblocks,1)/P.nsw;

                if strcmp(P.h,'days'); ha=P.t; else ha=P.PV; end;
                plot(ha(1:i),N_cumulative(1:i))
                if strcmp(P.h,'days'); xlabel('t (days)'); else xlabel('PV'); end;
                ylabel('Fraction of STOIIP produced')
                legend('Dimensionless Oil Production')
                ylim([0 0.8]);
                hold off;
                if strcmp(P.h,'days'); xlim([0 7300]); else xlim([0 5]); end;
                
                title(['Day = ' num2str(round(i*P.dt)) '; PV Injected =' num2str((i*P.dt*P.ut/P.porosity)/P.L)]);                 
                 
                 subplot(2,2,[3 4])                
% 
% 
%                                 %Set axis properties. Enable gridlines.
%                 %set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1;1 1 0; 0 1 1; 1 0 1; 0 0 0],...
%                 %      'DefaultAxesLineStyleOrder','-|--|:','defaultlinelinewidth',2)
%                 %set(gca,'YGrid','on','XGrid','on')
%                 %hold on;
%                 %plot(PV,2*BaX2(:,gc),PV, HX(:,gc),PV, KX(:,gc),PV, 2*MgX2(:,gc),PV, 2*SrX2(:,gc),PV, 2*m_CaX2(:,gc),PV, m_NaX(:,gc),PV, LiX(:,gc),PV, 2*AlOHX2(:,gc),PV, 3*AlX3(:,gc),PV,IonStrength(:,gc),PV,sumX(:,gc))
% 
                 [ax,h1,h2] = plotyy(P.x,C.Na(:,i),P.x,F.pH(:,i),'semilogy','plot');
 
                 set(ax(1),'ylim',[1*10^-4 1])
                 set(ax(2),'ylim',[5 8])
                 set(ax(1),'xlim',[0 800])
                 set(ax(2),'xlim',[0 800])
 
                 set(ax(2),'YTick',[]) % Remove ticks of axis 2 (leaves right-hand ticks of axis 1)
                 set(ax(1),'Box','off') % Turn off box of axis 1, which removes its right-hand 
                 set(ax(1),'YTick',[1e-4 1e-3 1e-2 1e-1 1])
                 set(ax(2),'YTick',[5 6 7 8])
                 set(ax(1),'XTick',[0 100 200 300 400 500 600 700 800])
                 set(ax(2),'XTick',[])
 
                 set(ax(1),'XColor','k','YColor','k')
                 set(ax(2),'XColor','k','YColor','k')
 
                 set(h2,'LineStyle','-')
                 set(h2,'Color','y')
                 set(h2,'LineWidth',2)
 
                 set(h1,'LineStyle','-')
                 set(h1,'Color','g')
                 set(h1,'LineWidth',2)
 
                 y1label= get(ax(1),'ylabel');  % name the second axis y-label 
                 set(y1label,'String','C (mol/kgw), E (mol/gc)')%
                 y2label= get(ax(2),'ylabel');  % name the second axis y-label 
                 set(y2label,'String','pH (-)')%
% 
% 
                 hold(ax(1),'on')
                 h3 = semilogy(P.x,C.Ca(:,i),'r',P.x,X.Na(:,i),'g--',P.x,X.Ca(:,i),'r--');                                 
                 hold(ax(1),'off')
                 
                 legend([h1 h3(1) h3(2) h3(3) h2],'Na^+','Ca^{2+}','NaX','CaX_2','pH','Orientation','horizontal')                 
                 
                 %legend([h1 h3(1) h3(2) h3(3) h2],'Na^+','Ca^{2+}','NaX','CaX_2','pH','Location','NorthOutside','Orientation','horizontal')                
%                %legend('boxoff')
                 xlabel('x (m)')
                 
                 
                set(ax(1),'ylim',[1*10^-4 1])
                 set(ax(2),'ylim',[5 8])
                 set(ax(1),'xlim',[0 800])
                 set(ax(2),'xlim',[0 800])
 
                 set(ax(2),'YTick',[]) % Remove ticks of axis 2 (leaves right-hand ticks of axis 1)
                 set(ax(1),'Box','off') % Turn off box of axis 1, which removes its right-hand 
                 set(ax(1),'YTick',[1e-4 1e-3 1e-2 1e-1 1])
                 set(ax(2),'YTick',[5 6 7 8])
                 set(ax(1),'XTick',[0 100 200 300 400 500 600 700 800])
                 set(ax(2),'XTick',[])
 
                 set(ax(1),'XColor','k','YColor','k')
                 set(ax(2),'XColor','k','YColor','k')
 
                 set(h2,'LineStyle','-')
                 set(h2,'Color','y')
                 set(h2,'LineWidth',2)
 
                 set(h1,'LineStyle','-')
                 set(h1,'Color','g')
                 set(h1,'LineWidth',2)
%                 
% 






            
                



                if rate > 0 
                    movie_frame = getframe(figure1);
                    set(gcf,'Renderer','zbuffer');                    
                    writeVideo(writerObj,movie_frame);
                end

                drawnow()
           %pause(0.1)
            end

            if rate > 0 
                close(writerObj);
            end



            clear Mov rate i movie_frame ans figure1 writerObj
            disp('Done')
            pause(1)
          
            
    elseif strcmp(reply,'r')
       
                     
        if n==P.nt-1 
            reply = input('Restarting an already completed simulation will delete previous results. Are you sure you want to continue? [n] ', 's');       
            if reply=='y'
                disp('Restarting simulation...')        

                n=1;
                %Start simulation
                sim

                disp('Done')
                pause(1)   
            else
                disp('Aborted')                        
                pause(1)   
            end
        else

            disp('Restarting simulation...')        

            %Start simulation
            sim

            disp('Done')
            pause(1)  
        end      

    elseif strcmp(reply,'e')
        
        if strcmp(P.epsSave,'off')
            P.epsSave='on';
        else
            P.epsSave='off';
        end
        
        disp(['Set the eps save mode to ' P.epsSave]);
        pause(1);      
        
    elseif strcmp(reply,'h')
        
        if strcmp(P.h,'days')
            P.h='PVs';
        else
            P.h='days';
        end
        
        disp(['Changed horizontal axis to ' P.h]);
        pause(1);      
        
    elseif strcmp(reply,'c')
        disp('Closing image windows...');
        close all;

        disp('Done');
        pause(1);      
    elseif strcmp(reply,'q')
        disp('Program stopped')
        pause(1);  
        clc
        clear reply
        break;
    else       
        disp('Invalid option, try again')
        pause(1)
    end
      
end

