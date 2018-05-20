function [EYE]=EYE(x)
EYE=cell(x,1);

for i=1:x
EYE{i} = eye(i);
end