function [ w ] = f_przyn( u )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

w = zeros(1,3);

if u<45.0
    w(1)=1;
    w(2)=0;
    w(3)=0; 
elseif u<50.0
    w(1)=(55-u)*0.1;
    w(2)=(u-45)*0.2;
    w(3)=1-w(1);
elseif u<55.0
    w(1)=(55-u)*0.1;
    w(2)=(55-u)*0.2;
    w(3)= 1-w(1);
else 
    w(1)=0;
    w(2)=0;
    w(3)=1;
    
end


end

