classdef Spec < handle
    
    properties
        WaveRegion
        Spectra
        SnvSpectra
    end
    methods
        function obj = Spec(wave,spec)
            obj.WaveRegion = wave;
            obj.Spectra = spec;
        end
        function snv(obj)
            [~,n] = size(obj.Spectra);
            rmean = mean(obj.Spectra,2);
            dr = bsxfun(@minus,obj.Spectra,rmean);
            obj.SnvSpectra = bsxfun(@rdivide,dr,sqrt(sum(dr.^2,2)/(n-1)));
        end
        function msc(obj,InputSpec,RefSpec)
            [m, n]=size(InputSpec);
            rs=RefSpec;
            cw=ones(1,n);
            mz=[];
            mz=[mz ones(1,n)'];
            mz=[mz rs'];
            [mm,nm]=size(mz);

            wmz=mz.*(cw'*ones(1,nm));
            wz=InputSpec.*(ones(m,1)*cw);
            z=wmz'*wmz;
            [u,s,v]=svd(z);
            sd=diag(s)'; 
            cn=10^12;
            ms=sd(1)/sqrt(cn);
            cs=max(sd,ms ); 
            cz=u*(diag(cs))*v';  
            zi=inv(cz);
            b=zi*wmz'*wz';B=b';
            x_msc=InputSpec; 
            p=B(:,1);
            x_msc=x_msc-(p*ones(1,mm));
            p=B(:,2);
            obj.MscSpectra=x_msc./(p*ones(mm,1)');
        end
        function splot(obj)
            plot(obj.WaveRegion,obj.Spectra);
        end
    end
    methods (Static)
        function showspec(spec)
        disp(spec)
        end
    end
end
