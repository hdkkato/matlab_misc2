classdef RefValue < Spec
    %REFVALUE このクラスの概要をここに記述
    %   詳細説明をここに記述
    properties
        Referrence
    end
    
    methods
        function Ref = RefValue(ref, varargin)
            Ref = Ref@Spec(varargin{:});
            
            if nargin > 0
            Ref.Referrence = ref;
            end
        end
        function dispref(Ref)
            disp(Ref.Referrence)
        end
    end
    
end

