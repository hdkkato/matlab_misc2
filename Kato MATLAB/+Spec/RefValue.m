classdef RefValue < Spec
    %REFVALUE ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
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

