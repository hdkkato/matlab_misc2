classdef MyClass < handle
    properties
        output = 0;
    end
    
    methods(Static)
        function obj = MyClass(input)
            obj.output = input*2;
        end
        function print_output(obj)
            disp(obj.output);
        end
    
    end
end
