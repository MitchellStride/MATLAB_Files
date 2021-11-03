%Basic Cam Commands
% camList = webcamlist    %List System Cameras
% cam = webcam(1)         %Run once to init cam
% preview(cam);           %Open video stream
% img1 = snapshot(cam);   %Take img and store
% image(img1)             %Display captured img


% Take 10 snaps once every second
cam = webcam(1);
cam.Resolution = '1280x720'; % Highest availible resolution for my webcam
for i = 1:20
    img = snapshot(cam);  
    imwrite(img, i+".jpg");  % save images to files
    pause(5);
end
clear cam

% Take 10 snaps once every second
% for i = 1:10
%     img=imread(i+".jpg");
%     imshow(img);
%     i
%     pause(5);
% end

% Display those 10 snaps once every 5 secondsclear cam% clean up  or switch off camera%% Fun with Microphoned = daq.getDevices% shows your devicesmic=d(1)  % Displays range, sampling rate, channels  etc.audiorecorder% Display audiorecorder propertiesr = audiorecorder;disp('Start speaking.'),pause% press enter to start recordingrecordblocking(r,5);     % record for 5 secondsdisp('Start Playing'),pause% press enter to start playingplay(r);   % listen to recordingy = getaudiodata(r);plot(y);r = audiorecorder% Notice that my microphone has one channel (mono)r = audiorecorder(1000,8,1);% Record much slower 1kHz and playdisp('Start speaking.'),pause% press enter to start recordingrecordblocking(r,5);     % record for 5 secondsdisp('Start Playing'),pause% press enter to start playingplay(r);   % listen to recordingLecture 2 -2020 Page 7
% play(r);   % listen to recordingy1 = getaudiodata(r);plot(y1);% you will notice a significant drop in audio quality%% Matlab 2020a  has Audio Toolbox.  I think MUN did not pay for that.%[X,Y] = ginput(1)% gets  one data point from the mouse
