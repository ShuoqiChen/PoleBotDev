function [inter] = lineIntersect(xy, xy_long, lower, upper)
%lineIntersect checks whether xy and xy_long intersect over x = 0 to w

        p1x = xy(1);
        p1y = xy(2);
        p2x = xy(3);
        p2y = xy(4);
        p3x = xy_long(1);
        p3y = xy_long(2);
        p4x = xy_long(3);
        p4y = xy_long(4);
        
        m1 = (p1x-p2x)/(p1y-p2y);
        m2 = (p3x-p4x)/(p3y-p4y);
        
        p2y = p1y - m1*(p1x - upper);
        p1y = p1y - m1*(p1x);
        p1x = 0;
        p2x = upper;
        p4y = p3y - m2*(p3x - upper);
        p3y = p3y - m2*(p3x);
        p3x = 0;
        p4x = upper;
        
        
        A = [p1x - p3x, p2x - p3x; p1y - p3y p2y - p3y];
        B = [p1x-p4x, p2x-p4x; p1y-p4y, p2y-p4y];
        C = [p3x-p1x, p4x-p1x; p3y-p1y, p4y-p1y];
        D = [p3x-p2x, p4x-p2x; p3y-p2y, p4y-p2y];
        
        if (det(A)*det(B) < 0 || det(C)*det(D) < 0)
            inter= true;
        else
            inter = false;
        end
        


end

