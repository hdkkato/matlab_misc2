classdef pca < handle
    %UNTITLED2 このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties
        waveRegion
        spectra
        nFactor
        algorithm
        score
        loading
        tau
    end

    methods
        function pcaout = pca(waveRegion,spectra,nFactor,varargin)
            pcaout.waveRegion = waveRegion;
            pcaout.spectra = spectra;
            pcaout.nFactor = nFactor;
            if nargin == 3
                pcaout.algorithm = 'Nipals';
            elseif nargin == 4
                pcaout.algorithm = varargin{1};
            elseif nargin >= 5
                disp('Too many input arguments.')
                return;
            end

            if strcmpi(pcaout.algorithm,'Eig');
                [pcaout.score, pcaout.loading, pcaout.tau] = pcaeig(spectra,nFactor);
            elseif strcmpi(pcaout.algorithm,'Nipals');
                [pcaout.score, pcaout.loading, pcaout.tau] = pcanipals(spectra,nFactor);
            else 
                fprintf('Undefined variable %s\n',pcaout.algorithm);
                return;
            end
        end
        
        function plot(pca)
            plot(pca.waveRegion,pca.spectra)
        end
    end
    
end
    

function [score, loeading, tau] = pcanipals(x,nFactor)
%Principal component analysis using NIPALS algorithm
%
%x: input data
%nFactor: maximum number of PCs
%score: score
%loading: loading
%tau: eigenvalue
%
%For details please refar to:
%http://www.camo.com/downloads/U9.6%20pdf%20manual/The%20Unscrambler%20Method%20References.pdf

[m,n] = size(x);
score = zeros(m,nFactor);
loeading = zeros(n,nFactor);
tau = zeros(1,nFactor);

%caliculating default score t
xCentered = bsxfun(@minus,x,mean(x));
xVariance = var(xCentered);
t = xCentered(:,xVariance==(max(xVariance)));
xc = xCentered;

%NIPALS algorithm
for iFactor = 1:nFactor
    p = pinv(t'*t)*t'*xc;
    p = p';
    p = p./sqrt(p'*p);
    tnew = xc*p;
    tau(iFactor) = tnew'*tnew;
    score(:,iFactor) = tnew;
    loeading(:,iFactor) = p;
    t = tnew;
    xc = xc-t*p';
end
end

function [score,loading,tau] = pcaeig(x,nFactor)
            %Principal component analysis using eigenvalue decomposition
            %
            [m,n] = size(x);

            xCentered = bsxfun(@minus,x,mean(x));
            varCovarMatrix = (xCentered'*xCentered)./(m-1);

            [loading,tau] = eigs(varCovarMatrix,nFactor);
            score = xCentered*loading;
            tau = diag(tau)';

            end
            




