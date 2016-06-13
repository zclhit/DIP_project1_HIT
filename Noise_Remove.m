%Name:Noise_Remove
%function:ÀûÓÃ3*3ÖÐÖµÂË²¨Ä£°åÈ¥³ýº¬ÔëÉùÍ¼ÏñÖÐµÄ½·ÑÎÔëÉù
%Author:Changle Zhang
%Student ID:15S158746
clear all;
close all;
clc;                                                    %Initialization

img=imread('c.jpg');                                    %Import image
imshow(img);
title('Image With Salt&pipe Noise');
[m n]=size(img);

Nmax=3;                                                 %Max filtering Radius(Nmax must be odd)

imgn=zeros(m+2*Nmax+1,n+2*Nmax+1);
imgn(Nmax+1:m+Nmax,Nmax+1:n+Nmax)=img;

imgn(1:Nmax,Nmax+1:n+Nmax)=img(1:Nmax,1:n);                                     %Upper Expansion
imgn(1:m+Nmax,n+Nmax+1:n+2*Nmax+1)=imgn(1:m+Nmax,n:n+Nmax);                     %Right Expansion
imgn(m+Nmax+1:m+2*Nmax+1,Nmax+1:n+2*Nmax+1)=imgn(m:m+Nmax,Nmax+1:n+2*Nmax+1);   %Lower Expansion
imgn(1:m+2*Nmax+1,1:Nmax)=imgn(1:m+2*Nmax+1,Nmax+1:2*Nmax);                     %Left Expansion


[height, width]=size(imgn);                             %Size of Expansived Image
x1=double(imgn);
x2=x1;
for i=1:height-Nmax+1
    for j=1:height-Nmax+1
        c=x1(i:i+(Nmax-1),j:j+(Nmax-1));                %get the initial filtering point
        e=c(1,:);                                       %first row of matrix 'c'
        for u=2:Nmax
            e=[e,c(u,:)];                               %make 'c' a row vector 'e'   
        end
        n1=Nmax*Nmax;                                   %Number of pixel in model
        for l=1:n1-1                                    %Sort the row vector
            for q=1:n1-1
                if e(q)>e(q+1)
                    c1 = e(q);
                    e(q) = e(q+1);
                    e(q+1) = c1;
                end
            end
         end
        mm = e((n1+1)/2);                               %mm is the median number
        x2(i+(Nmax-1)/2,j+(Nmax-1)/2)=mm;               %assignment median value for the center point
    end
end 
%keep the unassignment points
d=uint8(x2);
figure;
imshow(d(Nmax+1:m+Nmax,Nmax+1:n+Nmax),[]);
title('Image After Noise Removement');