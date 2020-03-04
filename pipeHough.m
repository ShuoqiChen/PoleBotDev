function lines = pipeHough(I)
%pipeHough takes an image and runs a canny edge detection with the Hough
%transform and returns the peaks from the Hough transform

BW = edge(I,'canny');
[H,T,R] = hough(BW);

P  = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));

lines = houghlines(BW,T,R,P,'FillGap',100,'MinLength',7);

i = 1;
j = 2;
curr_len = length(lines);
while i < (curr_len-1)
    while j < curr_len
        i;
        j;
        curr_len;
        lines(i).rho;
        lines(j).rho;
        if abs(lines(i).rho - lines(j).rho) <= 10
            xy1 = [lines(i).point1(1) lines(i).point1(2) lines(i).point2(1) lines(i).point2(2)];
            xy2 = [lines(j).point1(1) lines(j).point1(2) lines(j).point2(1) lines(j).point2(2)];
            upper = max([xy1(1) xy2(1) xy1(3) xy2(4)]);
            lower = min([xy1(1) xy2(1) xy1(3) xy2(4)]);
            cross = lineIntersect(xy1, xy2, lower, upper);
            [close, coords, rho, theta] = isClose(xy1, xy2, 20);
            if close
                lines(j) = [];
                lines(i) = [] ;
                c1 = length(lines);
                %                 pause
                p1 = [coords(1) coords(2)];
                p2 = [coords(3) coords(4)];
                lines(length(lines)+1).point1 = p1;
                lines(length(lines)).point2 = p2;
                lines(length(lines)).rho = rho;
                lines(length(lines)).theta = theta;
            elseif cross
                if lines(i).rho > lines(j).rho
                    lines(j) = [];
                    %                     c2 = length(lines)
                    %                     pause
                else
                    lines(i) = [];
                    %                     c3 = length(lines)
                    %                     pause
                end
            end
        end
        
        j = j + 1;
        curr_len = length(lines);
    end
    %         c_end = length(lines)
    
    %         pause
    i = i + 1;
end

end
