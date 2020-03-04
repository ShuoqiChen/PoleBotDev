% videoHough takes a given video file, and runs an edge detection looking
% for pipes on it
%
% Author: James Wong

close all

v = VideoReader('pb_climb_test_short.mp4'); %Reads input from a given file
out = VideoWriter('full.avi', 'Motion JPEG AVI') %line detection video outputs to this file
w = 4000
out.FrameRate = 4;
open(out)

img = readFrame(v);
hold on

theta_prev = 400;

while hasFrame(v)
    img = readFrame(v);
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    
    %Separate the blue channel, and apply a filter to smooth edges
    justblue = 10*(g-r);
    justblue = (justblue > 100);
    ublu = uint8(100*justblue);
    justblue = imgaussfilt(ublu,2);
    
    %lines contains x,y points and rho/theta for edge detections
    lines = pipeHough(justblue);
    
    %initializes for finding max lines
    max_len = 0;
    max_len2 = 0;
    max_rho = 0;
    xy_long = [0,0,0,0];
    inter = false;
    
    for k = 1:length(lines)
        xy = [lines(k).point1 lines(k).point2];
        th = lines(k).theta;
        rho = lines(k).rho;
        len = norm(lines(k).point1 - lines(k).point2);
        
%         [inter] = lineIntersect(xy, xy_long, 0, 1000);
%         
%         if(true)
%             continue
%         end
        
        %Finds the two longest lines
        if (len > max_len)
            if max_len2 ~= 0
                max_len2 = max_len;
                xy_long2 = xy_long;
                this_theta_2 = this_theta;
            end
            max_len = len;
            xy_long = xy;
            max_rho = rho;
            this_theta = th;
        end
        if (len > max_len2 && len < max_len)
            max_len2 = len;
            xy_long2 = xy;
            this_theta_2 = th;
        end
        
    end
    
    
    RGB = img;
    
    %Plots all edge detections onto a copy of the original image, and saves
    %to the new video file
    for k = 1:length(lines)
        p1 = lines(k).point1;
        p2 = lines(k).point2;
        
        points = [p1(1,1), p1(1,2), p2(1,1), p2(1,2)];
        RGB = insertShape(RGB, 'Line', {points}, 'Color', {'green'}, 'LineWidth',5);
        
    end
    
    longest = [xy_long(1), xy_long(2), xy_long(3), xy_long(4)];
    RGB = insertShape(RGB, 'Line', {longest}, 'Color', {'red'}, 'LineWidth',5);
    
    longest2 = [xy_long2(1), xy_long2(2), xy_long2(3), xy_long2(4)];
    RGB = insertShape(RGB, 'Line', {longest2}, 'Color', {'red'}, 'LineWidth',5);
    
    middle = (longest+longest2)./2;
    RGB = insertShape(RGB, 'Line', {middle}, 'Color', {'cyan'}, 'LineWidth',5);
    
    writeVideo(out,RGB);
    
    theta_prev = this_theta;
end

close(out)
