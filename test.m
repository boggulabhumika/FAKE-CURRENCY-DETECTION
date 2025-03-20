Ireal = imread('C:\Users\User\Desktop\We see you\WCU images\2000f2.jpg');
Iscan = imread('C:\Users\User\Desktop\We see you\WCU images\2000-RBI.png');
img=flipud(Ireal);

imshow(img)
axis xy
impixelinfo
figure;
Ireal=rgb2gray(Ireal)
regionsObj = detectMSERFeatures(Ireal);
c=length(regionsObj)
%[features, validPtsObj] = extractFeatures(Ireal, regionsObj);
imshow(Ireal); hold on;
%plot(validPtsObj,'showOrientation',true);
plot(regionsObj)
figure;
Iscan=rgb2gray(Iscan)
regionsObj2 = detectMSERFeatures(Iscan);
d=length(regionsObj2)
%[features, validPtsObj] = extractFeatures(Ireal, regionsObj);
imshow(Iscan); hold on;
%plot(validPtsObj,'showOrientation',true);
plot(regionsObj2)
disp(c)
disp(d)
indexpairs= mathFeatures(features1,features2);
matched_pt1=valid_corners1(indexpairs(:,1),:);
matched_pt2=valid_corners2(indexpairs(:,2),:);
showMatchedFeatures(I1,I2,matched_pt1,matched_pt2);

if(c/d==1)
    h=msgbox("The Note is Real");
else
    h=msgbox("The Note is Fake");
end
    