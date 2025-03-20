clear all;
close all;
Ireal = imread('C:\Users\User\Desktop\We see you\WCU images\2000-RBI.png'); % Real
Iscaned= imread('C:\Users\User\Desktop\We see you\WCU images\scan.jpg'); % scaned
%%//Pre-analysis
Ireal=imresize('Ireal',[size('Iscaned',1) size('Iscaned',2)])
hsvImageReal = rgb2hsv(Ireal);
hsvImagescaned = rgb2hsv(Iscaned);
figure;
imshow([hsvImageReal(:,:,1) hsvImageReal(:,:,2) hsvImageReal(:,:,3)]);
title('Real pre process');
figure;
imshow([hsvImagescaned(:,:,1) hsvImagescaned(:,:,2) hsvImagescaned(:,:,3)]);
title('scaned');
%%//Initial segmentation
croppedImageReal = hsvImageReal(:,90:95,:);
croppedImagescaned = hsvImagescaned(:,93:98,:);
satThresh = 0.4;
valThresh = 0.3;
BWImageReal = (croppedImageReal(:,:,2) > satThresh & croppedImageReal(:,:,3) < valThresh);
figure;
subplot(1,2,1);
imshow(BWImageReal);
title('Real initial seg');
BWImagescaned = (croppedImagescaned(:,:,2) > satThresh & croppedImagescaned(:,:,3) < valThresh);
subplot(1,2,2);
imshow(BWImagescaned);
title('scaned');
%%//Post-process
se = strel('line', 6, 90);
BWImageCloseReal = imclose(BWImageReal, se);
BWImageClosescaned = imclose(BWImagescaned, se);
figure;
subplot(1,2,1);
imshow(BWImageCloseReal);
title('Real post process');
subplot(1,2,2);
imshow(BWImageClosescaned);
title('scaned');
%%//Area open the image
figure;
areaopenReal = bwareaopen(BWImageCloseReal, 15);
subplot(1,2,1);
imshow(areaopenReal);
title('Real area open image');
subplot(1,2,2);
areaopenscaned = bwareaopen(BWImageClosescaned, 15);
imshow(areaopenscaned);
title('scaned');
%//Count how many objects there are
[~,countReal] = bwlabel(areaopenReal);
[~,countscaned] = bwlabel(areaopenscaned);
disp(['The total number of black lines for the real note is: ' num2str(countReal)]);
disp(['The total number of black lines for the scaned note is: ' num2str(countscaned)]);
grt = rgb2gray(Ireal);
grs = rgb2gray(Iscaned);
% contrast enhance the gray image to emphasize dark lines in lighter background
grt = imadjust(grt);
grs = imadjust(grs);
% close rgb. choose a larger k. idea is to remove the dark line
k = 7;
se = ones(k);
Irealcl = imclose(Ireal, se);
Iscanedcl = imclose(Iscaned, se);
% convert closed image to gray scale
grtcl = rgb2gray(Irealcl);
grscl = rgb2gray(Iscanedcl);
% take the difference (closed-gray-scale - contrast-enhanced-gray-scale)
difft = grtcl - grt;
diffs = grscl - grs;
% take the projection of the difference
pt = sum(difft');
pf = sum(diffs');
% smooth the projection
ptfilt = conv(pt, ones(1, k)/k, 'same');
pffilt = conv(pf, ones(1, k)/k, 'same');
% threshold (multiplication by max element is just for visualization)
tht = (pt > graythresh(pt))*max(pt);
thf = (pf > graythresh(pf))*max(pf);
% get the number of segments. 
[lblt, nt] = bwlabel(tht);
[lblf, nf] = bwlabel(thf);
figure,
subplot(2, 1, 1), imshow(difft'), title('difference image for solid line')
subplot(2, 1, 2), imshow(diffs'), title('difference image for broken line')
figure,
subplot(2, 1, 1), plot(1:length(pt), pt, 1:length(pt), ptfilt, 1:length(pt), tht),
title('solid line image'),
legend('projection', 'smoothed', 'thresholded', 'location', 'eastoutside')
subplot(2, 1, 2), plot(1:length(pf), pf, 1:length(pf), pffilt, 1:length(pf), thf),
title('broken line image'),
legend('projection', 'smoothed', 'thresholded', 'location', 'eastoutside')
%%//Extract the black strips for each image
blackStripReal = Ireal(:,210:325,:);
blackStripscaned = Iscaned(:,210:325,:);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned Description');
%%//Convert into grayscale then threshold
blackStripReal = rgb2gray(blackStripReal);
blackStripscaned = rgb2gray(blackStripscaned);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned Description');
%%//Extract Gandhi
blackStripReal = Ireal(:,400:650,:);
blackStripscaned = Iscaned(:,400:650,:);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
%%//Convert into grayscale then threshold
blackStripReal = rgb2gray(blackStripReal);
blackStripscaned = rgb2gray(blackStripscaned);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
blackStripReal = Ireal(:,600:775,:);
blackStripscaned = Iscaned(:,600:775,:);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
%%//Convert into grayscale then threshold
blackStripReal = rgb2gray(blackStripReal);
blackStripscaned = rgb2gray(blackStripscaned);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
%%//2000 Below 
blackStripReal = Ireal(:,850:1100,:);
blackStripscaned = Iscaned(:,850:1100,:);
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
%%//Convert into grayscale then threshold
blackStripReal = rgb2gray(blackStripReal);
blackStripscaned = rgb2gray(blackStripscaned);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
%%//Ashoka emblem
blackStripReal = Ireal(:,1050:1145,:);
blackStripscaned = Iscaned(:,1090:1190,:);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
%%//Convert into grayscale then threshold
blackStripReal = rgb2gray(blackStripReal);
blackStripscaned = rgb2gray(blackStripscaned);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
%%// latent 
blackStripReal = Ireal(350:450,110:400,:);
blackStripscaned = Iscaned(350:450,110:400,:);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
%%//Convert into grayscale then threshold
blackStripReal = rgb2gray(blackStripReal);
blackStripscaned = rgb2gray(blackStripscaned);
figure;
subplot(1,3,1);
imshow(blackStripReal);
title('Original');
subplot(1,3,2);
imshow(blackStripscaned);
title('scaned');
%%// 
h= msgbox(['The Value is Rs.2000']);