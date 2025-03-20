Ireal = imread('C:\Users\User\Desktop\We see you\WCU images\200f.jpg');
Iscan = imread('C:\Users\User\Desktop\We see you\WCU images\200RBI.jpg');

figure;
subplot(2,1,1);
imshow(Ireal)
subplot(2,1,2);
imshow(Iscan)

I1=im2double(Ireal);
I1 = rgb2gray(I1);
I2=im2double(Iscan);
I2 = rgb2gray(Iscan);
corners = detectMSERFeatures(I1);
  [features1, valid_corners1] = extractFeatures(I1, corners);
  figure; imshow(I1); hold on
  plot(valid_corners1);
corners2 = detectMSERFeatures(I2);
  [features2, valid_corners2] = extractFeatures(I2, corners2);
  figure; imshow(I2); hold on
  plot(valid_corners2);
indexpairs= matchFeatures(features1,features2);
matched_pt1=valid_corners1(indexpairs(:,1),:);
matched_pt2=valid_corners2(indexpairs(:,2),:);
showMatchedFeatures(I1,I2,matched_pt1,matched_pt2);
c=length(corners)
d=length(corners2)
c1=matched_pt1.Count;
disp(c1)
c2=matched_pt2.Count;
disp(c2)
if(c/d==1)
    h=msgbox("The note is Real")
else
    h=msgbox("The note is Fake")
end
