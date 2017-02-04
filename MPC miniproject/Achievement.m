function [ A ] = Achievement(x,y )
% x = intended emotion, y = rated
%   Detailed explanation goes here
C = 1.5; 
temp = 1/C*cov(x,y);
A = temp(2,1);
end

