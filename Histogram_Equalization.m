%Name:Histogram_Equalization
%function:对直方图进行均衡化处理实现图像增强
%Author:Changle Zhang
%Student ID:15S158746
clear all;
close all;
clc;                                  %Initialization

fig = imread('a.jpg');                %import the image
subplot(121)
plot(fig);
title('(a)Gray distribution of image befort process');

[row,col] = size(fig);                %Image size
PixelsNum = row * col;                %Number of Pixels
freq = zeros(256,1);                  %record frequency of each gray level
prob = zeros(256,1);                  %record probability of each gray level
%calculate frequency and probability
for i = 1:row
    for j= 1:col
        value = fig(i,j);
        freq(value+1) = freq(value+1) + 1;
        prob(value+1) = freq(value+1) / PixelsNum;
    end
end

cums = zeros(256,1);                  %record the  cumulative distribution
probc = zeros(256,1);                 %record the probability of each distribution
output = zeros(256,1);                %gray level after H_E
counter = 0;
graylevel = 255;
%calculate cumulative distribution and output gray level
for i = 1:size(prob)
    counter = counter + freq(i);
    cums(i) = counter;
    probc(i) = cums(i) / PixelsNum;
    output(i) = round(probc(i) * graylevel);
end
%HE process
outputimage = uint8(zeros(row,col));  %Final image
for i = 1:row
    for j = 1:col
        outputimage(i,j) = output(fig(i,j)+1);
    end
end
%outputing
subplot(122)
plot(outputimage);
title('(b)Gray distribution of image after process');
figure
imshow(fig);
title('Image before histogram equalization');
figure
imshow(outputimage);
title('Image after histogram equalization');