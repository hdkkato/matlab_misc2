classdef pcr < pca
    %REFVALUE このクラスの概要をここに記述
    %   詳細説明をここに記述
    properties
        refference
        yPrediction
        coefficient
    end
    
    methods
        function pcrout = pcr(refference, varargin)        
            pcrout = pcrout@pca(varargin{:});
            pcrout.refference = refference;
            x = pcrout.spectra;
            y = pcrout.refference;
            loading = pcrout.loading;
            score = pcrout.score;
            xCentered = bsxfun(@minus,x,mean(x));
            yCentered = bsxfun(@minus,y,mean(y));
            b = loading*pinv(score)*yCentered;
            yp = xCentered*b+mean(y);
            pcrout.coefficient = b;
            pcrout.yPrediction = yp;
        end
        function plot(pcr)
%             abline =@(a,b) (@(x) (b*x + a));
%             ezplot(abline(0,1),[min(pcr.refference) max(pcr.refference)]);
            abline = @(a,b,varargin) ezplot((@(x) b*x+a),varargin{:});
            abline(0,1,[min(pcr.refference),max(pcr.refference)])
            hold on;
            plot(pcr.refference,pcr.yPrediction,'o');
        end
    end
    
end


