%Basic Cam Commands
% camList = webcamlist    %List System Cameras
% cam = webcam(1)         %Run once to init cam
% preview(cam);           %Open video stream
% img1 = snapshot(cam);   %Take img and store
% image(img1)             %Display captured img


% Take 500 snaps at 10 second intervals 10 seconds
cam = webcam(1);
cam.Resolution = '1280x720'; % Highest availible resolution for my webcam
for i = 1:5
    img = snapshot(cam);  
    imwrite(img, i+".jpg");  % save images to files
    pause(1);
end
clear cam
