function lines = pipeHough(I)
%pipeHough takes an image and runs a canny edge detection with the Hough
%transform and returns the peaks from the Hough transform

BW = edge(I,'canny');
[H,T,R] = hough(BW);

P  = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));

lines = houghlines(BW,T,R,P,'FillGap',100,'MinLength',7);

end