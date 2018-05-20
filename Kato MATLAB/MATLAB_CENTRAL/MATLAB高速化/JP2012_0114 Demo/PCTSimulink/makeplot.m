function set_timer
    warning off
    delete(timerfind)
    delete pworker* started
    T = timer;

    T.Period = 0.1;                       % ŽüŠú‚Í2•b
    T.ExecutionMode = 'fixedSpacing';   % ‘±‚¯‚ÄŽÀs‚·‚é
    T.TimerFcn = @findfiles;            % ‚±‚ÌŠÖ”‚ðŒÄ‚Ño‚·

    start(T);

function findfiles(~,~)
    %persistent f1b
    %persistent f2b
    persistent starttime
    persistent startproc ylimmax lastproc
    persistent h
    persistent h_num done needtorestart
    try
     if isempty(h)
         clf; colordef(gcf,'black');
       for k = 1:64, h(k) = subplot(8,8,k);
           set(h(k),'xticklabel',''); 
           cla;  end;
     end
     if isempty(done)
         done = zeros(64,1);
     end
    
%     if isempty(h_num)
%         h_num = 2;
%     end
    
    if isempty(dir('started'))
        return
    end
    if ~isempty(needtorestart) && needtorestart == 1
        h = [];
        done = [];
        needtorestart = 0;
        return
    end

    %hold on;    
    %if isempty(f1b)
    %    f1b = 0;
    %end
    %if isempty(f2b)
    %    f2b = 0;
    %end
    
    f = dir('pworker*');
    %f2 = dir('2');
    
%     if ~isempty(f1)
%     f1b_new = f1.bytes;
%     if f1b ~= f1b_new
%         plot(f1.bytes,1,'o');
%         f1b = f1b_new;
%     end
%     end
%     
%     if ~isempty(f2)
%     f2b_new = f2.bytes;
%     if f2b ~= f2b_new
%         plot(f2.bytes,2,'ro');
%         f2b = f2b_new;
%     end
%     end
%     
%     if ~isempty(f1)
%         f1b = f1.bytes;
%     end
%     if ~isempty(f2)
%         f2b = f2.bytes;
%     end
    PROC = 0;
    proc = 0;
    %done = zeros(1,64);
    if isempty(f)
        return
    end
    
    for k = 1:numel(f)
        
        fid = fopen(f(k).name,'r');
        PROCNEW = fread(fid,[101 64],'double');
        fclose(fid);
        cmap = jet(2*numel(f));
        for n = 1:64
            if ~done(n) && ~isnan(PROCNEW(1,n))
                done(n) = 1;
                subplot(8,8,n), p = plot(PROCNEW(:,n),'linewidth',2);
                set(h(n),'xticklabel','');
                set(p,'color',0.5+0.5*cmap(2*k-1,:));
                grid
                xlim([0 101]);
            end
        end
    end
    drawnow;
    
    if all(done(:))
        %disp('ALL DONE!');
        done = 0*done;
        %pause(2);
        needtorestart = 1;
    end
    
%     if (isempty(starttime) && proc > 0) || (~isempty(lastproc) && proc < lastproc)
%          starttime = tic;
%          startproc = proc;
%          lastproc = proc;
%          return
%      end
%     
%     if ~isempty(starttime) && proc > 0 && any(~PROC)
%             title(num2str(toc(starttime)),'fontsize',20);
%     end
%     drawnow;
%     
%     %proc = (f1b+f2b);
%     cmap = jet(k+1); cmap(1,:) = 0;
%     colormap(cmap);
%     L = sqrt(numel(PROC));
%     PROC = reshape(PROC,L,[])' + 1;
%     set(h,'Cdata',PROC,'cdatam','d');
%     
%     axis([0.5 L+0.5 0.5 L+0.5]);
%     set(gca,'ytick',0.5+[0:1:ceil(max(ylim))]);
%     set(gca,'xtick',0.5+[0:1:ceil(max(ylim))]);
%     set(gca,'xtickl',cellstr(num2str((0:L)')));
%     set(gca,'ytickl',cellstr(num2str((0:L)')));
%     
%     drawnow;
%     
%      lastproc = proc;
%     spd = (proc - startproc) / toc(starttime);
%     
%     
%     set(h(h_num),'Ydata',spd );
%     P = (spd/max(ylim));
%     %set(h(h_num),'facecolor', min([1 1 1],([0 1 0] + [1 -1 0]*P) * (1 + 4*(P-P^2))) );
%     set(h(h_num),'facecolor', hsv2rgb([1/3-P/3 1 1]) );
%     
%     P = get(h(3-h_num),'ydata')/max(ylim);
%     set(h(3-h_num),'facecolor', hsv2rgb([1/3-P/3 1 1]) );
%     
%     
%     xlim([0 3]);
%     
%     drawnow;
%     set(gcf,'name',num2str(spd));
    catch
        %keyboard
    end
        