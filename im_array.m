function [images] = im_array()
video_size=256;

[FileName1,PathName1] = uigetfile('D:/DWT_FracOrderSVD/*','Select the input video...');
myVid= VideoReader(fullfile(PathName1,FileName1));
numFrames= myVid.NumberOfFrames;
images = cell(numFrames,1);
fn = fullfile('D:\DWT_FracOrderSVD\OriginalVideoFrames\',FileName1);
 if exist(fn, 'dir')
 else
 mkdir(fn);
 end
for i=1:numFrames    
    currentFrame= read(myVid,i);
    currentFrame=imresize(currentFrame,[video_size video_size]);
    images{i}=currentFrame;
    combinedString1=strcat('D:\DWT_FracOrderSVD\OriginalVideoFrames\',FileName1,'\',int2str(i),'.jpg');
    imwrite(currentFrame,combinedString1);
end
    


end