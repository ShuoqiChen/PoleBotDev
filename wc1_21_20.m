clear camObject;
close all;
clear;

cam = webcam
joy = vrjoystick(1);

cam_on = true
%params = FisheyeParam()
workingDir = tempname;
mkdir(workingDir)
mkdir(workingDir,'images')

outputVideo = VideoWriter('vertical.avi');
outputVideo.FrameRate = 5;
open(outputVideo);

outputVideoLines = VideoWriter('lines.avi');
outputVideoLines.FrameRate = 5;
open(outputVideoLines);

i = 0

while (i < 20)
   
    img = snapshot(cam);
    lineIm = lines1_21_20(img);
    
    writeVideo(outputVideo, img);
    writeVideo(outputVideoLines, lineIm);
    
    if(button(joy, 1)==1)
        break
    end 
    i = i +1
end

close(outputVideo)
close(outputVideoLines)

clear('cam');