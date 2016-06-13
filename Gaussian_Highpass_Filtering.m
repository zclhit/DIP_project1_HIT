%Name:Gaussian_Highpass_Filtering
%function:利用高斯高通滤波器锐化图像
%Author:Changle Zhang
%Student ID:15S158746
clear all;
close all;
clc;                                                    %Initialization

img=imread('e.tif');                                    %Import image
imshow(img);
title('Image Before Sharpen');
[m n]=size(img);                                        %Get the image size m*n
%Generate normalization uniformly-spaced point in frequency domain
for i= 1:m
    if mod(n,2)==0                                      %n is even
        f1(i,:)=[-n+1:2:n-1]./(n-1);
        f2(:,i)=f1(i,:)';
    else                                                %n is odd
        f1(i,:)=[-n:2:n-2]./(n-1);
        f2(:,i)=f1(i,:)';
    end
end

D = 0.2;                                                %Gaussian end frequency 
r = f1.^2+f2.^2;                                        %Filerting radius
%Generate filering transformation H
for i =1:m
    for j = 1:n
        t=r(i,j)/(D*D);
        Hd(i,j)=1-exp(-t);
    end
end
X=fftshift(fft2(double(img)));                          %FFT
Y=X.*Hd;                                                %Apply high-pass filtering
output=abs(ifft2(ifftshift(Y)));                       %Ifft and get the real part
figure;
imshow(mat2gray(output),[]);
title('Image After High-Pass filtering');