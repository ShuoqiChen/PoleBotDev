function [bool, new_coords, rho, theta] = isClose(line1,line2, error)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    
    d13 = sqrt((line2(1)-line1(1))^2+(line2(2)-line1(2))^2);
    d14 = sqrt((line2(3)-line1(1))^2+( line2(4)-line1(2))^2);
    d23 = sqrt((line2(1)-line1(3))^2+(line2(2)-line1(4))^2);
    d24 = sqrt((line2(3)-line1(3))^2+(line2(4)-line1(4))^2);
    
    if d13 < error || d14 < error || d23 < error || d24 < error
        new_coords = [min(line1(1),line2(1)), min(line1(2), line2(2)), max(line1(3), line2(3)), max(line1(4),line2(4))];
        bool = true;
        rho = sqrt((new_coords(3)-new_coords(1))^2+(new_coords(4)-new_coords(2))^2);
        theta = atan((new_coords(4)-new_coords(2))/(new_coords(3)-new_coords(1)));
    else
        bool = false;
        new_coords = [];
        rho = 0;
        theta = 0 ;
    end
    
    
end

