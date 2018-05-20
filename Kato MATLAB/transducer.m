classdef transducer < handle
    properties
        soundspeed = 1540;
        samplingfrequency = 100e6;
        centerfrequency = 3.5e6
        lambda
        temp = 0
    end
    
    methods
        function obj = transducer(f0,fS)
            if nargin == 0
            elseif nargin == 1
                obj.centerfrequency = f0;
            else
                obj.centerfrequency = f0;
                obj.samplingfrequency = fS;
            end
        end
        
        function print_soundspeed(obj)
            disp([num2str(obj.temp), ':soundspeed = ', num2str(obj.soundspeed)])
            obj.temp = obj.temp + 1;
        end
    
        function print_lambda(obj)
            lambda = obj.soundspeed  / obj.centerfrequency;
            disp(lambda)
            obj.lambda = lambda;
        end
    end
end
            